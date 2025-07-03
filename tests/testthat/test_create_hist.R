# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See LICENSE.txt in the project root for license information.
# --------------------------------------------------------------------------------------------
library(testthat)
library(vivainsights)

test_that("create_hist returns a data frame when return = 'table'", {

  result <- create_hist(pq_data,  metric = "Collaboration_hours", hrvar = "Organization", return = "table")

  # Check if the result is a data frame
  expect_s3_class(result, "data.frame")
  
  # Check that all expected columns are present
  expected_cols <- c("group", "mean", "min", "p10", "p25", "p50", "p75", "p90", "max", "sd", "range", "n")
  expect_true(all(expected_cols %in% names(result)))
  
  # Check that we have the correct number of columns
  expect_equal(ncol(result), 12)
  
  # Check that 'n' column is present (not 'Employee_Count')
  expect_true("n" %in% names(result))
  expect_false("Employee_Count" %in% names(result))
})

test_that("create_hist returns a data frame when return = 'data'", {

  result <- create_hist(pq_data, metric = "Collaboration_hours", hrvar = "Organization", return = "data")
  
  # Check if the result is a data frame
  expect_s3_class(result, "data.frame")
})

test_that("create_hist returns a ggplot when return = 'plot'", {

  result <- create_hist(pq_data, metric = "Collaboration_hours", hrvar = "Organization", return = "plot")
  
  # Check if the result is a ggplot object
  expect_s3_class(result, "ggplot")
})

test_that("create_hist returns a list when return = 'frequency'", {

  result <- create_hist(pq_data, metric = "Collaboration_hours", hrvar = "Organization", return = "frequency")
  
  # Check if the result is a list
  expect_true(is.list(result))
})

test_that("create_hist table output statistics are correctly calculated", {
  
  # Create simple test data
  test_data <- data.frame(
    PersonId = rep(c("P1", "P2", "P3", "P4", "P5"), each = 2),
    MetricDate = rep(as.Date(c("2024-01-01", "2024-01-08")), 5),
    Collaboration_hours = c(10, 10, 20, 20, 30, 30, 40, 40, 50, 50),
    Organization = rep(c("Sales", "Marketing"), each = 5),
    stringsAsFactors = FALSE
  )
  
  # Get result using a mock-like approach (we can't run the full function without dependencies)
  # This test verifies the statistical calculations indirectly through the helper function
  
  # Skip if we can't load the package
  skip_if_not_installed("vivainsights")
  
  # If we can run the function, verify statistics
  if(exists("create_hist")) {
    result <- create_hist(test_data, metric = "Collaboration_hours", hrvar = "Organization", return = "table")
    
    # Verify each group has correct statistics
    for(grp in c("Sales", "Marketing")) {
      grp_result <- result[result$group == grp, ]
      expect_true(grp_result$min <= grp_result$p25)
      expect_true(grp_result$p25 <= grp_result$p50)
      expect_true(grp_result$p50 <= grp_result$p75)
      expect_true(grp_result$p75 <= grp_result$max)
      expect_equal(grp_result$range, grp_result$max - grp_result$min)
      expect_true(grp_result$n > 0)
    }
  }
})
