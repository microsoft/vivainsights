# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See LICENSE.txt in the project root for license information.
# --------------------------------------------------------------------------------------------

#' @title Identify Usage Segments based on a metric
#'   
#' @description 
#' This function identifies users into usage segments based on their usage
#' volume and consistency. The segments 'Power Users', 'Habitual Users', 'Novice
#' Users', 'Low Users', and 'Non-users' are created. There are two versions, one
#' based on a rolling 12-week average (`version = "12w"`) and the other on a
#' rolling 4-week average (`version = "4w"`). While a main use case is for
#' Copilot metrics e.g. 'Total_Copilot_actions', this function can be applied to
#' other metrics, such as 'Chats_sent'.
#'
#' @details
#' There are two versions of usage segments, one based on a rolling 12-week
#' period (`version = "12w"`) and the other on a rolling 4-week period (`version
#' = "4w"`). This function assumes that in the input dataset is grouped at the 
#' weekly level by the `MetricDate` column. 
#' 
#' The definitions of the segments as per the 12-week definition are
#' as follows:
#' 
#'   - **Power User**: Averaging 15+ weekly actions and any actions in at least 
#'   9 out of past 12 weeks
#'   - **Habitual User**: Any action in at least 9 out of past 12 weeks
#'   - **Novice User**: Averaging at least one action over the last 12 weeks
#'   - **Low User**: Any action in the past 12 weeks
#'   - **Non-user**: No actions in the past 12 weeks
#'   
#' The definitions of the segments as per the 4-week definition are
#' as follows:
#' 
#'  - **Power User**: Averaging 15+ weekly actions and any actions in at least 4
#'   out of past 4 weeks
#'  - **Habitual User**: Any action in at least 4 out of past 4 weeks
#'  - **Novice User**: Averaging at least one action over the last 4 weeks
#'  - **Low User**: Any action in the past 4 weeks
#'  - **Non-user**: No actions in the past 4 weeks
#'  
#'   
#' @param data A data frame with a Person query containing the metric to be
#'   classified. The data frame must include a `PersonId` column and a
#'   `MetricDate` column.
#' @param metric A string representing the name of the metric column to be
#'   classified. This parameter is used when a single column represents the
#'   metric.
#' @param metric_str A character vector representing the names of multiple
#'   columns to be aggregated for calculating a target metric, using row sum for
#'   aggregation. This is used when `metric` is not provided.
#' @param version A string indicating the version of the classification to be
#'   used. Valid options are `"12w"` for a 12-week rolling average, `"4w"`
#'   for a 4-week rolling average, or `NULL` when using custom parameters. Defaults to `"12w"`.
#' @param threshold Numeric value specifying the minimum number of times the
#'   metric sum up to in order to be a valid count. A 'greater than or equal to' 
#'   logic is used. Only used when `version` is `NULL`.
#' @param width Integer specifying the number of qualifying counts to consider
#'   for a habit. Only used when `version` is `NULL`.
#' @param max_window Integer specifying the maximum unit of dates to consider a
#'   qualifying window for a habit. Only used when `version` is `NULL`.
#' @param return A string indicating what to return from the function. Valid
#'   options are: 
#'   - `"data"`: Returns the data frame with usage segments.
#'   - `"plot"`: Returns a plot of the usage segments.
#'   
#' @return Depending on the `return` parameter, either a data frame with usage 
#'   segments or a plot visualizing the segments over time. If `"data"` is passed
#'   to `return`, the following additional columns are appended:
#'   
#'   - When `version` is `"12w"` or `"4w"`:
#'     - `IsHabit12w`: Indicates whether the user has a habit based on the 12-week 
#'     rolling average.
#'     - `IsHabit4w`: Indicates whether the user has a habit based on the 4-week
#'     rolling average.
#'     - `UsageSegments_12w`: The usage segment classification based on the 
#'     12-week rolling average.
#'     - `UsageSegments_4w`: The usage segment classification based on the 4-week 
#'     rolling average.
#'   - When `version` is `NULL`:
#'     - `IsHabit`: Indicates whether the user has a habit based on the provided
#'     parameters.
#'     - `UsageSegments`: The usage segment classification based on the provided
#'     parameters.
#'   
#'  @import slider slide_dbl  
#'   
#' @examples
#' # Example usage with a single metric column
#' identify_usage_segments(
#'   data = pq_data,
#'   metric = "Emails_sent",
#'   version = "12w",
#'   return = "plot"
#' )
#' 
#' # Example usage with multiple metric columns
#' identify_usage_segments(
#'   data = pq_data,
#'   metric_str = c(
#'     "Copilot_actions_taken_in_Teams",
#'     "Copilot_actions_taken_in_Outlook",
#'     "Copilot_actions_taken_in_Excel",
#'     "Copilot_actions_taken_in_Word",
#'     "Copilot_actions_taken_in_Powerpoint"
#'   ),
#'   version = "4w",
#'   return = "plot"
#' )
#' 
#' # Example usage with custom parameters
#' identify_usage_segments(
#'   data = pq_data,
#'   metric = "Emails_sent",
#'   version = NULL,
#'   threshold = 2,
#'   width = 5,
#'   max_window = 8,
#'   return = "plot"
#' )
#' @export
identify_usage_segments <- function(
    data,
    metric = NULL,
    metric_str = NULL,
    version = "12w",
    threshold = NULL,
    width = NULL,
    max_window = NULL,
    return = "data"
    ) {
  
  if(is.null(metric) & is.null(metric_str)){
    stop("Please provide either a metric or a metric_str")
  } else if(!is.null(metric) & !is.null(metric_str)){
    stop("Please provide either a metric or a metric_str, not both")
  }
  
  # Validate version and custom parameters
  if(!is.null(version) && !version %in% c("12w", "4w")){
    stop("Please provide either `12w`, `4w`, or NULL to `version`")
  }
  
  if(is.null(version)){
    if(is.null(threshold) || is.null(width) || is.null(max_window)){
      stop("When `version` is NULL, please provide values for `threshold`, `width`, and `max_window`")
    }
  }
  
  if(is.null(metric_str)){
    prep_df <- data %>%
      mutate(target_metric = !!sym(metric))
  } else if(is.null(metric)){
    prep_df <- data %>%
      mutate(target_metric =
               select(., all_of(metric_str)) %>%
               rowSums(., na.rm = TRUE))
  }
  
  # Create rolling averages
  prep_df_2 <-
    prep_df %>%
    group_by(PersonId) %>%
    # Rolling averages of the metric from the last 12 weeks
    mutate(
      target_metric_l12w = slider::slide_dbl(
        target_metric,
        mean,
        na.rm = TRUE,
        .before = 11,
        .after = 0
      )) %>%
    # Rolling averages - last 4 weeks
    mutate(
      target_metric_l4w = slider::slide_dbl(
        target_metric,
        mean,
        na.rm = TRUE,
        .before = 3,
        .after = 0
      )) %>%
    ungroup()
  
  # Create habits based on provided parameters or default versions
  if(is.null(version)){
    # Create habits based on custom parameters
    habit_df <-
      prep_df_2 %>%
      identify_habit(
        metric = "target_metric",
        threshold = threshold,
        width = width,
        max_window = max_window,
        return = "data"
      ) %>%
      select(PersonId, MetricDate, IsHabit)
    
    # Calculate the appropriate metric window average based on max_window
    # Add a new column to prep_df_2 for the custom window average
    prep_df_custom <- 
      prep_df_2 %>%
      group_by(PersonId) %>%
      # Rolling averages for the custom window
      mutate(
        target_metric_custom = slider::slide_dbl(
          target_metric,
          mean,
          na.rm = TRUE,
          .before = max_window - 1,
          .after = 0
        )
      ) %>%
      ungroup()
    
    # Main data frame with custom Usage Segments
    main_us_df <-
      prep_df_custom %>%
      left_join(habit_df, by = c("PersonId", "MetricDate")) %>%
      mutate(
        UsageSegments = case_when(
          IsHabit == TRUE & target_metric_custom >= 15 ~ "Power User",
          IsHabit == TRUE ~ "Habitual User",
          target_metric_custom >= 1 ~ "Novice User",
          target_metric_custom > 0 ~ "Low User",
          target_metric_custom == 0 ~ "Non-user",
          TRUE ~ NA_character_
        ) %>%
          factor(levels = c(
            "Power User",
            "Habitual User",
            "Novice User",
            "Low User",
            "Non-user"
          ))
      )
  } else {
    # Create habits based on 12 weeks
    habit_df_12w <-
      prep_df_2 %>%
      identify_habit(
        metric = "target_metric",
        threshold = 1,
        width = 9,
        max_window = 12,
        return = "data"
      ) %>%
      rename(IsHabit12w = "IsHabit") %>%
      select(PersonId, MetricDate, IsHabit12w)
    
    # Create habits based on 4 weeks
    habit_df_4w <-
      prep_df_2 %>%
      identify_habit(
        metric = "target_metric",
        threshold = 1,
        width = 4,
        max_window = 4,
        return = "data"
      ) %>%
      rename(IsHabit4w = "IsHabit") %>%
      select(PersonId, MetricDate, IsHabit4w)
    
    # Main data frame with Usage Segments
    main_us_df <-
      prep_df_2 %>%
      left_join(habit_df_4w, by = c("PersonId", "MetricDate")) %>%
      left_join(habit_df_12w, by = c("PersonId", "MetricDate")) %>%
      mutate(
        UsageSegments_12w = case_when(
          IsHabit12w == TRUE & target_metric_l12w >= 15 ~ "Power User",
          IsHabit12w == TRUE ~ "Habitual User",
          target_metric_l12w >= 1 ~ "Novice User",
          target_metric_l12w > 0 ~ "Low User",
          target_metric_l12w == 0 ~ "Non-user",
          TRUE ~ NA_character_
        ) %>%
          factor(levels = c(
            "Power User",
            "Habitual User",
            "Novice User",
            "Low User",
            "Non-user"
          ))
      ) %>%
      mutate(
        UsageSegments_4w = case_when(
          IsHabit4w == TRUE & target_metric_l4w >= 15 ~ "Power User",
          IsHabit4w == TRUE ~ "Habitual User",
          target_metric_l4w >= 1 ~ "Novice User",
          target_metric_l4w > 0 ~ "Low User",
          target_metric_l4w == 0 ~ "Non-user",
          TRUE ~ NA_character_
        ) %>%
          factor(levels = c(
            "Power User",
            "Habitual User",
            "Novice User",
            "Low User",
            "Non-user"
          ))
      )
  }
  
  if(return == "data"){
    
    main_us_df
    
  } else if(return == "plot"){
    
    if(is.null(version)){
      main_us_df %>%
        plot_ts_cus(
          data = ., 
          cus = "UsageSegments", 
          threshold = threshold,
          width = width,
          max_window = max_window
        )
    } else if(version == "12w"){
      main_us_df %>%
        plot_ts_us(cus = "UsageSegments_12w", caption = "Usage Segments - 12 weeks")
    } else if(version == "4w"){
      main_us_df %>%
        plot_ts_us(cus = "UsageSegments_4w", caption = "Usage Segments - 4 weeks")
    } else {
      stop("Please provide either `12w`, `4w`, or NULL to `version`")
    }
  }
}


