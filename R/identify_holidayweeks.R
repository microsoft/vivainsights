# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See LICENSE.txt in the project root for license information.
# --------------------------------------------------------------------------------------------

#' @title Identify Holiday Weeks based on outliers
#'
#' @description
#' This function scans a standard query output for weeks where collaboration
#' hours is far outside the mean. Returns a list of weeks that appear to be
#' holiday weeks and optionally an edited dataframe with outliers removed. By
#' default, missing values are excluded.
#'
#' As best practice, run this function prior to any analysis to remove atypical
#' collaboration weeks from your dataset.
#'
#' @template ch
#'
#' @param data A Standard Person Query dataset in the form of a data frame.
#' @param sd The standard deviation below the mean for collaboration hours that
#'   should define an outlier week. Enter a positive number. Default is 1
#'   standard deviation.
#'
#' @param return String specifying what to return. This must be one of the
#'   following strings:
#'   - `"message"` (default)
#'   - `"data"`
#'   - `"data_cleaned"`
#'   - `"data_dirty"`
#'   - `"plot"`
#'
#' See `Value` for more information.
#'
#' @return
#' A different output is returned depending on the value passed to the `return`
#' argument:
#'   - `"message"`: message on console. a message is printed identifying holiday
#'   weeks.
#'   - `"data"`: data frame. A dataset with outlier weeks flagged in a new
#'   column is returned as a dataframe.
#'   - `"data_cleaned"`: data frame. A dataset with outlier weeks removed is
#'   returned.
#'   - `"data_dirty"`: data frame. A dataset with only outlier weeks is
#'   returned.
#'   - `"plot"`: ggplot object. A line plot of Collaboration Hours with holiday
#'   weeks highlighted.
#'
#'
#' @import dplyr
#' @import ggplot2
#' @importFrom methods is
#'
#' @family Data Validation
#'
#' @examples
#' # Return a message by default
#' identify_holidayweeks(pq_data)
#'
#' # Return plot
#' identify_holidayweeks(pq_data, return = "plot")
#'
#' @export
identify_holidayweeks <- function(data, sd = 1, return = "message"){

  ## Ensure date is formatted
  if(all(is_date_format(data$MetricDate))){
    data$MetricDate <- as.Date(data$MetricDate, format = "%m/%d/%Y")
  } else if(is(data$MetricDate, "Date")){
  # Do nothing
  } else {
    stop("`MetricDate` appears not to be properly formatted.\n
         It needs to be in the format MM/DD/YYYY.\n
         Also check for missing values or stray values with inconsistent formats.")
  }

  Calc <-
    data %>%
    group_by(MetricDate) %>%
    summarize(mean_collab = mean(Collaboration_hours, na.rm = TRUE),.groups = 'drop') %>%
    mutate(z_score = (mean_collab - mean(mean_collab, na.rm = TRUE))/ sd(mean_collab, na.rm = TRUE))

  Outliers <- (Calc$MetricDate[Calc$z_score < -sd])

  mean_collab_hrs <- mean(Calc$mean_collab, na.rm = TRUE)

  Message <- paste0("The weeks where collaboration was ",
                   sd,
                   " standard deviations below the mean (",
                   round(mean_collab_hrs, 1),
                   ") are: \n",
                   paste(wrap(Outliers, wrapper = "`"),collapse = ", "))

  myTable_plot <-
    data %>%
    mutate(holidayweek = (MetricDate %in% Outliers)) %>%
    select("MetricDate", "holidayweek", "Collaboration_hours") %>%
    group_by(MetricDate) %>%
    summarise(
      Collaboration_hours = mean(Collaboration_hours),
      holidayweek = first(holidayweek)) %>%
    mutate(MetricDate = as.Date(MetricDate, format = "%m/%d/%Y"))

  myTable_plot_shade <-
    myTable_plot %>%
    filter(holidayweek == TRUE) %>%
    mutate(min = MetricDate - 3 , max = MetricDate + 3 , ymin = -Inf, ymax = +Inf)

  plot <-
    myTable_plot %>%
    ggplot(aes(x = MetricDate, y = Collaboration_hours, group = 1)) +
    geom_line(colour = "grey40") +
    theme_wpa_basic() +
    geom_rect(data = myTable_plot_shade,
              aes(xmin = min,
                  xmax = max,
                  ymin = ymin,
                  ymax = ymax),
              color = "transparent",
              fill = "steelblue",
              alpha = 0.3) +
    labs(title = "Holiday Weeks",
         subtitle = "Showing average collaboration hours over time")+
    ylab("Collaboration Hours") +
    xlab("Date") +
    ylim(0, NA) # Set origin to zero

  if(return == "text"){

    return(Message)

  } else if(return == "message"){

    message(Message)

  } else if(return %in% c("data_clean", "data_cleaned")){
    
    # Create diagnostic message for removed holiday weeks
    if(length(Outliers) > 0) {
      diagnostic_msg <- paste0("The weeks ", paste(format(Outliers, "%Y-%m-%d"), collapse = ", "), 
                              " have been flagged as holiday weeks and removed from the data. ",
                              "This is based on a standard deviation of ", sd, 
                              " below the mean collaboration hours.")
    } else {
      diagnostic_msg <- paste0("No holiday weeks were detected based on a standard deviation of ", 
                              sd, " below the mean collaboration hours.")
    }
    
    # Print the diagnostic message
    message(diagnostic_msg)
    
    # Return the cleaned data
    data %>% filter(!(MetricDate %in% Outliers))

  } else if(return == "data_dirty"){

    data %>% filter((MetricDate %in% Outliers))

  } else if(return == "data"){

    data %>% mutate(holidayweek = (MetricDate %in% Outliers))

  } else if(return == "plot"){

    return(plot)

  } else {

    stop("Invalid input for `return`.")

  }
}





