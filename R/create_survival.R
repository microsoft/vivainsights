# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See LICENSE.txt in the project root for license information.
# --------------------------------------------------------------------------------------------

#' @title Kaplanu2013Meier Survival Utilities and Workflow
#'
#' @description
#' A small collection of utilities and a high-level wrapper to compute and
#' render Kaplanu2013Meier survival curves per segment. The module provides:
#' - A lightweight pure-R Kaplanu2013Meier implementation (.km_curve) used as a
#'   fallback for environments where a survival dependency is not desired.
#' - Calculation routines to aggregate data, enforce minimum group sizes, and
#'   return long-format survival tables per segment.
#' - Plotting utilities that render step-function survival curves using ggplot2.
#' - A wrapper (`create_survival`) that returns either a ggplot object or a
#'   long-format survival table depending on `return_type`.
#' @author Carlos Morales Torrado <carlos.morales@@microsoft.com>
#' @author Martin Chan <martin.chan@@microsoft.com>
#'
#' @template spq-params
#' @param metric Character string containing the name of the metric,
#' e.g. "Collaboration_hours"
#'
#' @section Features:
#' * Supports grouped survival computation with minimum-group filtering.
#' * Optional auto-segmentation via vivainsights::identify_usage_segments().
#' * Preserves canonical segment ordering and label synonyms for consistent plotting.
#'
#' @section Dependencies:
#' - Required: dplyr, tidyr, ggplot2, cowplot
#' - Optional: vivainsights (for auto-segmentation and optional date-range captions)
#'
#' @family Survival
#' @family Visualization
#' @keywords survival kaplan-meier visualization segments
#' @examples
#' \dontrun{
#' pq <- load_pq_data()
#' # Compute survival table
#' tbl <- create_survival(pq, time_col = "Days_active", event_col = "Churned", return_type = "table")
#'
#' # Plot survival curves
#' p <- create_survival(pq, time_col = "Days_active", event_col = "Churned")
#' }
#' create_survival: Kaplanu2013Meier survival workflow (calc + viz + wrapper)
#'
#' Reuses identify_usage_segments when needed; returns plot or table.
#'
#' @name create_survival_overview
#' @noRd
NULL
# ---- Imports ------------------------------------------------------------------
#' @import dplyr
#' @import tidyr
#' @import ggplot2
#' @importFrom cowplot ggdraw draw_plot draw_label
#' @importFrom rlang .data
#' @importFrom stats setNames


# ---------- Constants / defaults ----------
CANONICAL_ORDER <- c("Power User", "Habitual User", "Novice User", "Low User", "Non-user")
DEFAULT_SYNONYMS <- c(
  "Power Users"  = "Power User",
  "Power user"   = "Power User",
  "Habitual Users" = "Habitual User",
  "Novice Users" = "Novice User",
  "Novice user"  = "Novice User",
  "Low Users"    = "Low User",
  "Low users"    = "Low User",
  "Non-users"    = "Non-user",
  "Non user"     = "Non-user",
  "Non Users"    = "Non-user"
)

DEFAULT_COPILOT_METRICS <- c(
  "Copilot_actions_taken_in_Teams",
  "Copilot_actions_taken_in_Outlook",
  "Copilot_actions_taken_in_Excel",
  "Copilot_actions_taken_in_Word",
  "Copilot_actions_taken_in_Powerpoint"
)

# Infix helpers
source("R/utils-infix.R")
# ---------- Helpers ----------
##' Canonicalize segment labels
##'
##' Map variant segment labels to canonical names using a named synonyms map.
##' Keeps segment labels consistent across calculations and plotting.
##'
##' @param df Data frame containing the segment column.
##' @param segment_col Character. Name of the segment column in `df`.
##' @param synonyms_map Named character vector mapping variant -> canonical label.
##' @return Data frame with canonicalized segment column as character.
##' @keywords internal
canonicalize_segments <- function(df, segment_col, synonyms_map) {
  if (!segment_col %in% names(df)) return(df)
  out <- df
  out[[segment_col]] <- as.character(out[[segment_col]])
  if (!is.null(synonyms_map) && length(synonyms_map) > 0) {
    keys <- names(synonyms_map)
    m <- match(out[[segment_col]], keys, nomatch = 0)
    repl <- m > 0
    out[[segment_col]][repl] <- unname(synonyms_map[m[repl]])
  }
  out
}

