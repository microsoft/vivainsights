test_that("identify_usage_segments returns table correctly", {
  # Skip if packages not available
  skip_if_not_installed("dplyr")
  skip_if_not_installed("tidyr")
  skip_if_not_installed("slider")
  
  # Load required packages
  library(dplyr)
  library(tidyr)
  library(slider)
  
  # Create mock data
  mock_data <- data.frame(
    PersonId = rep(c("A", "B", "C"), each = 4),
    MetricDate = rep(as.Date(c("2024-01-01", "2024-01-08", "2024-01-15", "2024-01-22")), 3),
    Total_actions = c(0, 5, 10, 20, 1, 8, 15, 25, 0, 0, 2, 5),
    stringsAsFactors = FALSE
  )
  
  # Test table return for 12w version
  suppressMessages({
    result_12w <- identify_usage_segments(
      data = mock_data,
      metric = "Total_actions",
      version = "12w",
      return = "table"
    )
  })
  
  # Test table return for 4w version  
  suppressMessages({
    result_4w <- identify_usage_segments(
      data = mock_data,
      metric = "Total_actions",
      version = "4w",
      return = "table"
    )
  })
  
  # Basic checks
  expect_true(is.data.frame(result_12w))
  expect_true(is.data.frame(result_4w))
  expect_true("MetricDate" %in% names(result_12w))
  expect_true("MetricDate" %in% names(result_4w))
  expect_true("n" %in% names(result_12w))
  expect_true("n" %in% names(result_4w))
  
  # Check that usage segments columns exist
  expected_segments <- c("Power User", "Habitual User", "Novice User", "Low User", "Non-user")
  expect_true(any(expected_segments %in% names(result_12w)))
  expect_true(any(expected_segments %in% names(result_4w)))
})

test_that("identify_usage_segments prints message for table return", {
  # Skip if packages not available
  skip_if_not_installed("dplyr")
  skip_if_not_installed("tidyr")
  skip_if_not_installed("slider")
  
  # Load required packages
  library(dplyr)
  library(tidyr)
  library(slider)
  
  # Create mock data
  mock_data <- data.frame(
    PersonId = rep(c("A", "B"), each = 2),
    MetricDate = rep(as.Date(c("2024-01-01", "2024-01-08")), 2),
    Total_actions = c(5, 10, 15, 20),
    stringsAsFactors = FALSE
  )
  
  # Test that message is printed for 12w
  expect_message(
    identify_usage_segments(
      data = mock_data,
      metric = "Total_actions",
      version = "12w",
      return = "table"
    ),
    "Usage segments summary table \\(12-week version\\)"
  )
  
  # Test that message is printed for 4w
  expect_message(
    identify_usage_segments(
      data = mock_data,
      metric = "Total_actions",
      version = "4w",
      return = "table"
    ),
    "Usage segments summary table \\(4-week version\\)"
  )
})

test_that("identify_usage_segments validates return parameter", {
  # Skip if packages not available
  skip_if_not_installed("dplyr")
  skip_if_not_installed("tidyr")
  skip_if_not_installed("slider")
  
  # Load required packages
  library(dplyr)
  library(tidyr)
  library(slider)
  
  # Create mock data
  mock_data <- data.frame(
    PersonId = c("A", "B"),
    MetricDate = as.Date(c("2024-01-01", "2024-01-08")),
    Total_actions = c(5, 10),
    stringsAsFactors = FALSE
  )
  
  # Test invalid return parameter
  expect_error(
    identify_usage_segments(
      data = mock_data,
      metric = "Total_actions",
      version = "12w",
      return = "invalid"
    ),
    "Please enter a valid input for `return`\\. Valid options are 'data', 'plot', or 'table'\\."
  )
})

test_that("identify_usage_segments returns table correctly with custom parameters", {
  # Skip if packages not available
  skip_if_not_installed("dplyr")
  skip_if_not_installed("tidyr")
  skip_if_not_installed("slider")
  
  # Load required packages
  library(dplyr)
  library(tidyr)
  library(slider)
  
  # Create mock data with more weeks to test custom parameters
  mock_data <- data.frame(
    PersonId = rep(c("A", "B", "C"), each = 8),
    MetricDate = rep(as.Date(c("2024-01-01", "2024-01-08", "2024-01-15", "2024-01-22", 
                               "2024-01-29", "2024-02-05", "2024-02-12", "2024-02-19")), 3),
    Total_actions = c(0, 5, 10, 20, 15, 12, 8, 18,    # Person A
                      1, 8, 15, 25, 20, 18, 22, 30,   # Person B  
                      0, 0, 2, 5, 3, 1, 0, 4),        # Person C
    stringsAsFactors = FALSE
  )
  
  # Test table return with custom parameters
  suppressMessages({
    result_custom <- identify_usage_segments(
      data = mock_data,
      metric = "Total_actions",
      version = NULL,
      threshold = 3,
      width = 5,
      max_window = 8,
      return = "table"
    )
  })
  
  # Basic checks
  expect_true(is.data.frame(result_custom))
  expect_true("MetricDate" %in% names(result_custom))
  expect_true("n" %in% names(result_custom))
  
  # Check that usage segments columns exist
  expected_segments <- c("Power User", "Habitual User", "Novice User", "Low User", "Non-user")
  expect_true(any(expected_segments %in% names(result_custom)))
  
  # Check that proportions sum to 1 for each date (allowing for rounding errors)
  segment_cols <- names(result_custom)[names(result_custom) %in% expected_segments]
  if(length(segment_cols) > 0) {
    row_sums <- rowSums(result_custom[segment_cols], na.rm = TRUE)
    expect_true(all(abs(row_sums - 1) < 0.001))
  }
})

test_that("identify_usage_segments prints custom parameters message for table return", {
  # Skip if packages not available
  skip_if_not_installed("dplyr")
  skip_if_not_installed("tidyr")
  skip_if_not_installed("slider")
  
  # Load required packages
  library(dplyr)
  library(tidyr)
  library(slider)
  
  # Create mock data
  mock_data <- data.frame(
    PersonId = rep(c("A", "B"), each = 4),
    MetricDate = rep(as.Date(c("2024-01-01", "2024-01-08", "2024-01-15", "2024-01-22")), 2),
    Total_actions = c(5, 10, 15, 20, 8, 12, 18, 25),
    stringsAsFactors = FALSE
  )
  
  # Test that custom parameters message is printed
  expect_message(
    identify_usage_segments(
      data = mock_data,
      metric = "Total_actions",
      version = NULL,
      threshold = 2,
      width = 3,
      max_window = 4,
      return = "table"
    ),
    "Usage segments summary table \\(custom parameters - threshold: 2, width: 3, max window: 4\\)"
  )
})