# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See LICENSE.txt in the project root for license information.
# --------------------------------------------------------------------------------------------

#' @title Generate Rogers Adoption Curve plots for Copilot usage
#'
#' @author Chris Gideon <chris.gideon@@microsoft.com>
#' 
#' @description
#' Creates various visualizations based on the Rogers adoption curve theory,
#' analyzing the adoption patterns of Copilot usage. The function identifies
#' habitual users using the `identify_habit()` function and then creates
#' adoption curve visualizations based on different time frames and
#' organizational groupings.
#'
#' @details
#' This function provides four distinct plot modes to analyze adoption patterns:
#'
#' \strong{Plot Mode 1 - Cumulative Adoption Curve:}
#' Shows the classic Rogers adoption curve with cumulative percentage of habitual
#' users over time. This S-shaped curve helps identify the pace of adoption and
#' when saturation begins. Steep sections indicate rapid adoption periods, while
#' flat sections suggest slower uptake or natural limits.
#'
#' \strong{Plot Mode 2 - Weekly Adoption Rate:}
#' Displays the number of new habitual users identified each week, with a
#' 3-week moving average line to smooth volatility. This view helps identify
#' adoption spikes, seasonal patterns, and the natural ebb and flow of user
#' onboarding. High bars indicate successful onboarding periods.
#'
#' \strong{Plot Mode 3 - Enablement-Based Adoption:}
#' Analyzes adoption relative to when users were first enabled (had access).
#' Users are classified into Rogers segments (Innovators, Early Adopters,
#' Early/Late Majority, Laggards) based on how quickly they adopted after
#' enablement. This helps understand the natural distribution of adoption
#' speed within your organization.
#'
#' \strong{Plot Mode 4 - Cumulative Enablement-Adjusted:}
#' Similar to Mode 1 but only includes users who had enablement data, providing
#' a more accurate view of adoption among those who actually had access to the
#' technology. This removes noise from users who may not have been properly
#' enabled.
#'
#' \strong{Interpretation Guidelines:}
#' \itemize{
#'   \item Early steep curves suggest strong product-market fit
#'   \item Plateaus may indicate training needs or feature limitations
#'   \item Seasonal patterns often reflect organizational training cycles
#'   \item Rogers segments help identify user personas for targeted interventions
#' }
#'
#' @param data Data frame containing Person Query data to be analyzed. Must
#' contain `PersonId`, `MetricDate`, and the specified metrics.
#' @param hrvar Character string specifying the HR attribute or organizational
#'   variable to group by. Default is `NULL`, for no grouping.
#' @param metric Character string containing the name of the metric to analyze
#' for habit identification, e.g. "Total_Copilot_actions". This is passed to
#' `identify_habit()`.
#' @param width Integer specifying the number of qualifying counts to consider
#' for a habit. Passed to `identify_habit()`. Default is 9.
#' @param max_window Integer specifying the maximum unit of dates to consider a
#' qualifying window for a habit. Passed to `identify_habit()`. Default is 12.
#' @param threshold Numeric value specifying the minimum threshold for the
#' metric to be considered a qualifying count. Passed to `identify_habit()`.
#' Default is 1.
#' @param start_metric Character string containing the name of the metric used
#'   for determining enablement start date. This metric should track when users
#'   first gained access to the technology being analyzed. The function identifies
#'   the earliest date where this metric is greater than 0 for each user as their
#'   "enablement date". This is then used in plot modes 3 and 4 to calculate
#'   time-to-adoption and Rogers segment classifications. The suggested variable
#'   is "Total_Copilot_enabled_days", but any metric that indicates access or
#'   licensing status can be used (e.g., "License_assigned_days", "Access_granted").
#' @param return Character vector specifying what to return. Valid inputs are
#' "plot", "data", and "table". Default is "plot".
#' @param plot_mode Integer or character string determining which plot to return.
#' Valid inputs are:
#' \itemize{
#'   \item 1 or "cumulative": Rogers Adoption Curve showing cumulative adoption
#'   \item 2 or "weekly": Weekly Rate of adoption showing new habitual users
#'   \item 3 or "enablement": Enablement-based adoption rate with Rogers segments
#'   \item 4 or "cumulative_enablement": Cumulative adoption adjusted for enablement
#' }
#' Default is 1.
#' @param label Logical value to determine whether to show data point labels on
#'   the plot for cumulative adoption curves (plot modes 1 and 4). If `TRUE`, 
#'   both `geom_point()` and `geom_text()` are added to display data labels 
#'   rounded to 1 decimal place above each data point. Defaults to `FALSE`.
#'
#' @import dplyr
#' @import ggplot2
#' @import scales
#' @importFrom rlang .data
#' @importFrom stats as.formula
#'
#' @family Visualization
#' @family Adoption Analysis
#'
#' @examples
#' # Basic Rogers adoption curve
#' create_rogers(
#'   data = pq_data,
#'   metric = "Copilot_actions_taken_in_Teams",
#'   plot_mode = 1
#' )
#'
#' # Weekly adoption rate by organization
#' create_rogers(
#'   data = pq_data,
#'   hrvar = "Organization",
#'   metric = "Copilot_actions_taken_in_Teams",
#'   plot_mode = 2
#' )
#'
#' # Enablement-based adoption
#' create_rogers(
#'   data = pq_data,
#'   metric = "Copilot_actions_taken_in_Teams",
#'   start_metric = "Total_Copilot_enabled_days",
#'   plot_mode = 3
#' )
#'
#' # Rogers adoption curve with data point labels
#' create_rogers(
#'   data = pq_data,
#'   metric = "Copilot_actions_taken_in_Teams",
#'   plot_mode = 1,
#'   label = TRUE
#' )
#'
#' @return
#' Returns a 'ggplot' object by default when 'plot' is passed in `return`.
#' When 'table' is passed, a summary table is returned as a data frame.
#' When 'data' is passed, the processed data with habit classifications is returned.
#'
#' @export

