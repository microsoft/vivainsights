# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See LICENSE.txt in the project root for license information.
# --------------------------------------------------------------------------------------------

#' @title Radar Chart for multiple metrics
#'
#' @description
#' Creates a multi-group radar (spider) chart across a set of metrics.
#'
#' Core pipeline:
#' 1) Person-level aggregation within group
#' 2) Group-level aggregation
#' 3) Privacy filtering via `mingroup`
#' 4) Optional indexing modes: "total", "none", "ref_group", "minmax"
#'
#' Optional auto-segmentation:
#' - If `hrvar` is not supplied, the function will call
#'   `identify_usage_segments()` and infer the resulting segment column.
#'
#' @param data A Standard Person Query dataset in the form of a data frame.
#' @param metrics Character vector of metric column names.
#' @param hrvar Character string specifying the grouping column.
#'   Defaults to `"Organization"`. If `NULL`, usage segments will be derived
#'   via `identify_usage_segments()`.
#' @param mingroup Numeric value setting the privacy threshold / minimum group size.
#'   Defaults to 5.
#' @param agg String specifying aggregation method. Either `"mean"` (default) or `"median"`.
#' @param index_mode String specifying indexing mode. One of:
#'   - `"total"` (default): Total = 100 for each metric
#'   - `"none"`: no indexing (raw group values)
#'   - `"ref_group"`: reference group = 100 (requires `index_ref_group`)
#'   - `"minmax"`: scale to \[0, 100\] within observed group ranges per metric
#' @param index_ref_group Character string specifying reference group name when
#'   `index_mode = "ref_group"`.
#' @param na.rm Logical value indicating whether NA rows in required columns are removed
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
#' create_radar(
#'   data = pq_data,
#'   metrics = c("Collaboration_hours", "Email_hours", "Meeting_hours"),
#'   hrvar = "Organization",
#'   mingroup = 1
#' )
#'
#' # Return the indexed table instead of a plot
#' create_radar(
#'   data = pq_data,
#'   metrics = c("Collaboration_hours", "Email_hours", "Meeting_hours"),
#'   hrvar = "LevelDesignation",
#'   mingroup = 1,
#'   return = "table"
#' )
#' @export
create_radar <- function(data,
                         metrics,
                         hrvar = "Organization",
                         mingroup = 5,
                         agg = "mean",
                         index_mode = "total",
                         index_ref_group = NULL,
                         na.rm = FALSE,
                         return = "plot") {

  ## Check inputs
  if (!is.character(metrics) || length(metrics) < 1) {
    stop("Please enter a valid input for `metrics` (non-empty character vector).")
  }

  required_variables <- c("PersonId", metrics)

  # Auto-segmentation requires MetricDate
  if (is.null(hrvar)) {
    required_variables <- c(required_variables, "MetricDate")
  } else {
    required_variables <- c(required_variables, hrvar)
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

  # Fail fast: index_ref_group must be supplied when needed
  if (index_mode == "ref_group" && is.null(index_ref_group)) {
    stop("Please provide `index_ref_group` when `index_mode = 'ref_group'`.")
  }

  if (!is.logical(na.rm) || length(na.rm) != 1) {
    stop("Please enter a valid input for `na.rm` (TRUE/FALSE).")
  }

  if (!is.character(return) || length(return) != 1) {
    stop("Please enter a valid input for `return`.")
  }

  df <- data
  hrvar_for_calc <- hrvar

  ## Auto-segmentation if hrvar is NULL
  if (is.null(hrvar_for_calc)) {
    seg_out <- .auto_segment_using_identify_usage(
      data = df,
      metrics = metrics
    )
    df <- seg_out$data
    hrvar_for_calc <- seg_out$segment_col
  }

  out <-
    create_radar_calc(
      data = df,
      metrics = metrics,
      hrvar = hrvar_for_calc,
      mingroup = mingroup,
      agg = agg,
      index_mode = index_mode,
      index_ref_group = index_ref_group,
      na.rm = na.rm
    )

  if (return == "table") {

    return(out$table)

  } else if (return == "plot") {

    return(
      create_radar_viz(
        data = out$table,
        metrics = metrics,
        hrvar = hrvar_for_calc
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
#' @param hrvar character string specifying grouping column.
#' @param id_col character string specifying person id column.
#' @param mingroup numeric minimum unique people per group.
#' @param agg "mean" or "median".
#' @param index_mode "total","none","ref_group","minmax".
#' @param index_ref_group reference group name when index_mode="ref_group".
#' @param na.rm logical.
#'
#' @return list(table=group_level_table, ref=reference_used)
#'
#' @export
create_radar_calc <- function(data,
                              metrics,
                              hrvar,
                              id_col = "PersonId",
                              mingroup = 5,
                              agg = "mean",
                              index_mode = "total",
                              index_ref_group = NULL,
                              na.rm = FALSE) {

  ## Check inputs
  required_variables <- c(id_col, hrvar, metrics) %>% unique()

  data %>%
    .check_inputs_safe(requirements = required_variables)

  df <- data %>%
    dplyr::select(dplyr::all_of(required_variables)) %>%
    dplyr::filter(!is.na(.data[[id_col]]), !is.na(.data[[hrvar]]))

  if (isTRUE(na.rm)) {
    df <- df %>% tidyr::drop_na(dplyr::all_of(metrics))
  }

  # Ensure stable type for grouping key
  df[[hrvar]] <- as.character(df[[hrvar]])

  ## Person-level aggregation within segment
  if (agg == "mean") {
    person_level <-
      df %>%
      dplyr::group_by(.data[[id_col]], .data[[hrvar]]) %>%
      dplyr::summarise(
        dplyr::across(dplyr::all_of(metrics), \(x) mean(x, na.rm = TRUE)),
        .groups = "drop"
      )
  } else {
    person_level <-
      df %>%
      dplyr::group_by(.data[[id_col]], .data[[hrvar]]) %>%
      dplyr::summarise(
        dplyr::across(dplyr::all_of(metrics), \(x) stats::median(x, na.rm = TRUE)),
        .groups = "drop"
      )
  }

  ## Group-level aggregation across people
  if (agg == "mean") {
    group_level <-
      person_level %>%
      dplyr::group_by(.data[[hrvar]]) %>%
      dplyr::summarise(
        dplyr::across(dplyr::all_of(metrics), \(x) mean(x, na.rm = TRUE)),
        .groups = "drop"
      )
  } else {
    group_level <-
      person_level %>%
      dplyr::group_by(.data[[hrvar]]) %>%
      dplyr::summarise(
        dplyr::across(dplyr::all_of(metrics), \(x) stats::median(x, na.rm = TRUE)),
        .groups = "drop"
      )
  }

  ## Enforce mingroup (distinct people per segment)
  counts <-
    person_level %>%
    dplyr::group_by(.data[[hrvar]]) %>%
    dplyr::summarise(n = dplyr::n_distinct(.data[[id_col]]), .groups = "drop")

  group_level <-
    group_level %>%
    dplyr::left_join(counts, by = hrvar) %>%
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

    # Check for zero denominators
    zero_metrics <- names(ref)[ref == 0 | is.na(ref)]
    if (length(zero_metrics) > 0) {
      warning("Metric(s) with zero or NA reference values detected in 'total' mode: ",
              paste(zero_metrics, collapse = ", "),
              ". Setting indexed values to 100 (neutral baseline).")
    }

    for (m in metrics) {
      den <- ref[[m]]
      if (is.na(den) || den == 0) {
        out_tbl[[m]] <- 100  # Set to neutral baseline
      } else {
        out_tbl[[m]] <- (out_tbl[[m]] / den) * 100
      }
    }

  } else if (index_mode == "ref_group") {

    if (is.null(index_ref_group)) {
      stop("Please provide `index_ref_group` when `index_mode = 'ref_group'`.")
    }

    if (!index_ref_group %in% out_tbl[[hrvar]]) {
      # Give a more specific message depending on whether mingroup filtering removed it
      if (index_ref_group %in% data[[hrvar]]) {
        stop("Reference group '", index_ref_group, "' was removed by the mingroup filter ",
             "(n < ", mingroup, "). Lower `mingroup` or choose a different reference group.")
      } else {
        stop("'", index_ref_group, "' not found in `hrvar`. ",
             "Check the spelling or use `return = 'table'` to see available groups.")
      }
    }

    ref_row <- out_tbl %>%
      dplyr::filter(.data[[hrvar]] == index_ref_group) %>%
      dplyr::slice(1)

    ref <- as.numeric(ref_row[, metrics, drop = FALSE])
    names(ref) <- metrics

    # Check for zero denominators
    zero_metrics <- names(ref)[ref == 0 | is.na(ref)]
    if (length(zero_metrics) > 0) {
      warning("Metric(s) with zero or NA values in reference group '", index_ref_group, "': ",
              paste(zero_metrics, collapse = ", "),
              ". Setting indexed values to 100 (neutral baseline).")
    }

    for (m in metrics) {
      den <- ref[[m]]
      if (is.na(den) || den == 0) {
        out_tbl[[m]] <- 100  # Set to neutral baseline
      } else {
        out_tbl[[m]] <- (out_tbl[[m]] / den) * 100
      }
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
#' @param hrvar Character string of grouping column name.
#' @param fill_missing Character string specifying how to handle missing values.
#'   If `"zero"` (default), fill NA values as 0 for plotting. This ensures
#'   polygons close properly in the radar visualization.
#'
#' @return ggplot object.
#'
#' @export
create_radar_viz <- function(data,
                             metrics,
                             hrvar,
                             fill_missing = "zero") {

  # Warn if too few metrics for effective radar chart
  if (length(metrics) < 3) {
    warning("Radar charts work best with 3 or more metrics. ",
            "Consider using a different visualization for ", length(metrics), " metric(s).")
  }

  # Long format
  plot_df <-
    data %>%
    dplyr::select(dplyr::all_of(c(hrvar, metrics))) %>%
    tidyr::pivot_longer(
      cols = dplyr::all_of(metrics),
      names_to = "metric",
      values_to = "value"
    ) %>%
    dplyr::mutate(
      metric = factor(.data$metric, levels = metrics),
      seg = as.character(.data[[hrvar]]),
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
    ggplot2::geom_polygon(ggplot2::aes(fill = .data$seg), alpha = 0.10, colour = NA,
                          show.legend = FALSE) +
    ggplot2::geom_path(ggplot2::aes(colour = .data$seg), linewidth = 1.2, lineend = "round") +
    ggplot2::coord_polar(theta = "x", start = pi/2, direction = -1) +
    ggplot2::scale_x_continuous(
      breaks = seq(0, length(metrics) - 1),
      labels = axis_labs,
      expand = ggplot2::expansion(mult = c(0, 0))
    ) +
    ggplot2::guides(colour = ggplot2::guide_legend(title = NULL)) +
    ggplot2::labs(title = "Radar chart", subtitle = paste("By", .pretty_hrvar_name(hrvar))) +
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
# Internal helpers (file-local)
# =========================

.pretty_metric_names <- function(metrics) {

  if (exists("us_to_space", mode = "function")) {
    return(vapply(metrics, us_to_space, character(1)))
  }

  gsub("_", " ", metrics, fixed = TRUE)
}