legend_position_from_loc <- function(loc, bbox_to_anchor = c(1.3, 1.1)) {
  switch(tolower(loc),
         "upper right" = c(0.90, 0.90),
         "upper left"  = c(0.10, 0.90),
         "lower right" = c(0.90, 0.10),
         "lower left"  = c(0.10, 0.10),
         "right"       = "right",
         "left"        = "left",
         "top"         = "top",
         "bottom"      = "bottom",
         c(0.90, 0.90))
}

.km_curve <- function(durations, events, timeline = NULL) {
  ##' Pure-R Kaplanu2013Meier curve calculator (lightweight fallback)
  ##'
  ##' Compute Kaplanu2013Meier survival estimates at each timepoint in `timeline`.
  ##' This is a small, dependency-free implementation used as a fallback when
  ##' a dedicated survival package is not desired.
  ##'
  ##' @param durations Numeric vector of observed durations (time-to-event or censoring).
  ##' @param events Integer or logical vector indicating event occurrence (1 for event, 0 for censored).
  ##' @param timeline Optional numeric vector of time points to evaluate; if NULL uses unique sorted durations.
  ##' @return data.frame with columns: time, at_risk, events, survival.
  ##' @keywords internal
  
  d <- as.numeric(durations)
  e <- as.integer(events)
  ok <- !is.na(d) & !is.na(e)
  d <- d[ok]; e <- e[ok]

  if (is.null(timeline)) {
    timeline <- sort(unique(d))
  } else {
    timeline <- sort(as.numeric(timeline))
  }

  S <- 1.0
  surv <- numeric(length(timeline))
  at_risk_seq <- integer(length(timeline))
  events_seq  <- integer(length(timeline))

  for (i in seq_along(timeline)) {
    t <- timeline[i]
    at_risk <- sum(d >= t)
    d_t     <- sum(d == t & e == 1L)
    at_risk_seq[i] <- at_risk
    events_seq[i]  <- d_t
    if (at_risk > 0) {
      S <- S * (1 - d_t / at_risk)
    }
    surv[i] <- S
  }

  data.frame(
    time = timeline,
    at_risk = at_risk_seq,
    events = events_seq,
    survival = surv,
    check.names = FALSE
  )
}

# =========================
# 1) CALC (unchanged logic)
# =========================
#' @title Compute Kaplanu2013Meier survival curves per group
#'
#' @description
#' Compute Kaplanu2013Meier survival curves for one or more groups (segments).
#' Returns a list with a long-format survival table (group, time, survival, at_risk, events)
#' and a counts table used for applying minimum-group filters.
#'
#' @param data Data frame containing time, event and optional group columns.
#' @param time_col Character. Name of the time-to-event column.
#' @param event_col Character. Name of the event indicator column (1=event, 0=censored).
#' @param group_col Character or NULL. Group/segment column name (default: "UsageSegments_12w").
#' @param id_col Character. Person identifier column for distinct counts (default: "PersonId").
#' @param mingroup Integer. Minimum unique people required to keep a group (default: 5).
#' @param timeline Numeric or NULL. Time points where survival is evaluated (default uses unique times).
#' @param dropna Logical. Drop rows with NA in time/event when TRUE (default TRUE).
#' @param use_survival Logical. Reserved for future use; currently ignored in this implementation.
#' @return A list with elements `survival_long` (data.frame) and `counts` (data.frame).
#' @export
create_survival_calc <- function(data,
                                 time_col,
                                 event_col,
                                 group_col = "UsageSegments_12w",
                                 id_col = "PersonId",
                                 mingroup = 5,
                                 timeline = NULL,
                                 dropna = TRUE,
                                 use_survival = TRUE) {

  req_cols <- c(time_col, event_col, if (!is.null(group_col)) group_col)
  miss <- setdiff(req_cols, names(data))
  if (length(miss) > 0) stop("Missing required columns: ", paste(miss, collapse = ", "))

  df <- data

  # pandas parity: drop NA group keys before grouping
  if (!is.null(group_col) && group_col %in% names(df)) {
    df <- df %>% dplyr::filter(!is.na(.data[[group_col]]))
  }

  # Drop time/event NA only if requested
  if (isTRUE(dropna)) {
    df <- df %>% tidyr::drop_na(dplyr::all_of(c(time_col, event_col)))
  }

  # counts for mingroup
  if (!is.null(group_col)) {
    if (!is.null(id_col) && id_col %in% names(df)) {
      counts <- df %>%
        dplyr::group_by(.data[[group_col]]) %>%
        dplyr::summarise(n = dplyr::n_distinct(.data[[id_col]], na.rm = TRUE), .groups = "drop") %>%
        stats::setNames(c(group_col, "n"))
    } else {
      counts <- df %>%
        dplyr::group_by(.data[[group_col]]) %>%
        dplyr::summarise(n = dplyr::n(), .groups = "drop") %>%
        stats::setNames(c(group_col, "n"))
    }
    keep_groups <- counts %>% dplyr::filter(.data[["n"]] >= mingroup) %>% dplyr::pull(!!group_col)
    df <- df %>% dplyr::filter(.data[[group_col]] %in% keep_groups)
    counts <- counts %>% dplyr::filter(.data[[group_col]] %in% keep_groups)
  } else {
    counts <- data.frame(group = "Overall", n = nrow(df))
  }

  # Build curves
  curves <- list()
  if (is.null(group_col)) {
    groups <- "Overall"
  } else {
    groups <- sort(unique(as.character(df[[group_col]])))
  }

  for (g in groups) {
    sdf <- if (is.null(group_col)) df else df[df[[group_col]] == g, , drop = FALSE]
    if (nrow(sdf) == 0) next

    durs <- sdf[[time_col]]
    evts <- sdf[[event_col]]
    tl <- timeline

    out <- .km_curve(durations = durs, events = evts, timeline = tl)

    grp_name <- if (is.null(group_col)) "group" else group_col
    out[[grp_name]] <- g
    curves[[length(curves) + 1L]] <- out
  }

  if (length(curves) == 0) {
    grp_name <- if (is.null(group_col)) "group" else group_col
    survival_long <- data.frame(
      setNames(list(character(0)), grp_name),
      time = numeric(0),
      survival = numeric(0),
      at_risk = integer(0),
      events = integer(0),
      check.names = FALSE
    )
  } else {
    survival_long <- dplyr::bind_rows(curves)
    grp_name <- if (is.null(group_col)) "group" else group_col
    survival_long <- survival_long[, c(grp_name, "time", "survival", "at_risk", "events")]
    rownames(survival_long) <- NULL
  }

  list(survival_long = survival_long, counts = counts)
}

