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
                         encoding = 'UTF-8') {


  # import data
  return_data <-
    data.table::fread(x,
                      stringsAsFactors = FALSE,
                      encoding = encoding) %>%
    as.data.frame()

  # clean names
  names(return_data) <-
    names(return_data) %>%
    gsub(pattern = " ", replacement = "_", x = .) %>% # replace spaces
    gsub(pattern = "-", replacement = "_", x = .) %>% # replace hyphens
    gsub(pattern = "[:|,]", replacement = "_", x = .) # replace : and ,

  # Columns which are Dates
  dateCols <- sapply(return_data, function(x) all(is_date_format(x)))
  dateCols <- dateCols[dateCols == TRUE]

  # Format any date columns
  return_data <-
    return_data %>%
    dplyr::mutate_at(dplyr::vars(names(dateCols)), ~as.Date(., format = "%m/%d/%Y"))

  message("Query has been imported successfully!")

  dplyr::as_tibble(return_data)
}




