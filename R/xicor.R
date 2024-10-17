# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See LICENSE.txt in the project root for license information.
# --------------------------------------------------------------------------------------------

#' @title Calculate Chatterjee's Rank Correlation Coefficient
#'
#' @description
#' This function calculates Chatterjee's rank correlation coefficient, which measures the 
#' association between two variables. It is particularly useful for identifying monotonic 
#' relationships between variables, even if they are not linear. 
#' 
#' Unlike Pearson's correlation (which measures linear relationships), Chatterjee's 
#' coefficient can handle non-linear monotonic relationships. It is robust to outliers 
#' and can handle tied ranks, making it versatile for datasets with ordinal data or tied ranks.
#' This makes it a valuable alternative to Spearman's and Kendall's correlations, especially 
#' when the data may not meet the assumptions required by these methods.
#'
#' @param x A numeric vector representing the independent variable.
#' @param y A numeric vector representing the dependent variable.
#' @param ties A logical value indicating whether to handle ties in the data. Default is TRUE.
#'
#' @return A numeric value representing Chatterjee's rank correlation coefficient.
#'
#' @examples
#' xicor(x = pq_data$Collaboration_hours, y = pq_data$Internal_network_size)
#'
#' 
#' @export

xicor <- function(x, y, ties = TRUE){
  n <- length(x)
  
  # Sort Y based on the order of X
  ordered_y <- y[order(x)]
  
  # Get the ranks of Y after sorting by X
  r <- rank(ordered_y, ties.method = ifelse(ties, "max", "first"))
  
  if(ties){
    # Handling ties: Use maximum rank for tied values
    l <- rank(ordered_y, ties.method = "max")
    
    # Calculate Chatterjee's coefficient with ties
    return( 1 - n * sum(abs(r[-1] - r[-n])) / (2 * sum(l * (n - l))) )
  } else {
    # No ties: Simplified formula for the Chatterjee coefficient
    return( 1 - 3 * sum(abs(r[-1] - r[-n])) / (n^2 - 1) )
  }
}