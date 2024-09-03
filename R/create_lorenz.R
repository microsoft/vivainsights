# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See LICENSE.txt in the project root for license information.
# --------------------------------------------------------------------------------------------

#' @title Calculate the Lorenz Curve and Gini Coefficient in a Person Query
#'
#' @description
#' This function computes the Gini coefficient and plots the Lorenz curve based on a selected metric
#' from a Person Query data frame. It provides a way to measure inequality in the distribution of 
#' the selected metric.
#'
#' @param data Data frame containing a Person Query.
#' @param metric Character string identifying the metric to be used for the
#'   Lorenz curve and Gini coefficient calculation.
#' @param return Character string identifying the return type. Options are:
#'   - `"gini"` (default) - Numeric value representing the Gini coefficient.
#'   - `"table"` - Data frame containing a summary table of population share and value share.
#'   - `"plot"` - `ggplot` object representing a plot of the Lorenz curve.
#'
#' @examples
#' create_lorenz(data = pq_data, metric = "Emails_sent", return = "gini")
#' --------------------------------------------------------------------------------------------
#' Note: 
#' - This function can be integrated into a larger analysis pipeline to assess inequality in metric distribution.
#' - Ensure to have the required packages (`dplyr`, `ggplot2`, etc.) installed and loaded before running this function.
#' --------------------------------------------------------------------------------------------
#'
#' @export
create_lorenz <- function(data, metric, return) {
  # Ensure the input data frame and metric are valid
  if (!is.data.frame(data)) {
    stop("Input must be a data frame")
  }
  if (!is.character(metric) || length(metric) != 1) {
    stop("Metric must be a single character string")
  }
  
  # Helper function to calculate the proportion of value for a given population share
  get_value_proportion <- function(df, population_share) {
    # Ensure the population_share is between 0 and 1
    if (population_share < 0 || population_share > 1) {
      stop("Population share must be between 0 and 1")
    }
    
    # Find the closest cumulative population share
    closest_row <- df %>%
      filter(cum_population >= population_share) %>%
      slice(1)
    
    return(closest_row$cum_values_prop)
  }
  
  # Helper function to compute the Gini coefficient
  compute_gini <- function(x) {
    # Ensure the input is a numeric vector
    if (!is.numeric(x)) {
      stop("Input must be a numeric vector")
    }
    
    # Sort the vector
    x <- sort(x)
    
    # Number of observations
    n <- length(x)
    
    # Compute the Gini coefficient
    gini <- (2 * sum((1:n) * x) - (n + 1) * sum(x)) / (n * sum(x))
    
    return(gini)
  }
  
  # Compute the Gini coefficient if "gini" is specified
  if (return == "gini") {
    gini_coef <- compute_gini(data[[metric]])
    return(gini_coef)
  }
  
  # Generate the Lorenz data frame if "table" or "plot" is specified
  lorenz_df <- 
    data %>%
    select(n = !!sym(metric)) %>% 
    arrange(n) %>%
    mutate(
      cum_values = cumsum(n),
      cum_population = cumsum(rep(1, n())) / n(),
      cum_values_prop = cum_values / sum(n)
    )
  
  if (return == "table") {
    # Return a summary table of population share and value share
    return(
      seq(0, 1, by = 0.1) %>%
      map_dfr(function(x) {
        tibble(
          population_share = x,
          value_share = get_value_proportion(lorenz_df, population_share = x)
        )
      })
    )
  } else if (return == "plot") {
    # Plot the Lorenz curve
    gini_coef <- compute_gini(data[[metric]])
    
    return(
      lorenz_df %>%
      ggplot(aes(x = cum_population, y = cum_values_prop)) +
      geom_line(color = "#C75B7A") +
      geom_abline(intercept = 0, slope = 1, linetype = "dashed", color = "darkgrey") +
      labs(
        title = "% of Population Sharing % of Emails Sent",
        subtitle = "Lorenz Curve for Emails Sent",
        caption = paste0("Gini Coefficient: ", round(gini_coef, 2)),
        x = "Cumulative Share of Population",
        y = "Cumulative Share of Values"
      ) +
      theme_wpa_basic() +
      scale_x_continuous(limits = c(0, 1)) +
      scale_y_continuous(limits = c(0, 1))
    )
  } else {
    stop("Invalid return type specified. Choose 'gini', 'table', or 'plot'.")
  }
}
