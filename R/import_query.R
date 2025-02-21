# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See LICENSE.txt in the project root for license information.
# --------------------------------------------------------------------------------------------

#' @title Import a query from Viva Insights Analyst Experience
#'
#' @description Import a Viva Insights Query from a .csv file, with variable
#'   classifications optimised for other functions in the package.
#'
#' @details `import_query()` uses `data.table::fread()` to import .csv files for
#' speed, and by default `stringsAsFactors` is set to FALSE. A data frame is
#' returned by the function (not a `data.table`). Column names are automatically
#' cleaned, replacing spaces and special characters with underscores.
#'
#' @param x String containing the path to the Viva Insights query to be
#'   imported. The input file must be a .csv file, and the file extension must
#'   be explicitly entered, e.g. `"/files/standard query.csv"`
#' @param pid String specifying the unique person or individual identifier
#'   variable. `import_query` renames this to `PersonId` so that this is
#'   compatible with other functions in the package. Defaults to `NULL`, where
#'   no action is taken.
#' @param dateid String specifying the date variable. `import_query` renames
#'   this to `MetricDate` so that this is compatible with other functions in the
#'   package. Defaults to `NULL`, where no action is taken.
#' @inheritParams prep_query
#'
#' @param encoding String to specify encoding to be used within
#'   `data.table::fread()`. See `data.table::fread()` documentation for more
#'   information. Defaults to `'UTF-8'`.
#'   
#'
#' @return A `tibble` is returned.
#'
#' @family Import and Export
#'
#' @export
import_query <- function(x,
                         pid = NULL,
                         dateid = NULL,
                         date_format = "%m/%d/%Y",
                         convert_date = TRUE,
                         encoding = 'UTF-8') {

  # import data
  return_data <-
    data.table::fread(x,
                      stringsAsFactors = FALSE,
                      encoding = encoding) %>%
    as.data.frame()

  # rename specified names
  if(!is.null(pid)){
    names(return_data)[names(return_data) == pid] <- "PersonId"
  }

  if(!is.null(dateid)){
    names(return_data)[names(return_data) == dateid] <- "MetricDate"
  }
  
  prep_query(
    data = return_data,
    date_format = date_format,
    convert_date = convert_date
  )
}




