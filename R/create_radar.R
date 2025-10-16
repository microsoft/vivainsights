# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See LICENSE.txt in the project root for license information.
# --------------------------------------------------------------------------------------------

#' @title Multi-Segment Radar Chart Utilities and Workflow
#'
#' @description
#' A set of utilities and a high-level wrapper to compute and render
#' multi-segment radar (spider) charts. The module provides:
#' - Helpers for canonicalizing segment labels and ensuring required segments.
#' - Calculation routines that aggregate per-person and per-segment metrics
#'   and support multiple indexing modes (total, reference-group, min-max).
#' - A plotting routine that renders radar charts using ggplot2 + coord_polar.
#' - A wrapper (`create_radar`) that returns either a ggplot object or a
#'   summary table depending on the `return_type` parameter.
#' @author Carlos Morales Torrado <carlos.morales@@microsoft.com>
#' @author Martin Chan <martin.chan@@microsoft.com>
#'
#' @template spq-params
#' @param metric Character string containing the name of the metric,
#' e.g. "Collaboration_hours"
#'
#' @section Features:
#' * Accepts dynamic metric lists, customizable segment and person ID columns,
#'   and optional auto-segmentation via vivainsights::identify_usage_segments().
#' * Indexing modes: "total" (indexed to overall average = 100),
#'   "ref_group" (index to a reference segment), "minmax" (scale each metric to [0,100]),
#'   and "none" (no indexing).
#' * Enforces required segments (adds NA rows for missing segments), supports
#'   synonyms mapping for labels, and can auto-relax minimum group size to
#'   preserve canonical segment ordering for plotting.
#'
#' @section Dependencies:
#' - Required packages: dplyr, tidyr, ggplot2.
#' - Optional: vivainsights (used only for auto-segmentation and date-range caption).
#'
#' @family Radar
#' @family Visualization
#' @keywords radar visualization indexing polar segments
#' @examples
#' \dontrun{
#' library(vivainsights)
#' pq <- load_pq_data()
#'
#' # Basic radar (indexed to Total = 100)
#' p <- create_radar(
#'   data = pq,
#'   metrics = c("Copilot_actions_taken_in_Teams", "Collaboration_hours",
#'               "After_hours_collaboration_hours", "Internal_network_size")
#' )
#'
#' # Return the indexed table instead of a plot
#' tbl <- create_radar(
#'   data = pq,
#'   metrics = c("Copilot_actions_taken_in_Teams", "Collaboration_hours"),
#'   return_type = "table"
#' )
#'
#' # Reference-group indexing (e.g., Power User = 100)
#' p2 <- create_radar(
#'   data = pq,
#'   metrics = c("Collaboration_hours", "Meetings_count"),
#'   index_mode = "ref_group",
#'   index_ref_group = "Power User"
#' )
#'
#' # Minu2013max scaling to [0, 100] per metric
#' p3 <- create_radar(
#'   data = pq,
#'   metrics = c("Collaboration_hours", "Meetings_count", "Focus_hours"),
#'   index_mode = "minmax"
#' )
#'
#' # Extended example (auto-segmentation + caption)
#' p4 <- create_radar(
#'   data = pq,
#'   metrics = c("Copilot_actions_taken_in_Excel","Copilot_actions_taken_in_Outlook",
#'               "Copilot_actions_taken_in_Word","Copilot_actions_taken_in_Powerpoint",
#'               "Copilot_actions_taken_in_Copilot_chat_(work)"),
#'   segment_col = "UsageSegments_12w",
#'   person_id_col = "PersonId",
#'   auto_segment_if_missing = TRUE,
#'   identify_metric = "Copilot_actions_taken_in_Teams",
#'   identify_version = "4w",
#'   mingroup = 5,
#'   agg = "mean",
#'   index_mode = "total",
#'   return_type = "plot",
#'   title = "Behavioral Profiles by Segment",
#'   caption_from_date_range = TRUE,
#'   caption_text = "Indexed to overall average (Total = 100)",
#'   alpha_fill = 0.01,
#'   linewidth = 1.5
#' )
#' }
#' create_radar utilities and workflow for segment-based radar charts (R)
#'
#' End-to-end parity with the Python version:
#' - Helpers: canonicalize segment labels; ensure required segments; figure header styling
#' - Calc: person- and segment-level aggregation with 4 indexing modes
#' - Viz: multi-segment radar chart (coord_polar)
#' - Wrapper: high-level function returning either a plot or a table
#'
#' @name create_radar_overview
#' @noRd
NULL
# ---- Imports -----------------------------------------------------------
#' @import dplyr
#' @import tidyr
#' @import ggplot2
#' @importFrom cowplot ggdraw draw_plot draw_label
#' @importFrom rlang .data
#' @importFrom stats setNames

