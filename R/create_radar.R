# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See LICENSE.txt in the project root for license information.
# --------------------------------------------------------------------------------------------

#' @title Radar Chart for multiple metrics
#'
#' @description
#' Creates a multi-group radar (spider) chart across a set of metrics.
#'
#' Core pipeline (kept intact):
#' 1) Person-level aggregation within group
#' 2) Group-level aggregation
#' 3) Privacy filtering via `mingroup`
#' 4) Optional indexing modes: "total", "none", "ref_group", "minmax"
#'
#' Optional auto-segmentation:
#' - If `segment_col` is not supplied, the function will call
#'   `identify_usage_segments()` and infer the resulting segment column (no
#'   hardcoded segment labels or RL12 ordering).
#'
#' @template spq-params
#' @param metrics Character vector of metric column names.
#' @param segment_col Character string specifying the grouping column.
#'   If `NULL`, usage segments will be derived via `identify_usage_segments()`.
#' @param id_col Character string containing the person identifier column name.
#'   Defaults to `"PersonId"`.
#' @param date_col Character string containing the date column name required for
#'   auto-segmentation. Defaults to `"MetricDate"`.
#' @param mingroup Numeric value setting the privacy threshold / minimum group size.
#'   Defaults to 5.
#' @param agg String specifying aggregation method. Either `"mean"` (default) or `"median"`.
#' @param index_mode String specifying indexing mode. One of:
#'   - `"total"` (default): Total = 100 for each metric
#'   - `"none"`: no indexing (raw group values)
#'   - `"ref_group"`: reference group = 100 (requires `index_ref_group`)
#'   - `"minmax"`: scale to [0,100] within observed group ranges per metric
#' @param index_ref_group Character string specifying reference group name when
#'   `index_mode = "ref_group"`.
#' @param dropna Logical value indicating whether NA rows in required columns are removed
#'   prior to aggregation. Defaults to `FALSE`.
#' @param return String specifying what to return. One of:
#'   - `"plot"` (default)
#'   - `"table"`
#'
#' @return
#' A different output is returned depending on the value passed to `return`:
#'   - `"plot"`: ggplot object (radar chart)
#'   - `"table"`: data frame (group-level indexed table)
#'
#' @import dplyr
#' @import tidyr
#' @import ggplot2
#' @importFrom rlang .data
#'
#' @family Visualization
#' @family Flexible
#'
#' @examples
#' # \dontrun{
#' # library(vivainsights)
#' # data("pq_data", package = "vivainsights")
#' #
#' # # Pre-computed grouping column
#' # create_radar(
#' #   data = pq_data,
#' #   metrics = c("Collaboration_hours", "Email_hours", "Meeting_hours"),
#' #   segment_col = "Organization",
#' #   mingroup = 1
#' # )
#' #
#' # # Auto usage segmentation (segment_col omitted)
#' # create_radar(
#' #   data = pq_data,
#' #   metrics = c("Copilot_actions_taken_in_Teams", "Copilot_actions_taken_in_Outlook"),
#' #   mingroup = 1
#' # )
#' # }
#' @export
create_radar <- function(data,
                         metrics,
                         segment_col = NULL,
                         id_col = "PersonId",
                         date_col = "MetricDate",
                         mingroup = 5,
                         agg = "mean",
                         index_mode = "total",
                         index_ref_group = NULL,
                         dropna = FALSE,
                         return = "plot") {
  
  ## Check inputs
  if (!is.character(metrics) || length(metrics) < 1) {
    stop("Please enter a valid input for `metrics` (non-empty character vector).")
  }
  
  required_variables <- c(id_col, metrics)
  
  # Auto-segmentation requires date_col
  if (is.null(segment_col)) {
    required_variables <- c(required_variables, date_col)
  } else {
    required_variables <- c(required_variables, segment_col)
  }
  
  required_variables <- unique(required_variables)
  
  data %>%
    .check_inputs_safe(requirements = required_variables)
  
  if (!is.numeric(mingroup) || length(mingroup) != 1 || mingroup < 1) {
    stop("Please enter a valid input for `mingroup` (single numeric >= 1).")
  }
  
  if (!agg %in% c("mean", "median")) {
    stop("Please enter a valid input for `agg`: 'mean' or 'median'.")
  }
  
  if (!index_mode %in% c("total", "none", "ref_group", "minmax")) {
    stop("Please enter a valid input for `index_mode`.")
  }
  
  if (!is.logical(dropna) || length(dropna) != 1) {
    stop("Please enter a valid input for `dropna` (TRUE/FALSE).")
  }
  
  if (!is.character(return) || length(return) != 1) {
    stop("Please enter a valid input for `return`.")
  }
  
  df <- data
  seg_col_for_calc <- segment_col
  
  ## Auto-segmentation if segment_col is NULL
  if (is.null(seg_col_for_calc)) {
    seg_out <- .auto_segment_using_identify_usage(
      data = df,
      metrics = metrics,
      id_col = id_col,
      date_col = date_col
    )
    df <- seg_out$data
    seg_col_for_calc <- seg_out$segment_col
  }
  
  out <-
    create_radar_calc(
      data = df,
      metrics = metrics,
      segment_col = seg_col_for_calc,
      id_col = id_col,
      mingroup = mingroup,
      agg = agg,
      index_mode = index_mode,
      index_ref_group = index_ref_group,
      dropna = dropna
    )
  
  if (return == "table") {
    
    return(out$table)
    
  } else if (return == "plot") {
    
    return(
      create_radar_viz(
        data = out$table,
        metrics = metrics,
        segment_col = seg_col_for_calc
      )
    )
    
  } else {
    
    stop("Please enter a valid input for `return`.")
    
  }
}


