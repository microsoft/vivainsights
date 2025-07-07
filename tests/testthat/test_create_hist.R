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
  
  # Check that the new enhanced columns are present
  expected_cols <- c("group", "mean", "min", "p10", "p25", "p50", "p75", "p90", "max", "sd", "range", "n")
  expect_true(all(expected_cols %in% names(result)))
  
  # Check that we have 12 columns (enhanced output)
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