# ---- Constants / defaults -----------------------------------------------------
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

# small helper: infix to safely default NULL
`%||%` <- function(a,b) if (!is.null(a)) a else b

# ---- Helpers -----------------------------------------------------------------

# Canonicalize segment labels using a synonyms map
##' Canonicalize segment labels
##'
##' Map variant segment labels to canonical names using a named synonyms map.
##' This is a light-weight helper used to keep segment labels consistent
##' across calculations and plotting.
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

# Ensure required segments exist as rows; add NA metric values where missing
##' Ensure required segments exist
##'
##' Add rows for canonical `required_segments` that are missing from the
##' provided `df`. The added rows contain NA values for the supplied
##' `metrics` so downstream code can preserve ordering and plotting.
##'
##' @param df Data frame containing a segment column and metric columns.
##' @param segment_col Character. Name of the segment column.
##' @param metrics Character vector of metric column names to create with NA.
##' @param required_segments Character vector of segments that should be present.
##' @return Data frame that includes rows for each required segment (with NA
##'   metric values) if they were originally missing.
##' @keywords internal
ensure_required_segments <- function(df, segment_col, metrics, required_segments) {
  if (is.null(required_segments) || length(required_segments) == 0) return(df)
  present <- unique(as.character(df[[segment_col]]))
  missing <- setdiff(required_segments, present)
  if (length(missing) == 0) return(df)
  filler <- as.data.frame(matrix(NA_real_, nrow = length(missing), ncol = length(metrics)))
  names(filler) <- metrics
  filler[[segment_col]] <- missing
  dplyr::bind_rows(df, filler)
}

# Map matplotlib-like legend loc to ggplot positions
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

# ---- Calc --------------------------------------------------------------------