#' @title Radar Chart (Calculation)
#'
#' @description
#' Computes group-level metric values and applies optional indexing.
#'
#' @param data data.frame.
#' @param metrics character vector of metric column names.
#' @param segment_col character string specifying grouping column.
#' @param id_col character string specifying person id column.
#' @param mingroup numeric minimum unique people per group.
#' @param agg "mean" or "median".
#' @param index_mode "total","none","ref_group","minmax".
#' @param index_ref_group reference group name when index_mode="ref_group".
#' @param dropna logical.
#'
#' @return list(table=group_level_table, ref=reference_used)
#'
#' @export
create_radar_calc <- function(data,
                              metrics,
                              segment_col,
                              id_col = "PersonId",
                              mingroup = 5,
                              agg = "mean",
                              index_mode = "total",
                              index_ref_group = NULL,
                              dropna = FALSE) {
  
  ## Check inputs
  required_variables <- c(id_col, segment_col, metrics) %>% unique()
  
  data %>%
    .check_inputs_safe(requirements = required_variables)
  
  df <- data %>%
    dplyr::select(dplyr::all_of(required_variables)) %>%
    dplyr::filter(!is.na(.data[[id_col]]), !is.na(.data[[segment_col]]))
  
  if (isTRUE(dropna)) {
    df <- df %>% tidyr::drop_na(dplyr::all_of(metrics))
  }
  
  # Ensure stable type for grouping key
  df[[segment_col]] <- as.character(df[[segment_col]])
  
  ## Person-level aggregation within segment
  if (agg == "mean") {
    person_level <-
      df %>%
      dplyr::group_by(.data[[id_col]], .data[[segment_col]]) %>%
      dplyr::summarise(
        dplyr::across(dplyr::all_of(metrics), \(x) mean(x, na.rm = TRUE)),
        .groups = "drop"
      )
  } else {
    person_level <-
      df %>%
      dplyr::group_by(.data[[id_col]], .data[[segment_col]]) %>%
      dplyr::summarise(
        dplyr::across(dplyr::all_of(metrics), \(x) stats::median(x, na.rm = TRUE)),
        .groups = "drop"
      )
  }
  
  ## Group-level aggregation across people
  if (agg == "mean") {
    group_level <-
      person_level %>%
      dplyr::group_by(.data[[segment_col]]) %>%
      dplyr::summarise(
        dplyr::across(dplyr::all_of(metrics), \(x) mean(x, na.rm = TRUE)),
        .groups = "drop"
      )
  } else {
    group_level <-
      person_level %>%
      dplyr::group_by(.data[[segment_col]]) %>%
      dplyr::summarise(
        dplyr::across(dplyr::all_of(metrics), \(x) stats::median(x, na.rm = TRUE)),
        .groups = "drop"
      )
  }
  
  ## Enforce mingroup (distinct people per segment)
  counts <-
    person_level %>%
    dplyr::group_by(.data[[segment_col]]) %>%
    dplyr::summarise(n = dplyr::n_distinct(.data[[id_col]]), .groups = "drop")
  
  group_level <-
    group_level %>%
    dplyr::left_join(counts, by = segment_col) %>%
    dplyr::filter(.data$n >= mingroup)
  
  if (nrow(group_level) == 0) {
    out_tbl <- group_level
    ref <- numeric(0)
    return(list(table = out_tbl, ref = ref))
  }
  
  ## Reference + indexing
  ref <- numeric(0)
  out_tbl <- group_level
  
  if (index_mode == "total") {
    
    ref <- if (agg == "mean") {
      colMeans(person_level[, metrics, drop = FALSE], na.rm = TRUE)
    } else {
      apply(person_level[, metrics, drop = FALSE], 2, stats::median, na.rm = TRUE)
    }
    
    for (m in metrics) {
      den <- ref[[m]]
      out_tbl[[m]] <- (out_tbl[[m]] / den) * 100
    }
    
  } else if (index_mode == "ref_group") {
    
    if (is.null(index_ref_group) || !index_ref_group %in% out_tbl[[segment_col]]) {
      stop("index_ref_group must be provided and present in `segment_col` when index_mode = 'ref_group'.")
    }
    
    ref_row <- out_tbl %>%
      dplyr::filter(.data[[segment_col]] == index_ref_group) %>%
      dplyr::slice(1)
    
    ref <- as.numeric(ref_row[, metrics, drop = FALSE])
    names(ref) <- metrics
    
    for (m in metrics) {
      den <- ref[[m]]
      out_tbl[[m]] <- (out_tbl[[m]] / den) * 100
    }
    
  } else if (index_mode == "minmax") {
    
    mins <- vapply(metrics, function(m) min(out_tbl[[m]], na.rm = TRUE), numeric(1))
    maxs <- vapply(metrics, function(m) max(out_tbl[[m]], na.rm = TRUE), numeric(1))
    ref <- cbind(min = mins, max = maxs)
    
    for (m in metrics) {
      den <- (maxs[[m]] - mins[[m]])
      if (den == 0) den <- 1
      out_tbl[[m]] <- 100 * (out_tbl[[m]] - mins[[m]]) / den
    }
    
  } else {
    # "none": return raw group values
  }
  
  list(table = out_tbl, ref = ref)
}