#' @title Plot Usage Segments over time
#' 
#' @description Returns a vertical stacked bar plot that displays the proportion 
#'   of the Usage Segments over time. This visualization helps to understand 
#'   the distribution of user segments across different time periods. While a main use case 
#'   is for Copilot metrics, this function can be applied to other metrics, such as 'Chats_sent'.
#' 
#' @param data A data frame with a column containing the Usage Segments, 
#'   denoted by `cus`. The data frame must also include a `MetricDate` column.
#' @param cus A string representing the name of the column containing the usage 
#'   segment classifications (e.g., "UsageSegments_12w").
#' @param caption A string representing the caption for the plot. This is typically 
#'   used to provide additional context or information about the visualization.
#' 
#' @return A ggplot object representing the stacked bar plot of usage segments.

plot_ts_us <- function(data, cus, caption){
  
  data %>%
    count(MetricDate, !!sym(cus)) %>%
    group_by(MetricDate) %>%
    mutate(prop = n / sum(n)) %>%
    ggplot(aes(x = MetricDate, y = prop, fill = !!sym(cus))) +
    geom_bar(stat = "identity") +
    scale_y_continuous(labels = scales::percent) +
    scale_fill_manual(values = c("#0c336e", "#1c66b0", "#80baea", "grey", "#808080")) +
    labs(
      title = "Usage Segments",
      subtitle = "Proportion of users in each segment",
      x = "Date",
      y = "Proportion of users",
      fill = "Usage Segment",
      caption = caption
    ) +
    theme_wpa_basic()
  
}