#' create_radar_calc
#'
#' Compute segment-level metric values and (optionally) index them for radar plotting.
#' Pipeline:
#' 1) person-level aggregation within segment (mean/median)
#' 2) segment-level aggregation across people
#' 3) enforce minimum group size
#' 4) apply indexing mode
#'
#' @param data data.frame with metrics, segment_col, person_id_col
#' @param metrics character vector of numeric metric column names
#' @param segment_col segment label column
#' @param person_id_col unique person identifier column
#' @param mingroup minimum unique people per segment to retain
#' @param agg "mean" or "median"
#' @param index_mode one of "total","none","ref_group","minmax"
#' @param index_ref_group required if index_mode == "ref_group"
#' @param dropna drop NAs in required columns before aggregation
#' @return list(table = segment_level_indexed, ref = reference used)
#' @export
create_radar_calc <- function(data,
                              metrics,
                              segment_col = "UsageSegments_12w",
                              person_id_col = "PersonId",
                              mingroup = 5,
                              agg = c("mean", "median"),
                              index_mode = c("total", "none", "ref_group", "minmax"),
                              index_ref_group = NULL,
                              dropna = TRUE) {
  agg <- match.arg(agg)
  index_mode <- match.arg(index_mode)
  
  df <- data
  required_cols <- c(person_id_col, segment_col, metrics)
  missing_cols <- setdiff(required_cols, names(df))
  if (length(missing_cols) > 0) {
    stop("Missing required columns: ", paste(missing_cols, collapse = ", "))
  }
  
  # --- pandas parity: ALWAYS drop NA group keys ---
  df <- df %>%
    dplyr::filter(!is.na(.data[[person_id_col]]),
                  !is.na(.data[[segment_col]]))
  
  # Only drop metric NA when requested (pandas mean/median skip NaN anyway)
  if (isTRUE(dropna)) {
    df <- tidyr::drop_na(df, dplyr::all_of(metrics))
  }
  # ------------------------------------------------
  
  pid <- rlang::sym(person_id_col)
  seg <- rlang::sym(segment_col)
  
  if (agg == "mean") {
    person_level <- df %>%
      dplyr::group_by(!!pid, !!seg) %>%
      dplyr::summarise(dplyr::across(dplyr::all_of(metrics), \(x) mean(x, na.rm = TRUE)), .groups = "drop")
  } else {
    person_level <- df %>%
      dplyr::group_by(!!pid, !!seg) %>%
      dplyr::summarise(dplyr::across(dplyr::all_of(metrics), \(x) stats::median(x, na.rm = TRUE)), .groups = "drop")
  }
  
  if (agg == "mean") {
    segment_level <- person_level %>%
      dplyr::group_by(!!seg) %>%
      dplyr::summarise(dplyr::across(dplyr::all_of(metrics), \(x) mean(x, na.rm = TRUE)), .groups = "drop")
  } else {
    segment_level <- person_level %>%
      dplyr::group_by(!!seg) %>%
      dplyr::summarise(dplyr::across(dplyr::all_of(metrics), \(x) stats::median(x, na.rm = TRUE)), .groups = "drop")
  }
  
  counts <- person_level %>%
    dplyr::group_by(!!seg) %>%
    dplyr::summarise(n = dplyr::n_distinct(!!pid), .groups = "drop")
  
  segment_level <- segment_level %>%
    dplyr::left_join(counts, by = segment_col) %>%
    dplyr::filter(n >= mingroup) %>%
    dplyr::select(-n)
  
  ref <- numeric(0)
  seg_idx <- segment_level
  
  if (index_mode == "total") {
    ref <- if (agg == "mean") {
      colMeans(person_level[, metrics, drop = FALSE], na.rm = TRUE)
    } else {
      apply(person_level[, metrics, drop = FALSE], 2, stats::median, na.rm = TRUE)
    }
    for (m in metrics) seg_idx[[m]] <- (seg_idx[[m]] / ref[[m]]) * 100
  } else if (index_mode == "ref_group") {
    if (is.null(index_ref_group) || !index_ref_group %in% segment_level[[segment_col]]) {
      stop("index_ref_group must be provided and present in segment_col when index_mode='ref_group'.")
    }
    ref_row <- segment_level %>% dplyr::filter(.data[[segment_col]] == index_ref_group) %>% dplyr::slice(1)
    ref <- as.numeric(ref_row[, metrics, drop = FALSE]); names(ref) <- metrics
    for (m in metrics) seg_idx[[m]] <- (seg_idx[[m]] / ref[[m]]) * 100
  } else if (index_mode == "minmax") {
    mins <- vapply(metrics, function(m) min(segment_level[[m]], na.rm = TRUE), numeric(1))
    maxs <- vapply(metrics, function(m) max(segment_level[[m]], na.rm = TRUE), numeric(1))
    ref <- cbind(min = mins, max = maxs)
    for (m in metrics) {
      den <- (maxs[[m]] - mins[[m]]); if (den == 0) den <- 1
      seg_idx[[m]] <- 100 * (seg_idx[[m]] - mins[[m]]) / den
    }
  }
  
  list(table = seg_idx, ref = ref)
}


# ---- Viz (bar-style formatting; no orange line/box) --------------------------