#' @title Radar Chart (Visualization)
#'
#' @description
#' Renders a multi-group radar chart using `ggplot2` + `coord_polar()`.
#'
#' @param data Output table from `create_radar_calc()`.
#' @param metrics Character vector of metric column names.
#' @param segment_col Character string of grouping column name.
#' @param fill_missing Character. If "zero" (default), fill NA values as 0 for plotting.
#'
#' @return ggplot object.
#'
#' @export
create_radar_viz <- function(data,
                             metrics,
                             segment_col,
                             fill_missing = "zero") {
  
  # Long format
  plot_df <-
    data %>%
    dplyr::select(dplyr::all_of(c(segment_col, metrics))) %>%
    tidyr::pivot_longer(
      cols = dplyr::all_of(metrics),
      names_to = "metric",
      values_to = "value"
    ) %>%
    dplyr::mutate(
      metric = factor(.data$metric, levels = metrics),
      seg = as.character(.data[[segment_col]]),
      metric_idx = as.integer(.data$metric) - 1L
    )
  
  if (fill_missing == "zero") {
    plot_df$value[is.na(plot_df$value)] <- 0
  }
  
  # Close polygons
  first_points <-
    plot_df %>%
    dplyr::group_by(.data$seg) %>%
    dplyr::arrange(.data$metric_idx, .by_group = TRUE) %>%
    dplyr::slice(1) %>%
    dplyr::ungroup()
  
  max_idx <- if (nrow(plot_df) > 0) max(plot_df$metric_idx, na.rm = TRUE) else 0L
  
  poly_df <-
    dplyr::bind_rows(
      plot_df %>% dplyr::arrange(.data$seg, .data$metric_idx),
      first_points %>% dplyr::mutate(metric_idx = max_idx + 1L)
    ) %>%
    dplyr::arrange(.data$seg, .data$metric_idx)
  
  # Friendly labels if available
  axis_labs <- .pretty_metric_names(metrics)
  
  ggplot2::ggplot(poly_df, ggplot2::aes(x = .data$metric_idx, y = .data$value, group = .data$seg)) +
    ggplot2::geom_polygon(ggplot2::aes(fill = .data$seg), alpha = 0.10, colour = NA) +
    ggplot2::geom_path(ggplot2::aes(colour = .data$seg), linewidth = 1.2, lineend = "round") +
    ggplot2::coord_polar(theta = "x", start = pi/2, direction = -1) +
    ggplot2::scale_x_continuous(
      breaks = seq(0, length(metrics) - 1),
      labels = axis_labs,
      expand = ggplot2::expansion(mult = c(0, 0))
    ) +
    ggplot2::guides(fill = ggplot2::guide_legend(title = NULL), colour = ggplot2::guide_legend(title = NULL)) +
    ggplot2::labs(title = "Radar chart", subtitle = paste("By", segment_col)) +
    .theme_wpa_safe() +
    ggplot2::theme(
      plot.title = ggplot2::element_text(face = "bold"),
      plot.title.position = "plot",
      axis.title = ggplot2::element_blank(),
      panel.grid.major = ggplot2::element_line(linewidth = 0.3),
      panel.grid.minor = ggplot2::element_blank(),
      legend.position = "right"
    )
}

# =========================
# Internal helpers
# =========================

