#' @param data A Standard Person Query dataset in the form of a data frame.
#'   This must be a **panel dataset** where each row represents one employee
#'   per time period, with the columns `PersonId` and `MetricDate` present.
#'   If your data is already aggregated (e.g. one row per group), use the
#'   equivalent `*_asis()` variant of this function instead.
#' @param hrvar String containing the name of the HR Variable by which to split
#'   metrics. Defaults to `"Organization"`. To run the analysis on the total
#'   instead of splitting by an HR attribute, supply `NULL` (without quotes).
#' @param mingroup Numeric value setting the privacy threshold / minimum group
#'   size. Defaults to 5.