#' create_radar_viz
#'
#' Render a radar (spider) chart from the wide, segment-level table produced by
#' create_radar_calc(). Each row is plotted as a polygon across the supplied metrics.
#' Formatting is aligned with create_bar: standard ggplot title/subtitle/caption,
#' no custom header decorations.
#'
#' @param segment_level_indexed data.frame with one row per segment; includes segment_col and metrics
#' @param metrics ordered character vector of metric columns to plot around the radar
#' @param segment_col character; segment label column (default "UsageSegments_12w")
#' @param figsize numeric length-2; used when saving (ggplot objects are size-less)
#' @param title,subtitle,caption character strings for standard ggplot annotations
#' @param legend_loc e.g., "upper right","upper left","right","top", etc.
#' @param legend_bbox_to_anchor kept for API parity; ignored for inside placement
#' @param alpha_fill numeric fill alpha (default 0.10)
#' @param linewidth numeric line width for outlines (default 1.5)
#' @param order optional character vector of segment order
#' @param fill_missing_with_plot "zero" (default) or "nan" (leave NA) for polygon closure
#' @return ggplot object
#' @export
create_radar_viz <- function(segment_level_indexed,
                             metrics,
                             segment_col = "UsageSegments_12w",
                             figsize = c(8, 6),
                             title = NULL,
                             subtitle = NULL,
                             caption = NULL,
                             legend_loc = "upper right",
                             legend_bbox_to_anchor = c(1.3, 1.1),
                             alpha_fill = 0.10,
                             linewidth = 1.5,
                             order = NULL,
                             fill_missing_with_plot = c("zero","nan")) {
  fill_missing_with_plot <- match.arg(fill_missing_with_plot)
  
  # Determine desired segment order
  segs_in_data <- unique(as.character(segment_level_indexed[[segment_col]]))
  segs <- if (!is.null(order)) intersect(order, segs_in_data) else segs_in_data
  
  # Long format (one row per segment-metric)
  df_long <- segment_level_indexed %>%
    dplyr::select(dplyr::all_of(c(segment_col, metrics))) %>%
    dplyr::mutate(!!segment_col := as.character(.data[[segment_col]])) %>%
    dplyr::filter(.data[[segment_col]] %in% segs) %>%
    tidyr::pivot_longer(cols = dplyr::all_of(metrics), names_to = "metric", values_to = "value") %>%
    dplyr::mutate(
      metric = factor(metric, levels = metrics),
      seg    = factor(.data[[segment_col]], levels = segs, ordered = TRUE)
    )
  
  # Plot-only NA handling
  if (fill_missing_with_plot == "zero") df_long$value[is.na(df_long$value)] <- 0
  
  # Circle positions, clockwise from top
  df_long <- df_long %>% dplyr::mutate(metric_idx = as.integer(metric) - 1L)
  
  # Close polygons
  first_points <- df_long %>%
    dplyr::group_by(seg) %>%
    dplyr::arrange(metric_idx, .by_group = TRUE) %>%
    dplyr::slice(1) %>%
    dplyr::ungroup()
  
  max_idx <- if (nrow(df_long) > 0) max(df_long$metric_idx, na.rm = TRUE) else 0L
  
  df_poly <- dplyr::bind_rows(
    df_long %>% dplyr::arrange(seg, metric_idx),
    first_points %>% dplyr::mutate(metric_idx = max_idx + 1L)
  ) %>%
    dplyr::mutate(seg = factor(seg, levels = segs, ordered = TRUE)) %>%
    dplyr::arrange(seg, metric_idx)
  
  # Legend placement
  leg_pos <- legend_position_from_loc(legend_loc)
  ggver <- tryCatch(utils::packageVersion("ggplot2"), error = function(e) "0.0.0")
  use_inside <- is.numeric(leg_pos)
  use_new_inside <- use_inside && (!inherits(ggver, "character")) && ggver >= "3.5.0"
  
  # Base plot (bar-style formatting via labs + theme)
  p <- ggplot(df_poly, aes(x = .data$metric_idx, y = .data$value, group = .data$seg)) +
    geom_polygon(aes(fill = .data$seg), alpha = alpha_fill, colour = NA) +
    geom_path(aes(colour = .data$seg), linewidth = linewidth, lineend = "round") +
    coord_polar(theta = "x", start = pi/2, direction = -1) +
    scale_x_continuous(
      breaks = seq(0, length(metrics) - 1),
      labels = metrics,
      expand = expansion(mult = c(0, 0))
    ) +
    guides(fill = guide_legend(title = NULL), colour = guide_legend(title = NULL)) +
    labs(
      title = title %||% NULL,
      subtitle = subtitle %||% NULL,
      caption = caption %||% NULL
    ) +
    theme_minimal(base_size = 11)
  
  # Theme consistent with create_bar
  p <- p + theme(
    plot.title = element_text(face = "bold"),
    plot.title.position = "plot",
    plot.subtitle = element_text(),
    plot.caption.position = "plot",
    axis.title = element_blank(),
    panel.grid.major = element_line(linewidth = 0.3),
    panel.grid.minor = element_blank(),
    legend.box.margin = margin(0, 0, 0, 0),
    legend.margin = margin(0, 0, 0, 0)
  )
  
  # Legend theme (version-aware)
  if (is.character(leg_pos)) {
    p <- p + theme(legend.position = leg_pos)
  } else if (use_new_inside) {
    p <- p + theme(legend.position = "inside", legend.position.inside = leg_pos)
  } else {
    p <- p + theme(legend.position = leg_pos)
  }
  
  p
}