.check_inputs_safe <- function(data, requirements) {
  
  if (exists("check_inputs", mode = "function")) {
    data %>% check_inputs(requirements = requirements)
    return(invisible(TRUE))
  }
  
  missing <- setdiff(requirements, names(data))
  if (length(missing) > 0) {
    stop("Missing required column(s): ", paste(missing, collapse = ", "))
  }
  
  invisible(TRUE)
}

.pretty_metric_names <- function(metrics) {
  
  if (exists("us_to_space", mode = "function")) {
    return(vapply(metrics, us_to_space, character(1)))
  }
  
  gsub("_", " ", metrics, fixed = TRUE)
}

.theme_wpa_safe <- function() {
  
  if (exists("theme_wpa", mode = "function")) return(theme_wpa())
  
  if ("vivainsights" %in% loadedNamespaces() &&
      exists("theme_wpa", envir = asNamespace("vivainsights"), mode = "function")) {
    return(get("theme_wpa", envir = asNamespace("vivainsights"))())
  }
  
  ggplot2::theme_minimal()
}

.auto_segment_using_identify_usage <- function(data,
                                               metrics,
                                               id_col = "PersonId",
                                               date_col = "MetricDate",
                                               usage_version = "12w") {
  
  # identify_usage_segments() prefers PersonId + MetricDate naming
  df <- data
  
  if (!id_col %in% names(df)) stop("`id_col` not found in data: ", id_col)
  if (!date_col %in% names(df)) stop("`date_col` not found in data: ", date_col)
  
  # Guard against conflicts when renaming
  if (id_col != "PersonId") {
    if ("PersonId" %in% names(df)) stop("Cannot map `", id_col, "` to PersonId because PersonId already exists.")
    df <- dplyr::rename(df, PersonId = !!rlang::sym(id_col))
  }
  if (date_col != "MetricDate") {
    if ("MetricDate" %in% names(df)) stop("Cannot map `", date_col, "` to MetricDate because MetricDate already exists.")
    df <- dplyr::rename(df, MetricDate = !!rlang::sym(date_col))
  }
  
  # Locate identify_usage_segments()
  ident_fun <- NULL
  if ("vivainsights" %in% loadedNamespaces() &&
      exists("identify_usage_segments", envir = asNamespace("vivainsights"), mode = "function")) {
    ident_fun <- get("identify_usage_segments", envir = asNamespace("vivainsights"))
  } else if (exists("identify_usage_segments", mode = "function")) {
    ident_fun <- identify_usage_segments
  } else {
    stop("`identify_usage_segments()` not found. Load `vivainsights` first.")
  }
  
  original_cols <- names(df)
  
  # Call identify_usage_segments using the same metric list
  if (length(metrics) == 1) {
    seg_data <- ident_fun(
      data = df,
      metric = metrics[[1]],
      metric_str = NULL,
      version = usage_version,
      return = "data"
    )
  } else {
    seg_data <- ident_fun(
      data = df,
      metric = NULL,
      metric_str = metrics,
      version = usage_version,
      return = "data"
    )
  }
  
  # Infer segment column from newly-added columns
  new_cols <- setdiff(names(seg_data), original_cols)
  
  candidates <- Filter(function(cn) {
    x <- seg_data[[cn]]
    (is.factor(x) || is.character(x)) &&
      dplyr::n_distinct(x, na.rm = TRUE) > 1 &&
      dplyr::n_distinct(x, na.rm = TRUE) <= 10
  }, new_cols)
  
  if (length(candidates) == 0) {
    stop("No suitable segment column detected after running `identify_usage_segments()`.")
  }
  
  # Prefer a version-matching column name if uniquely available
  if (!is.null(usage_version) && is.character(usage_version) && length(usage_version) == 1) {
    vmatch <- candidates[grepl(usage_version, candidates, fixed = TRUE)]
    if (length(vmatch) == 1) {
      segment_col <- vmatch[[1]]
    } else {
      nunique <- vapply(candidates, function(cn) dplyr::n_distinct(seg_data[[cn]], na.rm = TRUE), numeric(1))
      segment_col <- candidates[[which.min(nunique)]]
    }
  } else {
    nunique <- vapply(candidates, function(cn) dplyr::n_distinct(seg_data[[cn]], na.rm = TRUE), numeric(1))
    segment_col <- candidates[[which.min(nunique)]]
  }
  
  # Map columns back to caller schema if renamed
  if (id_col != "PersonId") seg_data <- dplyr::rename(seg_data, !!rlang::sym(id_col) := .data$PersonId)
  if (date_col != "MetricDate") seg_data <- dplyr::rename(seg_data, !!rlang::sym(date_col) := .data$MetricDate)
  
  list(data = seg_data, segment_col = segment_col)
}