# =========================
# 2) VIZ (bar-style formatting; no orange line/box)
# =========================
#' @title Render Kaplanu2013Meier survival plot
#'
#' @description
#' Render Kaplanu2013Meier step curves for each group using ggplot2. The plot
#' includes standard title/subtitle/caption handling and optional legend placement.
#'
#' @param survival_long Data frame returned by create_survival_calc (long format).
#' @param group_col Character. Name of the group/segment column in `survival_long`.
#' @param figsize Numeric length-2; used for saving (ggplot objects are size-less).
#' @param title,subtitle,caption Character strings for ggplot annotations.
#' @param legend_loc Legend placement keyword (e.g., "upper right").
#' @param legend_bbox_to_anchor Numeric length-2; kept for API parity.
#' @param order Optional character vector specifying group order to display.
#' @param linewidth Numeric; line width for step curves.
#' @param missing_draw Character; how to render requested-but-missing groups ("nan" or "one").
#' @return ggplot object.
#' @export
create_survival_viz <- function(survival_long,
                                group_col = "UsageSegments_12w",
                                figsize = c(8, 6),
                                title = NULL,
                                subtitle = NULL,
                                caption = NULL,
                                legend_loc = "upper right",
                                legend_bbox_to_anchor = c(1.3, 1.1),
                                order = NULL,
                                linewidth = 2.0,
                                missing_draw = c("nan","one")) {

  missing_draw <- match.arg(missing_draw)

  groups_present <- if (nrow(survival_long) > 0) unique(as.character(survival_long[[group_col]])) else character(0)
  groups <- if (!is.null(order)) {
    c(intersect(order, groups_present), setdiff(groups_present, order))
  } else {
    groups_present
  }
  # Relevel the grouping column to match the computed groups order
  survival_long[[group_col]] <- factor(survival_long[[group_col]], levels = groups)

  p <- ggplot(survival_long,
              aes(x = .data$time, y = .data$survival,
                  colour = .data[[group_col]], group = .data[[group_col]])) +
    geom_step(linewidth = linewidth) +
    scale_y_continuous(limits = c(0, 1), expand = expansion(mult = c(0, 0.02))) +
    guides(colour = guide_legend(title = NULL)) +
    labs(
      title = title %||% NULL,
      subtitle = subtitle %||% NULL,
      caption = caption %||% NULL,
      x = "Time",
      y = "Survival probability"
    ) +
    theme_minimal(base_size = 11)

  # Draw dashed 1.0 line for requested-but-missing groups
  if (!is.null(order) && length(groups_present) > 0 && missing_draw == "one") {
    t_min <- min(survival_long$time, na.rm = TRUE)
    t_max <- max(survival_long$time, na.rm = TRUE)
    missing_groups <- setdiff(order, groups_present)
    if (length(missing_groups) > 0) {
      p <- p + geom_step(
        data = data.frame(
          time = c(t_min, t_max),
          survival = c(1, 1),
          tmp_group = rep(missing_groups, each = 2)
        ),
        aes(x = .data$time, y = .data$survival, colour = .data$tmp_group, group = .data$tmp_group),
        linewidth = linewidth, linetype = "dashed", inherit.aes = FALSE
      )
    }
  }

  # Legend placement (match radar viz behavior)
  leg_pos <- legend_position_from_loc(legend_loc)
  ggver <- tryCatch(utils::packageVersion("ggplot2"), error = function(e) "0.0.0")
  use_inside <- is.numeric(leg_pos)
  use_new_inside <- use_inside && (!inherits(ggver, "character")) && ggver >= "3.5.0"
  if (is.character(leg_pos)) {
    p <- p + theme(legend.position = leg_pos)
  } else if (use_new_inside) {
    p <- p + theme(legend.position = "inside", legend.position.inside = leg_pos)
  } else {
    p <- p + theme(legend.position = leg_pos)
  }

  # Theme aligned with create_radar_viz (bar-style)
  p + theme(
    plot.title = element_text(face = "bold"),
    plot.title.position = "plot",
    plot.subtitle = element_text(),
    plot.caption.position = "plot",
    panel.grid.major = element_line(linewidth = 0.3),
    panel.grid.minor = element_blank()
  )
}