# ---- Wrapper -----------------------------------------------------------------

#' create_radar
#'
#' High-level wrapper: compute segment-level metrics and either
#' (a) return the indexed table (return_type="table"), or
#' (b) render a radar chart (return_type="plot").
#'
#' @param data data.frame with metrics, person_id_col, and either segment_col or enough data for auto-segmentation
#' @param metrics character vector of numeric metric columns (order is the radar axis order)
#' @param segment_col character; segment label column (default "UsageSegments_12w")
#' @param person_id_col character; unique person ID column (default "PersonId")
#' @param auto_segment_if_missing logical; if TRUE and segment_col missing, uses vivainsights::identify_usage_segments()
#' @param identify_metric metric used by vivainsights::identify_usage_segments()
#' @param identify_version optional version for identify_usage_segments()
#' @param mingroup minimum unique people per segment (default 5)
#' @param agg "mean" or "median"
#' @param index_mode "total","none","ref_group","minmax"
#' @param index_ref_group required if index_mode == "ref_group"
#' @param dropna logical; drop NAs prior to aggregation (default FALSE)
#' @param required_segments ensure these segments exist (default = canonical order)
#' @param synonyms_map named vector mapping variants -> canonical
#' @param enforce_required_segments logical; add NA rows for missing segments
#' @param auto_relax_mingroup logical; if missing segments, recompute with mingroup=1
#' @param fill_missing_with_plot "zero" or "nan" for polygon closure only
#' @param return_type "plot" (default) or "table"
#' @param figsize numeric length-2 (width,height) in inches; used when saving
#' @param title,subtitle character strings
#' @param caption_from_date_range logical; if TRUE and vivainsights available, appends extract_date_range()
#' @param caption_text extra caption text; concatenated with date-range if present
#' @param legend_loc legend location keyword
#' @param legend_bbox_to_anchor kept for API parity
#' @param alpha_fill numeric fill alpha
#' @param linewidth numeric outline width
#' @return ggplot object (plot) or data.frame (table)
#' @export
create_radar <- function(data,
                         metrics,
                         # segmentation
                         segment_col = "UsageSegments_12w",
                         person_id_col = "PersonId",
                         auto_segment_if_missing = TRUE,
                         identify_metric = "Copilot_actions_taken_in_Teams",
                         identify_version = "4w",
                         # calc params
                         mingroup = 5,
                         agg = c("mean","median"),
                         index_mode = c("total","none","ref_group","minmax"),
                         index_ref_group = NULL,
                         dropna = FALSE,
                         # segment controls
                         required_segments = NULL,
                         synonyms_map = NULL,
                         enforce_required_segments = TRUE,
                         auto_relax_mingroup = TRUE,
                         fill_missing_with_plot = c("zero","nan"),
                         # output
                         return_type = c("plot","table"),
                         # viz params
                         figsize = c(8, 6),
                         title = "Behavioral Profiles by Segment",
                         subtitle = "Copilot usage radar chart",
                         caption_from_date_range = TRUE,
                         caption_text = NULL,
                         legend_loc = "upper right",
                         legend_bbox_to_anchor = c(1.3, 1.1),
                         alpha_fill = 0.10,
                         linewidth = 1.5) {
  
  agg <- match.arg(agg)
  index_mode <- match.arg(index_mode)
  fill_missing_with_plot <- match.arg(fill_missing_with_plot)
  return_type <- match.arg(return_type)
  
  df <- data
  if (is.null(required_segments)) required_segments <- CANONICAL_ORDER
  if (is.null(synonyms_map))       synonyms_map <- DEFAULT_SYNONYMS
  
  # Auto-identify segments if needed
  if (!segment_col %in% names(df) && isTRUE(auto_segment_if_missing)) {
    if (!requireNamespace("vivainsights", quietly = TRUE)) {
      stop("vivainsights is required for auto-segmentation but is not installed.")
    }
    df <- vivainsights::identify_usage_segments(
      data    = df,
      metric  = identify_metric,
      version = identify_version
    )
  }
  
  # Canonicalize before calc
  df <- canonicalize_segments(df, segment_col, synonyms_map)
  
  # Caption (if requested)
  caption <- ""
  if (isTRUE(caption_from_date_range) && requireNamespace("vivainsights", quietly = TRUE)) {
    caption <- tryCatch(vivainsights::extract_date_range(df, return_type = "text"),
                        error = function(e) "")
  }
  if (!is.null(caption_text) && nzchar(caption_text)) {
    caption <- if (nzchar(caption)) paste0(caption, " | ", caption_text) else caption_text
  }
  
  # Compute (first pass)
  res1 <- create_radar_calc(
    data = df, metrics = metrics, segment_col = segment_col,
    person_id_col = person_id_col, mingroup = mingroup, agg = agg,
    index_mode = index_mode, index_ref_group = index_ref_group, dropna = dropna
  )
  table <- res1$table
  
  # Canonicalize again (post-calc)
  table <- canonicalize_segments(table, segment_col, synonyms_map)
  
  # If required segments missing, optionally relax mingroup and recompute
  have <- unique(as.character(table[[segment_col]]))
  need <- required_segments
  missing_first <- setdiff(need, have)
  
  if (isTRUE(enforce_required_segments) && length(missing_first) > 0 &&
      isTRUE(auto_relax_mingroup) && mingroup > 1) {
    res_relax <- create_radar_calc(
      data = df, metrics = metrics, segment_col = segment_col,
      person_id_col = person_id_col, mingroup = 1, agg = agg,
      index_mode = index_mode, index_ref_group = index_ref_group, dropna = dropna
    )
    table <- canonicalize_segments(res_relax$table, segment_col, synonyms_map)
  }
  
  # Ensure required segments exist (add NA rows for truly absent)
  if (isTRUE(enforce_required_segments)) {
    table <- ensure_required_segments(table, segment_col, metrics, required_segments)
  }
  
  # Order rows
  table[[segment_col]] <- factor(table[[segment_col]], levels = required_segments, ordered = TRUE)
  table <- table %>% dplyr::arrange(.data[[segment_col]])
  
  # ---- Return type handling (Python parity) ----
  if (identical(return_type, "table")) {
    table_out <- table %>%
      dplyr::select(dplyr::all_of(c(segment_col, metrics))) %>%
      dplyr::mutate(!!segment_col := as.character(.data[[segment_col]]))
    rownames(table_out) <- NULL
    return(as.data.frame(table_out, stringsAsFactors = FALSE))
  }
  
  # Title suffix mirrored from Python
  base_title <- if (index_mode %in% c("total","ref_group")) {
    paste0(title %||% "Behavioral Profiles by Segment", " (Indexed)")
  } else if (index_mode == "minmax") {
    paste0(title %||% "Behavioral Profiles by Segment", " (Minu2013Max Scaled)")
  } else {
    title %||% "Behavioral Profiles by Segment"
  }
  
  create_radar_viz(
    segment_level_indexed = table,
    metrics               = metrics,
    segment_col           = segment_col,
    figsize               = figsize,
    title                 = base_title,
    subtitle              = subtitle,
    caption               = caption,
    legend_loc            = legend_loc,
    legend_bbox_to_anchor = legend_bbox_to_anchor,
    alpha_fill            = alpha_fill,
    linewidth             = linewidth,
    order                 = required_segments,
    fill_missing_with_plot = fill_missing_with_plot
  )
}
