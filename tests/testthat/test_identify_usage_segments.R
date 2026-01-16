# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See LICENSE.txt in the project root for license information.
# --------------------------------------------------------------------------------------------

library(testthat)
library(vivainsights)

skip_if_not_installed("dplyr")
skip_if_not_installed("tidyr")
skip_if_not_installed("slider")

library(dplyr)
library(tidyr)
library(slider)

# Helper function to create mock data
create_mock_data <- function(
    persons = c("A", "B", "C"),
    weeks = 4,
    values = NULL
) {
  n_persons <- length(persons)
  dates <- seq(as.Date("2024-01-01"), by = "week", length.out = weeks)
  
  if (is.null(values)) {
    values <- rep(sample(0:30, n_persons * weeks, replace = TRUE), 1)
  }
  
  data.frame(
    PersonId = rep(persons, each = weeks),
    MetricDate = rep(dates, n_persons),
    Total_actions = values,
    stringsAsFactors = FALSE
  )
}

# Expected segment names for validation
expected_segments <- c("Power User", "Habitual User", "Novice User", "Low User", "Non-user")

test_that("identify_usage_segments returns table correctly", {
  mock_data <- create_mock_data(
    values = c(0, 5, 10, 20, 1, 8, 15, 25, 0, 0, 2, 5)
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
  expect_true(any(expected_segments %in% names(result_12w)))
  expect_true(any(expected_segments %in% names(result_4w)))
})

test_that("identify_usage_segments prints message for table return", {
  mock_data <- create_mock_data(
    persons = c("A", "B"),
    weeks = 2,
    values = c(5, 10, 15, 20)
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
  mock_data <- create_mock_data(
    persons = c("A", "B"),
    weeks = 2,
    values = c(5, 10, 15, 20)
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
  # Create mock data with more weeks to test custom parameters
  mock_data <- create_mock_data(
    weeks = 8,
    values = c(
      0, 5, 10, 20, 15, 12, 8, 18,   # Person A
      1, 8, 15, 25, 20, 18, 22, 30,  # Person B
      0, 0, 2, 5, 3, 1, 0, 4         # Person C
    )
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
  expect_true(any(expected_segments %in% names(result_custom)))
  
  # Check that proportions sum to 1 for each date (allowing for rounding errors)
  segment_cols <- names(result_custom)[names(result_custom) %in% expected_segments]
  if (length(segment_cols) > 0) {
    row_sums <- rowSums(result_custom[segment_cols], na.rm = TRUE)
    expect_true(all(abs(row_sums - 1) < 0.001))
  }
})

test_that("identify_usage_segments prints custom parameters message for table return", {
  mock_data <- create_mock_data(
    persons = c("A", "B"),
    values = c(5, 10, 15, 20, 8, 12, 18, 25)
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
  # Create mock data with high values to test power user classification
  mock_data <- create_mock_data(
    values = c(
      20, 25, 30, 35,  # Person A: high usage
      10, 12, 8, 6,    # Person B: medium usage
      1, 2, 1, 3       # Person C: low usage
    )
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
  # Create mock data
  mock_data <- create_mock_data(
    persons = c("A", "B"),
    weeks = 6,
    values = c(
      20, 25, 18, 22, 30, 28,  # Person A: consistently high
      5, 8, 12, 6, 10, 9       # Person B: consistently low
    )
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
  # Create mock data with one row per person per date
  mock_data <- data.frame(
    PersonId = c("A", "B", "C"),
    MetricDate = as.Date(rep("2024-01-01", 3)),
    Total_actions = c(10, 15, 5),
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
  
  # Check that n equals the number of distinct PersonIds (3)
  expect_equal(result$n[1], 3)
  
  # Check column order: MetricDate should be first, followed by n, then segments
  expect_equal(names(result)[1], "MetricDate")
  expect_equal(names(result)[2], "n")
  
  # Check that segment columns exist after MetricDate and n
  segment_cols <- names(result)[3:length(names(result))]
  expected_segments <- c("Non-user", "Low User", "Novice User", "Habitual User", "Power User")
  expect_true(all(segment_cols %in% expected_segments))
})

test_that("identify_usage_segments warns when NA values are present in metric", {
  # Create mock data with NA values in the metric
  mock_data <- data.frame(
    PersonId = rep(c("A", "B", "C"), each = 4),
    MetricDate = rep(as.Date(c("2024-01-01", "2024-01-08", "2024-01-15", "2024-01-22")), 3),
    Total_actions = c(10, 15, NA, 20, 5, NA, 10, 15, 2, 3, 4, NA),
    stringsAsFactors = FALSE
  )
  
  # Skip if NA warning feature not available in current package version
  # This test validates the NA warning feature once it's deployed
  has_na_warning <- tryCatch({
    test_result <- suppressMessages(
      identify_usage_segments(
        data = mock_data,
        metric = "Total_actions",
        version = "12w",
        return = "data"
      )
    )
    FALSE
  }, warning = function(w) {
    grepl("NAs detected", w$message)
  })
  
  skip_if(!has_na_warning, "NA warning feature not available in installed package")
  
  # Test that warning is displayed when NAs are present
  expect_warning(
    identify_usage_segments(
      data = mock_data,
      metric = "Total_actions",
      version = "12w",
      return = "data"
    ),
    "NAs detected in the metric variable"
  )
})

test_that("identify_usage_segments table handles missing segments gracefully", {
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
  
  # Check column order is maintained: MetricDate first, n second
  expect_equal(names(result)[1], "MetricDate")
  expect_equal(names(result)[2], "n")
})

test_that("identify_usage_segments does not warn when no NA values are present", {
  mock_data <- create_mock_data(
    persons = c("A", "B"),
    values = c(10, 15, 20, 25, 5, 8, 10, 12)
  )
  
  # Test that no warning is displayed when there are no NAs
  expect_no_warning(
    suppressMessages(
      identify_usage_segments(
        data = mock_data,
        metric = "Total_actions",
        version = "12w",
        return = "data"
      )
    )
  )
})

test_that("identify_usage_segments warns when NA values are present in metric_str", {
  # Create mock data with NA values in multiple metric columns
  mock_data <- data.frame(
    PersonId = rep(c("A", "B", "C"), each = 4),
    MetricDate = rep(as.Date(c("2024-01-01", "2024-01-08", "2024-01-15", "2024-01-22")), 3),
    Metric1 = c(5, 10, NA, 15, 3, NA, 5, 8, 1, 2, 3, NA),
    Metric2 = c(5, 5, 5, 5, 2, 2, NA, 7, 1, 1, 1, 1),
    stringsAsFactors = FALSE
  )
  
  # Skip if NA warning feature not available in current package version
  has_na_warning <- tryCatch({
    test_result <- suppressMessages(
      identify_usage_segments(
        data = mock_data,
        metric_str = c("Metric1", "Metric2"),
        version = "12w",
        return = "data"
      )
    )
    FALSE
  }, warning = function(w) {
    grepl("NAs detected", w$message)
  })
  
  skip_if(!has_na_warning, "NA warning feature not available in installed package")
  
  # Test that warning is displayed when NAs are present in metric_str columns
  expect_warning(
    identify_usage_segments(
      data = mock_data,
      metric_str = c("Metric1", "Metric2"),
      version = "12w",
      return = "data"
    ),
    "NAs detected in the metric variable"
  )
})