# =========================
# 3) WRAPPER (unchanged behavior; formatting via labs/theme)
# =========================
#' @title High-level survival wrapper
#'
#' @description
#' Compute and return Kaplanu2013Meier survival estimates either as a long-format
#' table or as a ggplot object. Supports optional auto-segmentation via
#' vivainsights::identify_usage_segments(), canonicalization of segment labels,
#' and enforcement of required segment ordering for plotting.
#'
#' @param data Data frame with time, event, and optional segmentation columns.
#' @param time_col Character. Column name for time-to-event.
#' @param event_col Character. Column name for event indicator (1=event, 0=censored).
#' @param group_col Character or NULL. Group/segment column name (default: "UsageSegments_12w").
#' @param auto_segment_if_missing Logical; if TRUE, tries vivainsights::identify_usage_segments() when group_col missing.
#' @param identify_metric Single metric name used for auto-segmentation.
#' @param identify_metric_str Character vector of metric names to sum for segmentation.
#' @param identify_version Version string passed to identify_usage_segments (default "12w").
#' @param threshold,width,max_window,power_thres Reserved / passed to identify (optional tuning args).
#' @param id_col Character. Person ID column (default: "PersonId").
#' @param required_segments Character vector of canonical segments to enforce.
#' @param synonyms_map Named vector mapping variants -> canonical labels.
#' @param enforce_required_segments Logical; if TRUE, force required segment ordering.
#' @param mingroup Minimum unique people to retain a group (default: 5).
#' @param timeline Numeric or NULL. Time points for survival evaluation.
#' @param dropna Logical. Drop NA time/event rows when TRUE (default TRUE).
#' @param use_survival Logical. Reserved for future extension.
#' @param return_type "plot" or "table" (default: "plot").
#' @param figsize Numeric length-2 for saved figure size.
#' @param title,subtitle,caption_text Plot annotation strings.
#' @param caption_from_date_range Logical; if TRUE and vivainsights available, append date-range to caption.
#' @param legend_loc Legend placement keyword.
#' @param legend_bbox_to_anchor Kept for API parity.
#' @param linewidth Numeric line width for plot curves.
#' @param missing_draw Character. How to draw requested-but-missing groups ("nan" or "one").
#' @return If `return_type = "table"`: data.frame with columns (group, time, survival, at_risk, events).
#' If `return_type = "plot"`: ggplot2 object with Kaplanu2013Meier curves.
#' @examples
#' \dontrun{
#' pq <- load_pq_data()
#' # Table output
#' tbl <- create_survival(pq, time_col = "Days_active", event_col = "Churned", return_type = "table")
#' # Plot output
#' p <- create_survival(pq, time_col = "Days_active", event_col = "Churned")
#' }
#' @export
create_survival <- function(data,
                            time_col,
                            event_col,
                            # segmentation
                            group_col = "UsageSegments_12w",
                            auto_segment_if_missing = TRUE,
                            identify_metric = NULL,            # single metric name
                            identify_metric_str = NULL,        # character vector to sum
                            identify_version = "12w",
                            threshold = NULL, width = NULL, max_window = NULL, power_thres = NULL,
                            id_col = "PersonId",
                            required_segments = NULL,
                            synonyms_map = NULL,
                            enforce_required_segments = TRUE,
                            mingroup = 5,
                            # calc
                            timeline = NULL,
                            dropna = TRUE,
                            use_survival = TRUE,
                            # output
                            return_type = c("plot","table"),
                            # viz
                            figsize = c(8, 6),
                            title = "Survival Curve by Segment",
                            subtitle = "Kaplanu2013Meier estimate",
                            caption_from_date_range = TRUE,
                            caption_text = NULL,
                            legend_loc = "upper right",
                            legend_bbox_to_anchor = c(1.3, 1.1),
                            linewidth = 2.0,
                            missing_draw = c("nan","one")) {

  return_type <- match.arg(return_type)
  missing_draw <- match.arg(missing_draw)

  df <- data
  synonyms_map <- synonyms_map %||% DEFAULT_SYNONYMS
  required_segments <- required_segments %||% CANONICAL_ORDER

  # ---- Auto-identify usage segments if needed (R-safe; no custom header changes) ----
  if (!is.null(group_col) && !(group_col %in% names(df)) && isTRUE(auto_segment_if_missing)) {
    if (!requireNamespace("vivainsights", quietly = TRUE)) {
      stop("vivainsights::identify_usage_segments is required for auto-segmentation but is not installed.")
    }
    if (is.null(identify_metric) && is.null(identify_metric_str)) {
      identify_metric_str <- DEFAULT_COPILOT_METRICS
    }

    metric_to_use <- identify_metric
    if (is.null(metric_to_use) && !is.null(identify_metric_str)) {
      present <- intersect(identify_metric_str, names(df))
      if (length(present) == 0) {
        stop("None of the metrics in `identify_metric_str` are present in `data`.")
      }
      tmp_col <- "__idus_sum__"
      df[[tmp_col]] <- rowSums(df[, present, drop = FALSE], na.rm = TRUE)
      metric_to_use <- tmp_col
    }

    df <- vivainsights::identify_usage_segments(
      data    = df,
      metric  = metric_to_use,
      version = identify_version
    )

    if (exists("tmp_col") && tmp_col %in% names(df)) {
      # df[[tmp_col]] <- NULL  # keep or drop as you like
    }
  }

  # Canonicalize segments
  if (!is.null(group_col)) {
    df <- canonicalize_segments(df, group_col, synonyms_map)
  }

  # Caption
  caption <- ""
  if (isTRUE(caption_from_date_range) && requireNamespace("vivainsights", quietly = TRUE)) {
    caption <- tryCatch(vivainsights::extract_date_range(df, return_type = "text"),
                        error = function(e) "")
  }
  if (!is.null(caption_text) && nzchar(caption_text)) {
    caption <- if (nzchar(caption)) paste0(caption, " | ", caption_text) else caption_text
  }

  # Compute curves (unchanged)
  calc_res <- create_survival_calc(
    data = df,
    time_col = time_col,
    event_col = event_col,
    group_col = group_col,
    id_col = id_col,
    mingroup = mingroup,
    timeline = timeline,
    dropna = dropna,
    use_survival = use_survival
  )
  survival_long <- calc_res$survival_long

  # Canonicalize again
  if (!is.null(group_col)) {
    survival_long <- canonicalize_segments(survival_long, group_col, synonyms_map)
  }

  # Return table?
  if (identical(return_type, "table")) {
    grp_col <- if (is.null(group_col)) "group" else group_col
    if (isTRUE(enforce_required_segments) && !is.null(required_segments)) {
      survival_long[[grp_col]] <- factor(as.character(survival_long[[grp_col]]),
                                         levels = required_segments, ordered = TRUE)
      survival_long <- survival_long %>% dplyr::arrange(.data[[grp_col]], .data$time)
      survival_long[[grp_col]] <- as.character(survival_long[[grp_col]])
    }
    out <- survival_long[, c(grp_col, "time", "survival", "at_risk", "events")]
    rownames(out) <- NULL
    return(out)
  }

  # Plot (bar-style formatting like create_radar_viz)
  base_title <- title %||% "Survival Curve by Segment"
  create_survival_viz(
    survival_long = survival_long,
    group_col = group_col %||% "group",
    figsize = figsize,
    title = base_title,
    subtitle = subtitle,
    caption = caption,
    legend_loc = legend_loc,
    legend_bbox_to_anchor = legend_bbox_to_anchor,
    order = if (isTRUE(enforce_required_segments)) required_segments else NULL,
    linewidth = linewidth,
    missing_draw = missing_draw
  )
}