#' @title Plot Usage Segments over time with custom parameters
#' 
#' @description Returns a vertical stacked bar plot that displays the proportion 
#'   of the Usage Segments over time when using custom parameters. This function
#'   creates a more detailed caption that explains the custom parameter definitions
#'   used for segment classification.
#' 
#' @param data A data frame with a column containing the Usage Segments, 
#'   denoted by `cus`. The data frame must also include a `MetricDate` column.
#' @param cus A string representing the name of the column containing the usage 
#'   segment classifications (e.g., "UsageSegments").
#' @param threshold Numeric value specifying the minimum threshold for a valid count.
#' @param width Integer specifying the number of qualifying counts to consider for a habit.
#' @param max_window Integer specifying the maximum window to consider for a habit.
#' 
#' @return A ggplot object representing the stacked bar plot of usage segments.

plot_ts_cus <- function(data, cus, threshold, width, max_window){
  
  # Create detailed caption explaining custom parameters
  date_text <- extract_date_range(data, return = "text")
  
  custom_caption <- paste0(
    "Usage Segments - Custom Definition:\n",
    "• Habitual User: Active usage in ", width, " out of ", max_window, " periods\n",
    "• Power User: Habitual User with 15+ average weekly actions\n", 
    "• Qualifying period: ", threshold, " or more actions per period\n",
    "\n", date_text
  )
  
  data %>%
    count(MetricDate, !!sym(cus)) %>%
    group_by(MetricDate) %>%
    mutate(prop = n / sum(n)) %>%
    ggplot(aes(x = MetricDate, y = prop, fill = !!sym(cus))) +
    geom_bar(stat = "identity") +
    scale_y_continuous(labels = scales::percent) +
    scale_fill_manual(values = c("#0c336e", "#1c66b0", "#80baea", "grey", "#808080")) +
    labs(
      title = "Usage Segments - Custom Parameters",
      subtitle = "Proportion of users in each segment based on custom definition",
      x = "Date",
      y = "Proportion of users",
      fill = "Usage Segment",
      caption = custom_caption
    ) +
    theme_wpa_basic()
  
}

