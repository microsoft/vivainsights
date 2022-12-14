# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See LICENSE.txt in the project root for license information.
# --------------------------------------------------------------------------------------------

#' @title Distribution of External Collaboration Hours (Fizzy Drink plot)
#'
#' @description
#' Analyze weekly External Collaboration hours distribution, and returns
#' a 'fizzy' scatter plot by default.
#' Additional options available to return a table with distribution elements.
#'
#' @details
#' Uses the metric `Collaboration_hours_external`.
#' See `create_fizz()` for applying the same analysis to a different metric.
#'
#' @inheritParams create_fizz
#' @inherit create_fizz return
#'
#' @family Visualization
#' @family External Collaboration
#'
#' @examples
#' # Return plot
#' external_fizz(pq_data, hrvar = "LevelDesignation", return = "plot")
#'
#' # Return summary table
#' external_fizz(pq_data, hrvar = "Organization", return = "table")
#' @export

external_fizz <- function(data,
                       hrvar = "Organization",
                       mingroup = 5,
                       return = "plot"){

  create_fizz(data = data,
              metric = "External_collaboration_hours",
              hrvar = hrvar,
              mingroup = mingroup,
              return = return)

}
