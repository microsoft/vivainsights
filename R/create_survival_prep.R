# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See LICENSE.txt in the project root for license information.
# --------------------------------------------------------------------------------------------

#' @title Prepare Survival Data from a Panel Dataset
#'
#' @description
#' Converts a Standard Person Query (panel) dataset into a person-level survival
#' table suitable for direct use with \code{\link{create_survival}}.
#'
#' Each person's weekly rows are reduced to a single row containing:
#' \itemize{
#'   \item \code{time}: the number of periods from the first observation until
#'     the event condition is first met. If the condition is never met,
#'     \code{time} equals the total number of observed periods (censored).
#'   \item \code{event}: \code{1} if the condition was met at any point in the
#'     observation window, \code{0} if the person was censored (never met it).
#' }
#'
#' Although rooted in survival analysis, the \code{event_condition} is typically
#' a **positive milestone** in a workforce context — first use of a tool, first
#' week as a power user, first week crossing a collaboration threshold.
#' The resulting curve is therefore often better described as a
#' **time-to-adoption**, **conversion**, or **graduation** curve.
#' See \code{\link{create_survival}} for further framing guidance.
#'
#' @param data A Standard Person Query dataset in the form of a data frame.
#' @param metric Character string containing the name of the metric column to
#'   evaluate the event condition on.
#' @param event_condition A function that takes a numeric vector and returns a
#'   logical vector. Applied to \code{metric} to mark whether the event occurred
#'   in a given period. Defaults to \code{function(x) x > 0} (any non-zero
#'   value is treated as the event).
#' @param hrvar Character string containing the name of the HR attribute column
#'   to carry through into the output. The most recent (last observed) value per
#'   person is used. Defaults to \code{"Organization"}. Set to \code{NULL} to
#'   omit.
#'
#' @return A data frame with one row per person containing:
#' \itemize{
#'   \item \code{PersonId}
#'   \item \code{time}: numeric — periods until event, or total observed periods
#'     if censored
#'   \item \code{event}: integer — \code{1} (event) or \code{0} (censored)
#'   \item The \code{hrvar} column, if supplied
#' }
#'
#' @import dplyr
#' @importFrom rlang .data
#'
#' @family Transformation
#' @seealso \code{\link{create_survival}}
#'
#' @examples
#' # \dontrun{
#' # library(vivainsights)
#' # data("pq_data", package = "vivainsights")
#' #
#' # # Step 1: derive person-level survival data
#' # surv_data <- create_survival_prep(
#' #   data = pq_data,
#' #   metric = "Copilot_actions_taken_in_Teams",
#' #   event_condition = function(x) x > 0
#' # )
#' #
#' # # Step 2: visualise
#' # create_survival(
#' #   data = surv_data,
#' #   time_col = "time",
#' #   event_col = "event",
#' #   hrvar = "Organization"
#' # )
#' # }
#' @export
create_survival_prep <- function(data,
                                 metric,
                                 event_condition = function(x) x > 0,
                                 hrvar = "Organization") {

  ## Input validation
  required_cols <- unique(c("PersonId", "MetricDate", metric))
  if (!is.null(hrvar)) required_cols <- c(required_cols, hrvar)

  data %>% .check_inputs_safe(requirements = required_cols)

  if (!is.function(event_condition)) {
    stop("`event_condition` must be a function, e.g. `function(x) x > 0`.")
  }

  ## Sort chronologically within each person so period indices are meaningful
  df <- data %>%
    dplyr::arrange(.data$PersonId, .data$MetricDate)

  ## Evaluate event condition row-by-row
  flags <- event_condition(df[[metric]])

  if (!is.logical(flags)) {
    stop("`event_condition` must return a logical vector.")
  }

  df$.event_flag <- flags

  hrvar_cols <- if (!is.null(hrvar)) hrvar else character(0)

  ## Reduce to one row per person -------------------------------------------------
  ## .first_event: index of the first period where the condition is TRUE.
  ##   which() ignores NAs; min() of an empty vector returns Inf (with a
  ##   suppressable warning), signalling that the person is censored.
  per_person <- df %>%
    dplyr::group_by(.data$PersonId) %>%
    dplyr::summarise(
      .n_periods   = dplyr::n(),
      .first_event = suppressWarnings(min(which(.data$.event_flag))),
      event        = as.integer(any(.data$.event_flag, na.rm = TRUE)),
      dplyr::across(dplyr::all_of(hrvar_cols), dplyr::last),
      .groups = "drop"
    ) %>%
    dplyr::mutate(
      time = dplyr::if_else(
        is.infinite(.data$.first_event),
        as.numeric(.data$.n_periods),   # censored: survived the full window
        as.numeric(.data$.first_event)  # event: period of first occurrence
      )
    ) %>%
    dplyr::select(dplyr::all_of(c("PersonId", "time", "event", hrvar_cols)))

  per_person
}
