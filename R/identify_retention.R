# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See LICENSE.txt in the project root for license information.
# --------------------------------------------------------------------------------------------

#' @title Identify Retention Rate Between Two Time Periods
#'
#' @description `r lifecycle::badge('experimental')`
#'
#' This function calculates the retention rate of individuals who meet a
#' specific category condition in one time period and checks whether they still
#' meet that condition in a subsequent time period. This function complements
#' `identify_usage_segments()`.
#'
#' @param data A data frame containing person-level time series data with at
#'   minimum `PersonId`, `MetricDate`, and the column specified in `category`.
#' @param start_x Start date for the first time period (Date or character in
#'   `"YYYY-MM-DD"` format).
#' @param end_x End date for the first time period (exclusive).
#' @param start_y Start date for the second time period.
#' @param end_y End date for the second time period (exclusive). If `NULL`,
#'   uses all data from `start_y` onwards.
#' @param category A string specifying the column name containing the
#'   binary/categorical variable to evaluate (e.g. `"IsHabitualUser"`).
#' @param category_values A character vector of values in `category` that
#'   define the "positive" condition (e.g. `c("Power User", "Habitual User")`).
#'   Defaults to `TRUE` for binary columns.
#' @param return A string specifying the return type. Valid options are:
#'   - `"summary"` (default): A tibble with retention statistics.
#'   - `"data"`: A list with person-level retention status and breakdown.
#'   - `"message"`: Prints a formatted message and returns the summary tibble
#'     invisibly.
#'
#' @return Depending on `return`:
#'   - `"summary"`: A tibble with the following columns:
#'     - `PeriodX_Start`, `PeriodX_End`: Start and end dates of period X.
#'     - `PeriodY_Start`, `PeriodY_End`: Start and end dates of period Y.
#'     - `Category`: The category column name.
#'     - `CategoryValues`: The category values used.
#'     - `N_Original`: Number of individuals meeting the condition in period X.
#'     - `N_Tracked`: Number of those individuals found in period Y.
#'     - `N_Lost`: Number of individuals not found in period Y.
#'     - `N_Retained`: Number still meeting the condition in period Y.
#'     - `RetentionPct`: Retention percentage.
#'   - `"data"`: A list containing `summary`, `person_status`, and `breakdown`.
#'   - `"message"`: Prints a formatted message; returns the summary tibble
#'     invisibly.
#'
#' @examples
#' \dontrun{
#' # Retention of Power/Habitual users from Nov 2025 to Jan 2026
#' identify_retention(
#'   data = pq_week_df,
#'   start_x = "2025-11-01",
#'   end_x = "2025-12-01",
#'   start_y = "2026-01-01",
#'   end_y = "2026-02-01",
#'   category = "UsageSegments_12w",
#'   category_values = c("Power User", "Habitual User")
#' )
#' }
#'
#' @author Martin Chan
#' @export
identify_retention <- function(
    data,
    start_x,
    end_x,
    start_y,
    end_y = NULL,
    category,
    category_values = TRUE,
    return = "summary"
) {

  # Input validation
  if (!inherits(data, "data.frame")) {
    stop("`data` must be a data frame.")
  }

  required_cols <- c("PersonId", "MetricDate", category)
  missing_cols <- setdiff(required_cols, names(data))
  if (length(missing_cols) > 0) {
    stop("Missing required columns: ", paste(missing_cols, collapse = ", "))
  }

  if (!return %in% c("summary", "data", "message")) {
    stop("`return` must be one of: 'summary', 'data', 'message'")
  }

  # Convert dates if character
  start_x <- as.Date(start_x)
  end_x   <- as.Date(end_x)
  start_y <- as.Date(start_y)
  if (!is.null(end_y)) {
    end_y <- as.Date(end_y)
  }

  # Step 1: Identify people meeting category condition in period X
  period_x_data <- data %>%
    dplyr::filter(
      MetricDate >= start_x,
      MetricDate < end_x
    )

  # Filter for those meeting the category condition
  if (is.logical(category_values) && isTRUE(category_values)) {
    period_x_positive <- period_x_data %>%
      dplyr::filter(
        !!rlang::sym(category) == TRUE | !!rlang::sym(category) == 1
      )
  } else {
    period_x_positive <- period_x_data %>%
      dplyr::filter(!!rlang::sym(category) %in% category_values)
  }

  # Get unique PersonIds from period X
  persons_in_x <- period_x_positive %>%
    dplyr::distinct(PersonId) %>%
    dplyr::pull(PersonId)

  if (length(persons_in_x) == 0) {
    warning("No individuals found meeting the category condition in period X.")
    return(NULL)
  }

  # Step 2: Check their status in period Y
  period_y_data <- data %>%
    dplyr::filter(
      MetricDate >= start_y,
      PersonId %in% persons_in_x
    )

  if (!is.null(end_y)) {
    period_y_data <- period_y_data %>%
      dplyr::filter(MetricDate < end_y)
  }

  # Get the latest status for each person in period Y
  period_y_status <- period_y_data %>%
    dplyr::arrange(PersonId, MetricDate) %>%
    dplyr::group_by(PersonId) %>%
    dplyr::summarise(
      LatestCategory = dplyr::last(!!rlang::sym(category)),
      LatestDate     = max(MetricDate),
      .groups = "drop"
    )

  # Determine if still in positive category
  if (is.logical(category_values) && isTRUE(category_values)) {
    period_y_status <- period_y_status %>%
      dplyr::mutate(
        StillPositive = LatestCategory == TRUE | LatestCategory == 1
      )
  } else {
    period_y_status <- period_y_status %>%
      dplyr::mutate(
        StillPositive = LatestCategory %in% category_values
      )
  }

  # Step 3: Calculate retention statistics
  n_original     <- length(persons_in_x)
  n_tracked      <- nrow(period_y_status)
  n_retained     <- sum(period_y_status$StillPositive, na.rm = TRUE)
  n_lost         <- n_original - n_tracked
  retention_pct  <- if (n_tracked > 0) n_retained / n_tracked * 100 else NA

  period_y_end_val <- if (!is.null(end_y)) {
    end_y
  } else if (nrow(period_y_data) > 0) {
    max(period_y_data$MetricDate, na.rm = TRUE)
  } else {
    NA
  }

  # Create summary tibble
  summary_df <- tibble::tibble(
    PeriodX_Start   = start_x,
    PeriodX_End     = end_x,
    PeriodY_Start   = start_y,
    PeriodY_End     = period_y_end_val,
    Category        = category,
    CategoryValues  = paste(category_values, collapse = ", "),
    N_Original      = n_original,
    N_Tracked       = n_tracked,
    N_Lost          = n_lost,
    N_Retained      = n_retained,
    RetentionPct    = round(retention_pct, 1)
  )

  # Breakdown by latest category
  breakdown <- period_y_status %>%
    dplyr::count(LatestCategory) %>%
    dplyr::mutate(Pct = round(n / sum(n) * 100, 1)) %>%
    dplyr::arrange(dplyr::desc(n))

  # Return based on parameter
  if (return == "summary") {

    summary_df

  } else if (return == "data") {

    list(
      summary       = summary_df,
      person_status = period_y_status,
      breakdown     = breakdown
    )

  } else if (return == "message") {

    period_x_label <- paste0(
      format(start_x, "%b %Y"), " - ", format(end_x - 1, "%b %Y")
    )
    period_y_end_label <- if (!is.null(end_y)) {
      format(end_y - 1, "%b %Y")
    } else {
      "latest"
    }
    period_y_label <- paste0(
      format(start_y, "%b %Y"), " - ", period_y_end_label
    )

    message("\n=== RETENTION ANALYSIS ===")
    message("Category: ", category, " = ", paste(category_values, collapse = " / "))
    message("Period X: ", period_x_label)
    message("Period Y: ", period_y_label)
    message("---")
    message("Original in Period X: ", n_original)
    message("Tracked in Period Y: ", n_tracked)
    if (n_lost > 0) message("Lost (not in Period Y): ", n_lost)
    message("Still in category: ", n_retained)
    message("Retention rate: ", round(retention_pct, 1), "%")
    message("\nBreakdown in Period Y:")
    print(breakdown)
    message("===========================\n")

    invisible(summary_df)
  }
}
