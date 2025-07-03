# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See LICENSE.txt in the project root for license information.
# --------------------------------------------------------------------------------------------
library(testthat)
library(vivainsights)

test_that("calculate_distribution_summary returns correct statistics", {
  
  # Create test data with known values
  test_data <- data.frame(
    group = c(rep("A", 5), rep("B", 5)),
    test_metric = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
  )
  
  result <- calculate_distribution_summary(test_data, "test_metric")
  
  # Check structure
  expect_s3_class(result, "data.frame")
  expect_equal(nrow(result), 2)
  expect_equal(ncol(result), 12)
  
  # Check column names
  expected_cols <- c("group", "mean", "min", "p10", "p25", "p50", "p75", "p90", "max", "sd", "range", "n")
  expect_true(all(expected_cols %in% names(result)))
  
  # Check Group A statistics (values 1-5)
  result_a <- result[result$group == "A", ]
  expect_equal(result_a$mean, 3)
  expect_equal(result_a$min, 1)
  expect_equal(result_a$max, 5)
  expect_equal(result_a$p50, 3)
  expect_equal(result_a$range, 4)
  expect_equal(result_a$n, 5)
  
  # Check Group B statistics (values 6-10)
  result_b <- result[result$group == "B", ]
  expect_equal(result_b$mean, 8)
  expect_equal(result_b$min, 6)
  expect_equal(result_b$max, 10)
  expect_equal(result_b$p50, 8)
  expect_equal(result_b$range, 4)
  expect_equal(result_b$n, 5)
})

test_that("calculate_distribution_summary handles NA values correctly", {
  
  # Create test data with NA values
  test_data <- data.frame(
    group = c(rep("A", 5), rep("B", 5)),
    test_metric = c(1, 2, NA, 4, 5, 6, 7, 8, 9, NA)
  )
  
  result <- calculate_distribution_summary(test_data, "test_metric")
  
  # Check that the function handles NAs correctly
  expect_s3_class(result, "data.frame")
  expect_equal(nrow(result), 2)
  
  # Check that NA values are handled (result should still be meaningful)
  expect_false(any(is.na(result$mean)))
  expect_false(any(is.na(result$min)))
  expect_false(any(is.na(result$max)))
})

test_that("calculate_distribution_summary percentiles are correctly ordered", {
  
  # Create test data
  test_data <- data.frame(
    group = rep("Test", 100),
    test_metric = runif(100, 0, 100)
  )
  
  result <- calculate_distribution_summary(test_data, "test_metric")
  
  # Check percentile ordering
  expect_true(result$min <= result$p10)
  expect_true(result$p10 <= result$p25)
  expect_true(result$p25 <= result$p50)
  expect_true(result$p50 <= result$p75)
  expect_true(result$p75 <= result$p90)
  expect_true(result$p90 <= result$max)
  
  # Check range calculation
  expect_equal(result$range, result$max - result$min)
  
  # Check n value
  expect_equal(result$n, 100)
})