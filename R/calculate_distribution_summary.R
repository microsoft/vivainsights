# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See LICENSE.txt in the project root for license information.
# --------------------------------------------------------------------------------------------

#' @title Calculate Distribution Summary Statistics
#'
#' @description
#' Internal helper function to calculate comprehensive distribution statistics
#' for a given metric grouped by a categorical variable. Used by create_hist(), 
#' create_density(), and create_boxplot() to ensure consistent output.
#'
#' @param plot_data A data frame containing the metric data with columns:
#'   - `group`: The grouping variable
#'   - `<metric>`: The metric column (name specified in metric parameter)
#' @param metric Character string containing the name of the metric column
#'
#' @return A data frame with distribution statistics:
#'   - `group`: The grouping variable
#'   - `mean`: Mean of the metric
#'   - `min`: Minimum value of the metric  
#'   - `p10`: 10th percentile of the metric
#'   - `p25`: 25th percentile of the metric
#'   - `p50`: 50th percentile (median) of the metric
#'   - `p75`: 75th percentile of the metric
#'   - `p90`: 90th percentile of the metric
#'   - `max`: Maximum value of the metric
#'   - `sd`: Standard deviation of the metric
#'   - `range`: Range of the metric (max - min)
#'   - `n`: Number of observations
#'
#' @importFrom stats quantile
#' @importFrom stats sd
#' @importFrom dplyr group_by
#' @importFrom dplyr summarise
#' @importFrom dplyr sym
#' @importFrom rlang !!
#'
#' @keywords internal
#'
calculate_distribution_summary <- function(plot_data, metric) {
  plot_data %>%
    group_by(group) %>%
    summarise(
      mean = mean(!!sym(metric), na.rm = TRUE),
      min = min(!!sym(metric), na.rm = TRUE),
      p10 = quantile(!!sym(metric), 0.10, na.rm = TRUE),
      p25 = quantile(!!sym(metric), 0.25, na.rm = TRUE),
      p50 = quantile(!!sym(metric), 0.50, na.rm = TRUE),
      p75 = quantile(!!sym(metric), 0.75, na.rm = TRUE),
      p90 = quantile(!!sym(metric), 0.90, na.rm = TRUE),
      max = max(!!sym(metric), na.rm = TRUE),
      sd = sd(!!sym(metric), na.rm = TRUE),
      range = max - min,
      n = n(),
      .groups = "drop"
    )
}