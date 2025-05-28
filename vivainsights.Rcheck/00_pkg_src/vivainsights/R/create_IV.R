# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See LICENSE.txt in the project root for license information.
# --------------------------------------------------------------------------------------------

#' @title Compute Information Value for Predictive Variables
#'
#' @description This function calculates the Information Value (IV) for the
#' selected numeric predictor variables in the dataset, given a specified
#' outcome variable. The Information Value provides a measure of the predictive
#' power of each variable in relation to the outcome variable, which can be
#' useful in feature selection for predictive modeling.
#'
#' @details
#' This is a wrapper around `wpa::create_IV()`.
#'
#' @param data A Person Query dataset in the form of a data frame.
#' @param predictors A character vector specifying the columns to be used as
#'   predictors. Defaults to NULL, where all numeric vectors in the data will be
#'   used as predictors.
#' @param outcome String specifying the column name for a binary variable,
#'   containing only the values 1 or 0.
#' @param bins Number of bins to use, defaults to 5.
#' @param siglevel Significance level to use in comparing populations for the
#'   outcomes, defaults to 0.05
#' @param exc_sig Logical value determining whether to exclude values where the
#'   p-value lies below what is set at `siglevel`. Defaults to `FALSE`, where
#'   p-value calculation does not happen altogether.
#' @param return String specifying what to return. This must be one of the
#'   following strings:
#'   - `"plot"`
#'   - `"summary"`
#'   - `"list"`
#'   - `"plot-WOE"`
#'   - `"IV"`
#'
#' See `Value` for more information.
#'
#' @return
#' A different output is returned depending on the value passed to the `return`
#' argument:
#'   - `"plot"`: 'ggplot' object. A bar plot showing the IV value of the top
#'   (maximum 12) variables.
#'   - `"summary"`: data frame. A summary table for the metric.
#'   - `"list"`: list. A list of outputs for all the input variables.
#'   - `"plot-WOE"`: A list of 'ggplot' objects that show the WOE for each
#'   predictor used in the model.
#'   - `"IV"` returns a list object which mirrors the return
#'   in `Information::create_infotables()`.
#'
#' @import dplyr
#'
#' @family Variable Association
#' @family Information Value
#'
#' @examples
#' # Return a summary table of IV
#' pq_data %>%
#'   dplyr::mutate(X = ifelse(Internal_network_size > 40, 1, 0)) %>%
#'   create_IV(outcome = "X",
#'             predictors = c("Email_hours",
#'                            "Meeting_hours",
#'                            "Chat_hours"),
#'             return = "plot")
#'
#'
#' # Return summary
#' pq_data %>%
#'   dplyr::mutate(X = ifelse(Internal_network_size > 40, 1, 0)) %>%
#'   create_IV(outcome = "X",
#'             predictors = c("Email_hours", "Meeting_hours"),
#'             return = "summary")
#'
#' @export
create_IV <- function(data,
                      predictors = NULL,
                      outcome,
                      bins = 5,
                      siglevel = 0.05,
                      exc_sig = FALSE,
                      return = "plot"){

  # Input validation
  if (!is.data.frame(data)) {
    stop("The 'data' parameter should be a data frame.")
  }

  if (!is.null(predictors) && !all(predictors %in% names(data))) {
    stop("Some predictors are not present in the data.")
  }

  if (!outcome %in% names(data)) {
    stop("The outcome variable is not present in the data.")
  }

  if (!all(data[[outcome]] %in% c(0, 1))) {
    stop("The outcome variable should be binary (0 or 1).")
  }

  wpa::create_IV(
    data = data,
    predictors = predictors,
    outcome = outcome,
    bins = bins,
    siglevel = siglevel,
    exc_sig = exc_sig,
    return = return
  )

}
