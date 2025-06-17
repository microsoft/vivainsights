# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See LICENSE.txt in the project root for license information.
# --------------------------------------------------------------------------------------------

#' @title 
#' Identify whether a habitual behaviour exists over a given interval of time
#' 
#' @description `r lifecycle::badge('experimental')`
#' 
#' Based on the principle of consistency, this function identifies whether a
#' habit exists over a given interval of time. A habit is defined as a behaviour
#' (action taken) that is repeated at least x number of times consistently over
#' n weeks.
#' 
#' @details
#' Each week is considered as a binary variable on whether sufficient action has
#' been taken for that given week (a qualifying count). Sufficiency is
#' determined by the `threshold` parameter. For instance, if the threshold is
#' set to 2, this means that there must be 2 qualifying actions (e.g. summarise
#' meeting in Copilot) in a week for there to be a qualifying count for the
#' week.
#' One way of determining the parameters would be to consider, _how many counts
#' of `width` should occur within a `max_window` period for it to be considered
#' a habit?_
#' 
#' 
#' @param data Data frame containing Person Query to be analysed. The data frame
#' must have a `PersonId`, `MetricDate` and a column containing a metric for 
#' classifying behaviour. 
#' @param metric Character string specifying the metric to be analysed.
#' @param threshold Numeric value specifying the minimum number of times the
#' metric sum up to in order to be a valid count. A 'greater than or equal to' 
#' logic is used.
#' @param width Integer specifying the number of qualifying counts to consider
#'   for a habit. The function assumes a **weekly** interval is used.
#' @param max_window Integer specifying the maximum unit of dates to consider a
#' qualifying window for a habit. If your data is grouped at a weekly level, 
#' then `max_window = 12` would consider 12 weeks.   
#' @param hrvar Character string specifying the HR attribute or organisational
#' variable to group by. Default is `NULL`.
#' @param return Character string specifying the type of output to be returned.
#' Valid options include:
#'  - `"data"`: Returns the data frame with the habit classification.
#'  - `"plot"`: Returns a ggplot object of a boxplot, showing the percentage of 
#'  periods with where habitual behaviour occurred.
#'  - `"summary"`: Returns a summary table of the habit analysis.
#' @param plot_mode Character string specifying the type of plot to be returned.
#' Only applicable when `return = "plot"`. Valid options include:
#'  - `"time"`: Returns a time series plot with the breakdown of users with 
#'  habitual behaviour.
#'  - `"boxplot"`: Returns a boxplot of the percentage of periods with habitual
#'  behaviour.
#' @param fill_col Character vector of length 2 specifying the colours to be
#' used in the plot. Only applicable when `return = "plot"` and `plot_mode = "time"`.
#'  
#' @import dplyr
#' @import tidyr
#' @importFrom glue glue
#' 
#' @examples
#' # Return a plot
#' identify_habit(
#'   pq_data,
#'   metric = "Multitasking_hours",
#'   threshold = 1,
#'   width = 9,
#'   max_window = 12,
#'   return = "plot"
#' )
#' 
#' # Return a summary
#' identify_habit(
#'   pq_data,
#'   metric = "Multitasking_hours",
#'   threshold = 1,
#'   width = 9,
#'   max_window = 12,
#'   return = "summary"
#' )
#' 
#' @export
identify_habit <- function(
    data,
    metric,
    threshold = 1,
    width,
    max_window,
    hrvar = NULL,
    return = "plot",
    plot_mode = "time",
    fill_col = c("#E5E5E5", "#0078D4")
    ){
  
  habit_df <-
    data %>%
    group_by(PersonId) %>%
    arrange(MetricDate) %>% # Ensure ranked order from low to high
    mutate(
      cumsum_value = cumsum(!!sym(metric) >= threshold),
      lagged_cumsum = lag(cumsum_value, max_window, default = 0),
      sum_last_w = cumsum_value - lagged_cumsum,
      IsHabit = sum_last_w >= width,
      HabitCurve = paste(as.numeric(IsHabit), collapse = "")
    ) %>%
    ungroup()
  
  if(return == "data"){
    
    habit_df
    
  } else if(return == "plot"){
    
    date_text <- extract_date_range(data, return = "text")
    
    new_caption <-
      glue(
        "Habit is defined as active usage in {width} periods",
        "\n with at least {threshold} counts per period, ",
        "within a maximum of {max_window} periods.",
        "\n{date_text}"
      )
    
    if(plot_mode == "time"){
      
      suppressMessages(
        habit_df %>%
          group_by(MetricDate, IsHabit) %>%
          summarise(n = n_distinct(PersonId), .groups = "drop") %>%
          ggplot(aes(x = MetricDate, y = n, fill = IsHabit)) +
          geom_bar(stat = "identity", position = "fill") +
          scale_y_continuous(labels = scales::percent) +
          scale_fill_manual(values = fill_col) +
          labs(y = "Percentage", fill = "Is Habit") +
          theme_wpa_basic() +
          labs(
            title = paste("Habitual Behaviour -", us_to_space(metric)),
            subtitle = "% with habitual behaviour by time period",
            caption = new_caption
          )
      )
      
      
    } else if(plot_mode == "boxplot"){
      
      suppressMessages(
        habit_df %>%
          create_boxplot(hrvar = hrvar, metric = "IsHabit") +
          labs(
            title = paste("Habitual Behaviour -", us_to_space(metric)),
            subtitle = "% of periods with habitual behaviour",
            y = "% of periods where habitual behaviour occurred",
            caption = new_caption
          ) +
          scale_y_continuous(labels = scales::percent)
      )
      
    } else {
      
      stop("Invalid plot mode")
      
    }
    
  } else if(return == "summary"){
    
    # Latest period / week stats
    recent_tb <-
      habit_df %>%
      group_by(PersonId) %>%
      mutate(
        LostHabit = grepl(x = HabitCurve, pattern = "10"),
        GainedHabit = grepl(x = HabitCurve, pattern = "01")
      ) %>%
      ungroup() %>%
      filter(MetricDate == max(MetricDate)) %>%
      summarise(
        `Most recent week - Total persons with habit` = sum(IsHabit, na.rm = TRUE),
        `Most recent week - % of pop with habit` =
          `Most recent week - Total persons with habit` / n_distinct(PersonId),
        `Total Persons who have lost habit` = sum(LostHabit, na.rm = TRUE),
        `% of Persons who have lost habit` = mean(LostHabit, na.rm = TRUE),
        `Total Persons who have gained habit` = sum(GainedHabit, na.rm = TRUE),
        `% of Persons who have gained habit` = mean(GainedHabit, na.rm = TRUE)
      ) %>%
      pivot_longer(
        cols = everything(),
        names_to = "Statistics",
        values_to = "Value"
      ) 
    
    
    # Distribution stats
    dist_tb <-
      habit_df %>%
      create_boxplot(hrvar = NULL, metric = "IsHabit", return = "table") %>%
      select(-group, -n) %>%
      rename(
        `Mean - % of Person-weeks with habit` = "mean",
        `Median - % of Person-weeks with habit` = "p50",
        `Min - % of Person-weeks with habit` = "min",
        `Max - % of Person-weeks with habit` = "max",
        `SD - % of Person-weeks with habit` = "sd",
        `Range - % of Person-weeks with habit` = "range"
      ) %>%
      pivot_longer(
        cols = everything(),
        names_to = "Statistics",
        values_to = "Value"
      ) 
    
    # Person-week analysis
    pw_tb <-
      habit_df %>%
      summarise(
        `Total Person-weeks with habit` = sum(IsHabit),
        `Total Person-weeks` = n(),
        `% of Person-weeks with habit` = `Total Person-weeks with habit` / `Total Person-weeks`,
        `Total Persons` = n_distinct(PersonId),
        `Total Weeks` = n_distinct(MetricDate)
      ) %>%
      pivot_longer(
        cols = everything(),
        names_to = "Statistics",
        values_to = "Value"
      ) %>%
      mutate(Value = round(Value, 2))
    
    # Combine summary
    bind_rows(
      recent_tb,
      dist_tb,
      pw_tb
    )
    
  } else {
    
    stop("Invalid return type")
    
  }
}