# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See LICENSE.txt in the project root for license information.
# --------------------------------------------------------------------------------------------

#' @title Extract HR attribute variables
#'
#' @description
#' This function uses a combination of variable class,
#' number of unique values, and regular expression matching
#' to extract HR / organisational attributes from a data frame.
#'
#' @param data A data frame to be passed through.
#' @param max_unique A numeric value representing the maximum
#' number of unique values to accept for an HR attribute. Defaults to 50.
#' Any column with `max_unique` or more unique values is excluded, and a
#' message is displayed listing those columns and their unique-value counts.
#' @param exclude_constants Logical value to specify whether single-value HR
#' attributes are to be excluded. Defaults to `TRUE`.
#'
#' @param return String specifying what to return. This must be one of the
#'   following strings:
#'   - `"names"`
#'   - `"vars"`
#'
#' See `Value` for more information.

#' @return
#' A different output is returned depending on the value passed to the `return`
#' argument:
#'   - `"names"`: character vector identifying all the names of HR variables
#'   present in the data.
#'   - `"vars"`: data frame containing all the columns of HR variables present
#'    in the data.
#'
#' @family Support
#' @family Data Validation
#'
#' @examples
#' pq_data %>% extract_hr(return = "names")
#'
#' pq_data %>% extract_hr(return = "vars")
#'
#' @export
extract_hr <- function(data,
                       max_unique = 50,
                       exclude_constants = TRUE,
                       return = "names"){


  if(exclude_constants == TRUE){

    min_unique = 1

  } else if (exclude_constants == FALSE){

    min_unique = 0

  }

  # Candidate columns: character, logical, or factor, not date-formatted,
  # and not the Outlook working-time columns
  excluded_names <- c(
    "WorkingStartTimeSetInOutlook",
    "WorkingEndTimeSetInOutlook",
    "WorkingDaysSetInOutlook"
  )

  candidates <-
    data %>%
    dplyr::select(where(~(is.character(.) | is.logical(.) | is.factor(.)))) %>%
    dplyr::select(where(~!all(is_date_format(.)))) %>%
    dplyr::select(where(~(dplyr::n_distinct(.) > min_unique))) %>%
    names() %>%
    setdiff(excluded_names)

  # Identify columns excluded due to max_unique threshold
  over_max <- candidates[
    vapply(candidates, function(col) dplyr::n_distinct(data[[col]]) >= max_unique, logical(1))
  ]

  if(length(over_max) > 0){
    unique_counts <- vapply(over_max, function(col) dplyr::n_distinct(data[[col]]), integer(1))
    col_details <- paste(over_max, paste0("(", unique_counts, ")"), sep = " ", collapse = ", ")
    message(
      length(over_max), " column(s) excluded due to max_unique = ", max_unique,
      ": ", col_details, ".\n",
      "Adjust the `max_unique` argument if you wish to include these columns."
    )
  }

  hr_var <- setdiff(candidates, over_max)

  if(return == "names"){
    return(hr_var)
  } else if(return == "vars"){
    return(dplyr::select(data, tidyselect::all_of(hr_var)))
  } else {
   stop("Invalid input for return")
  }
}



