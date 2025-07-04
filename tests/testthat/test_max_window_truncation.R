# Test for verifying the fix truncates max_window from plot output
# This test demonstrates the fix for issue #62

test_that("identify_habit truncates first max_window weeks from plot output", {
  # Skip if packages not available
  skip_if_not_installed("dplyr")
  skip_if_not_installed("ggplot2")
  skip_if_not_installed("glue")
  
  # Load required packages
  library(dplyr)
  library(ggplot2)
  library(glue)
  
  # Create mock data with 8 weeks
  mock_data <- data.frame(
    PersonId = rep(c("A", "B", "C"), each = 8),
    MetricDate = rep(as.Date(c("2024-01-01", "2024-01-08", "2024-01-15", "2024-01-22", 
                               "2024-01-29", "2024-02-05", "2024-02-12", "2024-02-19")), 3),
    Total_actions = c(0, 5, 10, 20, 15, 12, 8, 18,    # Person A
                      1, 8, 15, 25, 20, 18, 22, 30,   # Person B  
                      0, 0, 2, 5, 3, 1, 0, 4),        # Person C
    stringsAsFactors = FALSE
  )
  
  # Test with max_window=3 - should show only last 5 weeks
  suppressMessages({
    plot_obj <- identify_habit(
      data = mock_data,
      metric = "Total_actions",
      threshold = 1,
      width = 2,
      max_window = 3,
      return = "plot",
      plot_mode = "time"
    )
  })
  
  # Extract the dates used in the plot data
  plot_data <- ggplot_build(plot_obj)$data[[1]]
  
  # Should show 5 unique time points (8 total - 3 filtered = 5)
  expect_equal(length(unique(plot_data$x)), 5)
  
  # Convert back to dates and check they are the expected last 5 weeks
  dates_in_plot <- as.Date(unique(plot_data$x), origin = "1970-01-01")
  expected_dates <- as.Date(c("2024-01-22", "2024-01-29", "2024-02-05", "2024-02-12", "2024-02-19"))
  expect_equal(sort(dates_in_plot), sort(expected_dates))
})

test_that("identify_usage_segments truncates first max_window weeks from plot output", {
  # Skip if packages not available
  skip_if_not_installed("dplyr")
  skip_if_not_installed("ggplot2")
  skip_if_not_installed("tidyr")
  
  # Load required packages
  library(dplyr)
  library(ggplot2)
  library(tidyr)
  
  # Create mock data with 10 weeks
  mock_data <- data.frame(
    PersonId = rep(c("A", "B", "C"), each = 10),
    MetricDate = rep(as.Date(c("2024-01-01", "2024-01-08", "2024-01-15", "2024-01-22", 
                               "2024-01-29", "2024-02-05", "2024-02-12", "2024-02-19",
                               "2024-02-26", "2024-03-05")), 3),
    Total_actions = c(0, 5, 10, 20, 15, 12, 8, 18, 22, 25,    # Person A
                      1, 8, 15, 25, 20, 18, 22, 30, 28, 32,   # Person B  
                      0, 0, 2, 5, 3, 1, 0, 4, 6, 8),          # Person C
    stringsAsFactors = FALSE
  )
  
  # Test custom parameters with max_window=4 - should show only last 6 weeks
  suppressMessages({
    plot_obj <- identify_usage_segments(
      data = mock_data,
      metric = "Total_actions",
      version = NULL,
      threshold = 1,
      width = 3,
      max_window = 4,
      return = "plot"
    )
  })
  
  # Extract the dates used in the plot data
  plot_data <- ggplot_build(plot_obj)$data[[1]]
  
  # Should show 6 unique time points (10 total - 4 filtered = 6)
  expect_equal(length(unique(plot_data$x)), 6)
  
  # Convert back to dates and check they are the expected last 6 weeks
  dates_in_plot <- as.Date(unique(plot_data$x), origin = "1970-01-01")
  expected_dates <- as.Date(c("2024-01-29", "2024-02-05", "2024-02-12", "2024-02-19", "2024-02-26", "2024-03-05"))
  expect_equal(sort(dates_in_plot), sort(expected_dates))
})

test_that("identify_usage_segments truncates correctly for predefined versions", {
  # Skip if packages not available
  skip_if_not_installed("dplyr")
  skip_if_not_installed("ggplot2")
  skip_if_not_installed("tidyr")
  
  # Load required packages
  library(dplyr)
  library(ggplot2) 
  library(tidyr)
  
  # Create mock data with 8 weeks
  mock_data <- data.frame(
    PersonId = rep(c("A", "B", "C"), each = 8),
    MetricDate = rep(as.Date(c("2024-01-01", "2024-01-08", "2024-01-15", "2024-01-22", 
                               "2024-01-29", "2024-02-05", "2024-02-12", "2024-02-19")), 3),
    Total_actions = c(0, 5, 10, 20, 15, 12, 8, 18,    # Person A
                      1, 8, 15, 25, 20, 18, 22, 30,   # Person B  
                      0, 0, 2, 5, 3, 1, 0, 4),        # Person C
    stringsAsFactors = FALSE
  )
  
  # Test 4w version - max_window=4, should show only last 4 weeks
  suppressMessages({
    plot_obj_4w <- identify_usage_segments(
      data = mock_data,
      metric = "Total_actions",
      version = "4w",
      return = "plot"
    )
  })
  
  # Extract the dates used in the plot data
  plot_data_4w <- ggplot_build(plot_obj_4w)$data[[1]]
  
  # Should show 4 unique time points (8 total - 4 filtered = 4) 
  expect_equal(length(unique(plot_data_4w$x)), 4)
  
  # Convert back to dates and check they are the expected last 4 weeks
  dates_in_plot_4w <- as.Date(unique(plot_data_4w$x), origin = "1970-01-01")
  expected_dates_4w <- as.Date(c("2024-01-29", "2024-02-05", "2024-02-12", "2024-02-19"))
  expect_equal(sort(dates_in_plot_4w), sort(expected_dates_4w))
})

test_that("data output is not affected by plot filtering", {
  # Skip if packages not available
  skip_if_not_installed("dplyr")
  skip_if_not_installed("tidyr")
  
  # Load required packages
  library(dplyr)
  library(tidyr)
  
  # Create mock data
  mock_data <- data.frame(
    PersonId = rep(c("A", "B"), each = 6),
    MetricDate = rep(as.Date(c("2024-01-01", "2024-01-08", "2024-01-15", 
                               "2024-01-22", "2024-01-29", "2024-02-05")), 2),
    Total_actions = c(5, 10, 15, 20, 25, 30, 8, 12, 18, 22, 28, 32),
    stringsAsFactors = FALSE
  )
  
  # Data output should still contain all dates
  suppressMessages({
    data_result <- identify_habit(
      data = mock_data,
      metric = "Total_actions",
      threshold = 1,
      width = 2,
      max_window = 3,
      return = "data"
    )
  })
  
  # Should have all 6 unique dates in data output
  expect_equal(length(unique(data_result$MetricDate)), 6)
  
  # Test usage segments data output too
  suppressMessages({
    data_result_us <- identify_usage_segments(
      data = mock_data,
      metric = "Total_actions",
      version = NULL,
      threshold = 1,
      width = 2,
      max_window = 3,
      return = "data"
    )
  })
  
  # Should have all 6 unique dates in data output
  expect_equal(length(unique(data_result_us$MetricDate)), 6)
})