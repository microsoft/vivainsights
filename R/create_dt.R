# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See LICENSE.txt in the project root for license information.
# --------------------------------------------------------------------------------------------

#' @title Create interactive tables in HTML with 'download' buttons.
#'
#' @description
#' See
#' <https://martinctc.github.io/blog/vignette-downloadable-tables-in-rmarkdown-with-the-dt-package/>
#' for more.
#'
#' @details
#' This is exported from `wpa::create_dt()`.
#'
#' @param x Data frame to be passed through.
#' @param rounding Numeric vector to specify the number of decimal points to display
#' @param freeze Number of columns from the left to 'freeze'. Defaults to 2,
#' which includes the row number column.
#' @param percent Logical value specifying whether to display numeric columns
#' as percentages.
#'
#' @importFrom dplyr mutate_if
#'
#' @family Import and Export
#'
#' @examples
#' output <- hrvar_count(pq_data, return = "table")
#' create_dt(output)
#'
#' @return
#' Returns an HTML widget displaying rectangular data.
#'
#' @export
create_dt <- function(x, rounding = 1, freeze = 2, percent = FALSE){

  wpa::create_dt(
    x = x,
    rounding = rounding,
    freeze = freeze,
    percent = percent
  )

}