create_rogers <- function(data,
                         hrvar = NULL,
                         metric,
                         width = 9,
                         max_window = 12,
                         threshold = 1,
                         start_metric,
                         return = "plot",
                         plot_mode = 1,
                         label = FALSE) {
  
  ## Check inputs
  required_variables <- c("MetricDate", metric, "PersonId")
  
  ## Error message if variables are not present
  data %>%
    check_inputs(requirements = required_variables)
  
  ## Check if start_metric exists for enablement-based plots
  if (plot_mode %in% c(3, 4, "enablement", "cumulative_enablement")) {
    if (!start_metric %in% names(data)) {
      stop(paste("Column", start_metric, "not found in data for enablement-based analysis."))
    }
  }
  
  ## Apply habit identification
  data_with_habit <- data %>%
    identify_habit(
      metric = metric,
      threshold = threshold,
      width = width,
      max_window = max_window,
      return = "data"
    )
  
  ## Find the earliest "habitual" date per PersonId
  adoption_week_df <- data_with_habit %>%
    filter(.data$IsHabit == TRUE) %>%
    group_by(.data$PersonId) %>%
    summarise(adoption_week = min(.data$MetricDate, na.rm = TRUE), .groups = "drop")
  
  ## Handle hrvar
  if (!is.null(hrvar) && hrvar %in% names(data)) {
    # Add hrvar to adoption data
    hrvar_lookup <- data %>%
      select(.data$PersonId, !!sym(hrvar)) %>%
      distinct()
    
    adoption_week_df <- adoption_week_df %>%
      left_join(hrvar_lookup, by = "PersonId")
  }
  
  ## Return data if requested
  if (return == "data") {
    return(data_with_habit)
  }
  
  ## Convert plot_mode to numeric for easier handling
  if (is.character(plot_mode)) {
    plot_mode <- case_when(
      plot_mode == "cumulative" ~ 1,
      plot_mode == "weekly" ~ 2,
      plot_mode == "enablement" ~ 3,
      plot_mode == "cumulative_enablement" ~ 4,
      TRUE ~ 1
    )
  }
  
  ## Generate plots based on plot_mode
  if (plot_mode == 1) {
    # Rogers Adoption Curve (Cumulative)
    if (!is.null(hrvar) && hrvar %in% names(data)) {
      # By hrvar
      rogers_curve <- adoption_week_df %>%
        count(!!sym(hrvar), .data$adoption_week) %>%
        group_by(!!sym(hrvar)) %>%
        arrange(.data$adoption_week) %>%
        mutate(
          cumulative_adopters = cumsum(.data$n),
          cumulative_percent = .data$cumulative_adopters / sum(.data$n)
        ) %>%
        ungroup()
      
      plot_object <- ggplot(rogers_curve, aes(x = .data$adoption_week, y = .data$cumulative_percent, color = !!sym(hrvar))) +
        geom_line(size = 1) +
        facet_wrap(as.formula(paste("~", hrvar)), scales = "free_y") +
        scale_y_continuous(labels = scales::percent_format()) +
        labs(
          title = "Rogers cumulative adoption curve",
          subtitle = paste("Based on", us_to_space(metric)),
          x = "Week of Habitual Adoption",
          y = "Cumulative % of Habitual Users",
          color = hrvar,
          caption = extract_date_range(data, return = "text")
        ) +
        theme_wpa_basic()
      
      # Conditionally add points and labels if label = TRUE
      if(label == TRUE){
        plot_object <- plot_object +
          geom_point(size = 2) +
          geom_text(aes(label = scales::percent(round(.data$cumulative_percent, 3))), 
                    vjust = -0.5, hjust = 0.5, size = 3, colour = "black")
      }
    } else {
      # Overall
      rogers_curve <- adoption_week_df %>%
        count(.data$adoption_week) %>%
        arrange(.data$adoption_week) %>%
        mutate(
          cumulative_adopters = cumsum(.data$n),
          cumulative_percent = .data$cumulative_adopters / sum(.data$n)
        )
      
      plot_object <- ggplot(rogers_curve, aes(x = .data$adoption_week, y = .data$cumulative_percent)) +
        geom_line(size = 1.2, color = "#1c66b0") +
        scale_y_continuous(labels = scales::percent_format()) +
        labs(
          title = "Rogers cumulative adoption curve",
          subtitle = paste("Based on", us_to_space(metric)),
          x = "Week of Adoption",
          y = "Cumulative % of Habitual Users",
          caption = extract_date_range(data, return = "text")
        ) +
        theme_wpa_basic()
      
      # Conditionally add points and labels if label = TRUE
      if(label == TRUE){
        plot_object <- plot_object +
          geom_point(color = "#1c66b0", size = 2) +
          geom_text(aes(label = scales::percent(round(.data$cumulative_percent, 3))), 
                    vjust = -0.5, hjust = 0.5, size = 3, colour = "black")
      } else {
        plot_object <- plot_object +
          geom_point()
      }
    }
    
  } else if (plot_mode == 2) {
    # Weekly Rate of Adoption
    if (!is.null(hrvar) && hrvar %in% names(data)) {
      # By hrvar
      adoption_rate <- adoption_week_df %>%
        count(!!sym(hrvar), .data$adoption_week) %>%
        group_by(!!sym(hrvar)) %>%
        arrange(.data$adoption_week) %>%
        mutate(
          moving_avg = slider::slide_dbl(.data$n, mean, .before = 2, .complete = TRUE)
        ) %>%
        rename(new_adopters = .data$n) %>%
        ungroup()
      
      plot_object <- ggplot(adoption_rate, aes(x = .data$adoption_week, y = .data$new_adopters)) +
        geom_col(fill = "#1c66b0") +
        geom_text(aes(label = .data$new_adopters), vjust = -0.5, hjust = 0.5, size = 3, colour = "black") +
        geom_line(aes(y = .data$moving_avg), color = "#0c336e", size = 1) +
        facet_wrap(as.formula(paste("~", hrvar)), scales = "free_y") +
        labs(
          title = paste("Weekly Rate of", us_to_space(metric), "Adoption by", hrvar),
          subtitle = "New habitual users each week; line indicating moving average",
          x = "Week",
          y = "New Habitual Users",
          caption = extract_date_range(data, return = "text")
        ) +
        theme_wpa_basic()
    } else {
      # Overall
      adoption_rate <- adoption_week_df %>%
        count(.data$adoption_week) %>%
        arrange(.data$adoption_week) %>%
        rename(new_adopters = .data$n) %>%
        mutate(
          moving_avg = slider::slide_dbl(.data$new_adopters, mean, .before = 2, .complete = TRUE)
        )
      
      plot_object <- ggplot(adoption_rate, aes(x = .data$adoption_week, y = .data$new_adopters)) +
        geom_col(fill = "#1c66b0") +
        geom_text(aes(label = .data$new_adopters), vjust = -0.5, hjust = 0.5, size = 3, colour = "black") +
        geom_line(aes(y = .data$moving_avg), color = "#0c336e", size = 1.2) +
        labs(
          title = paste("Weekly Rate of", us_to_space(metric), "Adoption"),
          subtitle = "New habitual users identified each week; line indicating moving average",
          x = "Week",
          y = "New Habitual Users",
          caption = extract_date_range(data, return = "text")
        ) +
        theme_wpa_basic()
    }
    
  } else if (plot_mode == 3) {
    # Enablement-based Adoption Rate
    enable_week_df <- data_with_habit %>%
      filter(!!sym(start_metric) > 0) %>%
      group_by(.data$PersonId) %>%
      summarise(enable_week = min(.data$MetricDate, na.rm = TRUE), .groups = "drop")
    
    adoption_week_df2 <- adoption_week_df %>%
      left_join(enable_week_df, by = "PersonId") %>%
      filter(!is.na(.data$enable_week)) %>%
      mutate(
        weeks_to_adopt = as.numeric(difftime(.data$adoption_week, .data$enable_week, units = "weeks")),
        adoption_delay_percent = percent_rank(.data$weeks_to_adopt),
        RogersSegment_delay = case_when(
          .data$adoption_delay_percent <= 0.025 ~ "Innovators",
          .data$adoption_delay_percent <= 0.16  ~ "Early Adopters",
          .data$adoption_delay_percent <= 0.50  ~ "Early Majority",
          .data$adoption_delay_percent <= 0.84  ~ "Late Majority",
          TRUE                                  ~ "Laggards"
        )
      )
    
    weekly_segment_counts <- adoption_week_df2 %>%
      count(.data$adoption_week, .data$RogersSegment_delay) %>%
      rename(new_adopters = .data$n)
    
    # Calculate segment proportions for caption
    segment_proportions <- adoption_week_df2 %>%
      count(.data$RogersSegment_delay) %>%
      mutate(
        total = sum(.data$n),
        percentage = round((.data$n / .data$total) * 100, 0)
      ) %>%
      arrange(factor(.data$RogersSegment_delay, 
                    levels = c("Innovators", "Early Adopters", "Early Majority", "Late Majority", "Laggards")))
    
    # Create caption with proportions
    proportions_text <- paste(
      paste(segment_proportions$RogersSegment_delay, ": ", segment_proportions$percentage, "%", sep = ""),
      collapse = "; "
    )
    
    full_caption <- paste(extract_date_range(data, return = "text"), "\n", proportions_text, sep = "")
    
    plot_object <- ggplot(weekly_segment_counts, aes(x = .data$adoption_week, y = .data$new_adopters, fill = .data$RogersSegment_delay)) +
      geom_col(position = "stack") +
      scale_fill_manual(
        values = c(
          "Innovators"     = "#6a51a3",
          "Early Adopters" = "#3182bd",
          "Early Majority" = "#31a354",
          "Late Majority"  = "#fd8d3c",
          "Laggards"       = "#de2d26"
        )
      ) +
      labs(
        title = paste("Enablement-Based", us_to_space(metric), "Adoption Rate"),
        subtitle = "Weekly new habitual users, segmented by Rogers category (delay from enablement)",
        x = "Week of Adoption",
        y = "Number of New Habitual Users",
        fill = "Rogers Segment",
        caption = full_caption
      ) +
      theme_wpa_basic()
    
  } else if (plot_mode == 4) {
    # Cumulative Enablement-based Adoption
    enable_week_df <- data_with_habit %>%
      filter(!!sym(start_metric) > 0) %>%
      group_by(.data$PersonId) %>%
      summarise(enable_week = min(.data$MetricDate, na.rm = TRUE), .groups = "drop")
    
    adoption_week_df2 <- adoption_week_df %>%
      left_join(enable_week_df, by = "PersonId") %>%
      filter(!is.na(.data$enable_week))
    
    cumulative_df <- adoption_week_df2 %>%
      count(.data$adoption_week) %>%
      arrange(.data$adoption_week) %>%
      mutate(
        cumulative = cumsum(.data$n),
        cumulative_percent = .data$cumulative / sum(.data$n)
      )
    
    plot_object <- ggplot(cumulative_df, aes(x = .data$adoption_week, y = .data$cumulative_percent)) +
      geom_line(size = 1.2, color = "#1c66b0") +
      scale_y_continuous(labels = scales::percent) +
      labs(
        title = "Enablement-adjusted cumulative adoption curve",
        subtitle = paste("Based on", us_to_space(metric)),
        x = "Adoption Week",
        y = "Cumulative % of Users",
        caption = extract_date_range(data, return = "text")
      ) +
      theme_wpa_basic()
    
    # Conditionally add points and labels if label = TRUE
    if(label == TRUE){
      plot_object <- plot_object +
        geom_point(color = "#1c66b0", size = 2) +
        geom_text(aes(label = scales::percent(round(.data$cumulative_percent, 3))), 
                  vjust = -0.5, hjust = 0.5, size = 3, colour = "black")
    } else {
      plot_object <- plot_object +
        geom_point()
    }
    
  } else {
    stop("Invalid plot_mode. Use 1-4 or 'cumulative', 'weekly', 'enablement', 'cumulative_enablement'.")
  }
  
  ## Return based on return parameter
  if (return == "plot") {
    return(plot_object)
  } else if (return == "table") {
    # Return summary table
    summary_table <- adoption_week_df %>%
      summarise(
        total_adopters = n(),
        earliest_adoption = min(.data$adoption_week, na.rm = TRUE),
        latest_adoption = max(.data$adoption_week, na.rm = TRUE),
        median_adoption_week = median(.data$adoption_week, na.rm = TRUE)
      )
    return(summary_table)
  } else {
    stop("Please enter a valid input for `return`: 'plot', 'data', or 'table'.")
  }
}
