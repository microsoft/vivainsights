# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See LICENSE.txt in the project root for license information.
# --------------------------------------------------------------------------------------------

#' @title Identify Inactive Weeks
#'
#' @description
#' This function scans a standard query output for weeks where collaboration
#' hours is far outside the mean for any individual person in the dataset.
#' Returns a list of weeks that appear to be inactive weeks and optionally an
#' edited dataframe with outliers removed.
#'
#' As best practice, run this function prior to any analysis to remove atypical
#' collaboration weeks from your dataset.
#'
#' @param data A Standard Person Query dataset in the form of a data frame.
#' @param sd The standard deviation below the mean for collaboration hours that
#'   should define an outlier week. Enter a positive number. Default is 1
#'   standard deviation.
#' @param return String specifying what to return. This must be one of the
#'   following strings:
#'   - `"text"`
#'   - `"data_cleaned"`
#'   - `"data_clean"`
#'   - `"data_dirty"`
#'
#' See `Value` for more information.
#'
#' @import dplyr
#' @importFrom methods is
#'
#' @family Data Validation
#'
#' @return
#' Returns an error message by default, where `'text'` is returned. When
#' `'data_cleaned'` or `'data_clean'` is passed, a dataset with outlier weeks removed is returned
#' as a dataframe. When `'data_dirty'` is passed, a dataset with outlier weeks
#' is returned as a dataframe.
#'
#' @export
identify_inactiveweeks <- function(data, sd = 2, return = "text"){

  init_data <-
    data %>%
    group_by(PersonId) %>%
    mutate(z_score = (Collaboration_hours - mean(Collaboration_hours))/sd(Collaboration_hours))


  Calc <-
    init_data %>%
    filter(z_score <= -sd) %>%
    select(PersonId, MetricDate, z_score) %>%
    data.frame()

  pop_mean <-
    data %>%
    dplyr::mutate(Total = "Total") %>%
    create_bar(metric = "Collaboration_hours",
               hrvar = "Total",
               return = "table") %>%
    dplyr::pull(Collaboration_hours) %>%
    round(digits = 1)


  Message <- paste0("There are ", nrow(Calc), " rows of data with weekly collaboration hours more than ",
                    sd," standard deviations below the mean (", pop_mean, ").")

  if(return == "text"){

    return(Message)

  } else if(return == "data_dirty"){

    init_data %>%
      filter(z_score <= -sd) %>%
      select(-z_score) %>%
      data.frame()

  } else if(return %in% c("data_clean", "data_cleaned")){
    
    # Create diagnostic message for removed inactive weeks
    inactive_dates <- init_data %>%
      filter(z_score <= -sd) %>%
      pull(MetricDate) %>% 
      unique()
    
    if(length(inactive_dates) > 0) {
      # Format the dates to ISO format
      if(methods::is(inactive_dates, "Date")) {
        formatted_dates <- format(inactive_dates, "%Y-%m-%d")
      } else {
        # Attempt to convert to date if possible
        tryCatch({
          formatted_dates <- format(as.Date(inactive_dates), "%Y-%m-%d")
        }, error = function(e) {
          # If conversion fails, use as is
          formatted_dates <- as.character(inactive_dates)
        })
      }
      
      diagnostic_msg <- paste0("The weeks ", paste(formatted_dates, collapse = ", "), 
                              " have been flagged as inactive weeks and removed from the data. ",
                              "This is based on a standard deviation of ", sd, 
                              " below the mean collaboration hours.")
    } else {
      diagnostic_msg <- paste0("No inactive weeks were detected based on a standard deviation of ", 
                              sd, " below the mean collaboration hours.")
    }
    
    # Print the diagnostic message
    message(diagnostic_msg)
    
    # Return the cleaned data
    init_data %>%
      filter(z_score > -sd) %>%
      select(-z_score) %>%
      data.frame()

  } else if(return == "data"){

    init_data %>%
      mutate(inactiveweek = (z_score<= -sd)) %>%
      select(-z_score) %>%
      data.frame()

  } else {

    stop("Error: please check inputs for `return`")

  }
}
