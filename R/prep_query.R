# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See LICENSE.txt in the project root for license information.
# --------------------------------------------------------------------------------------------

#' @title Prepare variable names and types in query data frame for analysis 
#'
#' @description For applying to data frames that are read into R using _any
#'   other method_ other than `import_query()`, this function cleans variable
#'   names by replacing special characters and converting the relevant variable
#'   types so that they are compatible with the rest of the functions in
#'   **vivainsights**.
#'   
#' @param data A Standard Person Query dataset in the form of a data frame. You
#'   should pass the data frame that is read into R using _any other method_
#'   other than `import_query()`, as `import_query()` automatically performs the
#'   same variable operations.
#' @param date_format String specifying the date format for converting any
#' variable that may be a date to a Date variable. Defaults to `"%m/%d/%Y"`.
#' @param convert_date Logical. Defaults to `TRUE`. When set to `TRUE`, any
#' variable that matches true with `is_date_format()` gets converted to a Date
#' variable. When set to `FALSE`, this step is skipped.
#' 
#' @section Examples:
#' 
#' The following shows when and how to use `prep_query()`:
#' ```r
#'  pq_df <- read.csv("path_to_query.csv")
#'  cleaned_df <- pq_df |> prep_query()
#' ```
#' You can then run checks to see that the variables are of the correct type:
#' ```r
#' dplyr::glimpse(cleaned_df)
#' ```
#' 
#' @return A `tibble` with the cleaned data frame is returned.
#' 
#' @family Import and Export
#' 
#' @export
prep_query <- function(data, convert_date = TRUE, date_format = "%m/%d/%Y"){
  
  return_data <- data
  
  if(convert_date == TRUE){
    
    # Columns which are Dates
    dateCols <- sapply(return_data, function(x) all(is_date_format(x) | any_idate(x)))
    
    dateCols <- names(return_data)[dateCols == TRUE]
    
    # Format any date columns
    return_data <-
      return_data %>%
      dplyr::mutate(dplyr::across(dplyr::all_of(dateCols), ~as.Date(., format = date_format)))
    
    if(length(dateCols) >= 1){
      message("Converted the following Date variables:\n",
              paste(dateCols, collapse = ", "))
    }
  }
  
  # clean names
  names(return_data) <-
    names(return_data) %>%
    gsub(pattern = " ", replacement = "_", x = .) %>% # replace spaces
    gsub(pattern = "-", replacement = "_", x = .) %>% # replace hyphens
    gsub(pattern = "[:|,]", replacement = "_", x = .) %>% # replace : and ,
    gsub(pattern = "[(|)]", replacement = "_", x = .) %>% # replace brackets
    gsub(pattern = "\\.", replacement = "_", x = .)
  
  # Warn about missing values in `MetricDate`
  if(sum(is.na(return_data$MetricDate)) > 0){
    message(
    "Warning: Missing values found in `MetricDate` column.\n
    Date format conversion may not have been successful.\n
    Please check input to `date_format`"
    )
  }
  
  
  
  
  dplyr::as_tibble(return_data)
}