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
    "Please enter a valid input for `return`. Valid options are 'data', 'plot', or 'table'."
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
    "Usage segments summary table \\(custom parameters - threshold: 2, width: 3, max window: 4, power threshold: 15\\)"
  )
  
  # Test that custom parameters message includes custom power_thres
  expect_message(
    identify_usage_segments(
      data = mock_data,
      metric = "Total_actions",
      version = NULL,
      threshold = 2,
      width = 3,
      max_window = 4,
      power_thres = 20,
      return = "table"
    ),
    "Usage segments summary table \\(custom parameters - threshold: 2, width: 3, max window: 4, power threshold: 20\\)"
  )
})

test_that("identify_usage_segments works with custom power_thres parameter", {
  # Skip if packages not available
  skip_if_not_installed("dplyr")
  skip_if_not_installed("tidyr")
  skip_if_not_installed("slider")
  
  # Load required packages
  library(dplyr)
  library(tidyr)
  library(slider)
  
  # Create mock data with high values to test power user classification
  mock_data <- data.frame(
    PersonId = rep(c("A", "B", "C"), each = 4),
    MetricDate = rep(as.Date(c("2024-01-01", "2024-01-08", "2024-01-15", "2024-01-22")), 3),
    Total_actions = c(20, 25, 30, 35,   # Person A: high usage
                      10, 12, 8, 6,     # Person B: medium usage  
                      1, 2, 1, 3),      # Person C: low usage
    stringsAsFactors = FALSE
  )
  
  # Test with default power_thres (15)
  suppressMessages({
    result_default <- identify_usage_segments(
      data = mock_data,
      metric = "Total_actions",
      version = "12w",
      return = "data"
    )
  })
  
  # Test with higher power_thres (25)
  suppressMessages({
    result_high <- identify_usage_segments(
      data = mock_data,
      metric = "Total_actions",
      version = "12w",
      power_thres = 25,
      return = "data"
    )
  })
  
  # Test with lower power_thres (10)
  suppressMessages({
    result_low <- identify_usage_segments(
      data = mock_data,
      metric = "Total_actions",
      version = "12w",
      power_thres = 10,
      return = "data"
    )
  })
  
  # Basic checks - all results should be data frames
  expect_true(is.data.frame(result_default))
  expect_true(is.data.frame(result_high))
  expect_true(is.data.frame(result_low))
  
  # Check that the results have the expected columns
  expect_true("UsageSegments_12w" %in% names(result_default))
  expect_true("UsageSegments_12w" %in% names(result_high))
  expect_true("UsageSegments_12w" %in% names(result_low))
  
  # All should have the same number of rows (same input data)
  expect_equal(nrow(result_default), nrow(result_high))
  expect_equal(nrow(result_high), nrow(result_low))
})

test_that("identify_usage_segments works with power_thres in custom parameters", {
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
    PersonId = rep(c("A", "B"), each = 6),
    MetricDate = rep(as.Date(c("2024-01-01", "2024-01-08", "2024-01-15", 
                               "2024-01-22", "2024-01-29", "2024-02-05")), 2),
    Total_actions = c(20, 25, 18, 22, 30, 28,  # Person A: consistently high
                      5, 8, 12, 6, 10, 9),     # Person B: consistently low
    stringsAsFactors = FALSE
  )
  
  # Test custom parameters with custom power_thres
  suppressMessages({
    result_custom <- identify_usage_segments(
      data = mock_data,
      metric = "Total_actions",
      version = NULL,
      threshold = 3,
      width = 4,
      max_window = 6,
      power_thres = 20,
      return = "data"
    )
  })
  
  # Basic checks
  expect_true(is.data.frame(result_custom))
  expect_true("UsageSegments" %in% names(result_custom))
  expect_true("PersonId" %in% names(result_custom))
  expect_true("MetricDate" %in% names(result_custom))
})

test_that("identify_usage_segments table returns correct n count and column order", {
  # Skip if packages not available
  skip_if_not_installed("dplyr")
  skip_if_not_installed("tidyr")
  skip_if_not_installed("slider")
  
  # Load required packages
  library(dplyr)
  library(tidyr)
  library(slider)
  
  # Create mock data with multiple rows per person per date
  # to test that n_distinct(PersonId) is used instead of count()
  mock_data <- data.frame(
    PersonId = c("A", "A", "B", "B", "C"),
    MetricDate = as.Date(rep("2024-01-01", 5)),
    Total_actions = c(10, 10, 15, 15, 5),
    stringsAsFactors = FALSE
  )
  
  # Test table return
  suppressMessages({
    result <- identify_usage_segments(
      data = mock_data,
      metric = "Total_actions",
      version = "12w",
      return = "table"
    )
  })
  
  # Check that n equals the number of distinct PersonIds (3), not the number of rows (5)
  expect_equal(result$n[1], 3)
  
  # Check column order: MetricDate should be first, n should be last
  expect_equal(names(result)[1], "MetricDate")
  expect_equal(names(result)[length(names(result))], "n")
  
  # Check that segment columns are in the middle and in logical order
  segment_cols <- names(result)[2:(length(names(result)) - 1)]
  expected_order <- c("Non-user", "Low User", "Novice User", "Habitual User", "Power User")
  # Segments should appear in the expected order (intersect preserves order from first argument)
  expect_equal(segment_cols, intersect(expected_order, segment_cols))
})

test_that("identify_usage_segments table handles missing segments gracefully", {
  # Skip if packages not available
  skip_if_not_installed("dplyr")
  skip_if_not_installed("tidyr")
  skip_if_not_installed("slider")
  
  # Load required packages
  library(dplyr)
  library(tidyr)
  library(slider)
  
  # Create mock data where all users are non-users (no actions)
  mock_data <- data.frame(
    PersonId = c("A", "B", "C"),
    MetricDate = as.Date(rep("2024-01-01", 3)),
    Total_actions = c(0, 0, 0),
    stringsAsFactors = FALSE
  )
  
  # Test table return - should not error even when only one segment is present
  suppressMessages({
    result <- identify_usage_segments(
      data = mock_data,
      metric = "Total_actions",
      version = "12w",
      return = "table"
    )
  })
  
  # Basic checks
  expect_true(is.data.frame(result))
  expect_true("MetricDate" %in% names(result))
  expect_true("n" %in% names(result))
  
  # Check that "Non-user" column exists and has value 1 (100%)
  expect_true("Non-user" %in% names(result))
  expect_equal(result$`Non-user`[1], 1)
  
  # Check that n equals 3
  expect_equal(result$n[1], 3)
  
  # Check column order is maintained
  expect_equal(names(result)[1], "MetricDate")
  expect_equal(names(result)[length(names(result))], "n")
})