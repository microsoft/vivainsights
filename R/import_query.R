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
#'
#' @param pid String specifying the unique person or individual identifier
#'   variable. `import_query` renames this to `PersonId` so that this is
#'   compatible with other functions in the package. Defaults to `NULL`, where
#'   no action is taken.
#' @param dateid String specifying the date variable. `import_query` renames
#'   this to `MetricDate` so that this is compatible with other functions in the
#'   package. Defaults to `NULL`, where no action is taken.
#' @param date_format String specifying the date format for converting any
#' variable that may be a date to a Date variable. Defaults to `"%m/%d/%Y"`.
#' @param convert_date Logical. Defaults to `TRUE`. When set to `TRUE`, any
#' variable that matches true with `is_date_format()` gets converted to a Date
#' variable. When set to `FALSE`, this step is skipped.
#'
#' @param encoding String to specify encoding to be used within
#'   `data.table::fread()`. See `data.table::fread()` documentation for more
#'   information. Defaults to `'UTF-8'`.
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

  if(convert_date == TRUE){

    # Columns which are Dates
    dateCols <- sapply(return_data, function(x) all(is_date_format(x) | any_idate(x)))

    dateCols <- names(return_data)[dateCols == TRUE]

    # Format any date columns
    return_data <-
      return_data %>%
      dplyr::mutate_at(dplyr::vars(dateCols), ~as.Date(., format = date_format))

    if(length(dateCols) >= 1){
      message("Converted the following Date variables:\n",
              paste(dateCols, collapse = ", "))
    }
  }

  # rename specified names
  if(!is.null(pid)){
    names(return_data)[names(return_data) == pid] <- "PersonId"
  }

  if(!is.null(dateid)){
    names(return_data)[names(return_data) == dateid] <- "MetricDate"
  }

  # clean names
  names(return_data) <-
    names(return_data) %>%
    gsub(pattern = " ", replacement = "_", x = .) %>% # replace spaces
    gsub(pattern = "-", replacement = "_", x = .) %>% # replace hyphens
    gsub(pattern = "[:|,]", replacement = "_", x = .) # replace : and ,

  message("Query has been imported successfully!")

  dplyr::as_tibble(return_data)
}




