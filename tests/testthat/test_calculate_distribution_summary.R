# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See LICENSE.txt in the project root for license information.
# --------------------------------------------------------------------------------------------
library(testthat)
library(vivainsights)

test_that("calculate_distribution_summary returns correct structure", {
  
  # Create simple test data
  test_data <- data.frame(
    group = c(rep("A", 3), rep("B", 3)),
    test_metric = c(1, 2, 3, 4, 5, 6)
  )
  
  result <- calculate_distribution_summary(test_data, "test_metric")
  
  # Check structure
  expect_s3_class(result, "data.frame")
  expect_equal(nrow(result), 2)
  expect_equal(ncol(result), 12)
  
  # Check column names
  expected_cols <- c("group", "mean", "min", "p10", "p25", "p50", "p75", "p90", "max", "sd", "range", "n")
  expect_true(all(expected_cols %in% names(result)))
  
  # Check that all values are numeric (except group)
  expect_true(all(sapply(result[, -1], is.numeric)))
  
  # Check basic constraints
  expect_true(all(result$n > 0))
  expect_true(all(result$min <= result$max))
  expect_true(all(result$range >= 0))
})