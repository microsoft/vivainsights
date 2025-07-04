# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See LICENSE.txt in the project root for license information.
# --------------------------------------------------------------------------------------------
library(testthat)
library(vivainsights)

test_that("create_inc returns a data frame when return = 'table'", {

  result <- create_inc(
                data = pq_data,
                metric = "Collaboration_hours",
                hrvar = c("LevelDesignation", "Organization"),
                threshold = 20,
                position = "below",
                return = "table"
              )

  # Check if the result is a data frame
  expect_s3_class(result, "data.frame")
})

test_that("create_inc returns a ggplot when return = 'plot'", {

  result <- create_inc(
                data = pq_data,
                metric = "Collaboration_hours",
                hrvar = c("LevelDesignation", "Organization"),
                threshold = 20,
                position = "below",
                return = "plot"
                )

  # Check if the result is a ggplot object
  expect_s3_class(result, "ggplot")
})

test_that("create_inc works with NULL hrvar", {
  
  result <- create_inc(
                data = pq_data,
                metric = "Collaboration_hours",
                hrvar = NULL,
                threshold = 20,
                position = "below",
                return = "table"
              )
  
  # Check if the result is a data frame
  expect_s3_class(result, "data.frame")
  
  # Check if the result contains the expected "group" column from totals_col
  expect_true("group" %in% names(result))
})

test_that("create_inc throws error for invalid position", {
  
  expect_error(
    create_inc(
      data = pq_data,
      metric = "Collaboration_hours",
      hrvar = "Organization",
      threshold = 20,
      position = "invalid",
      return = "table"
    ),
    "Invalid value for `position`. Please use either \"above\" or \"below\"."
  )
})

test_that("create_inc throws error for invalid position with NULL hrvar", {
  
  expect_error(
    create_inc(
      data = pq_data,
      metric = "Collaboration_hours",
      hrvar = NULL,
      threshold = 20,
      position = "invalid",
      return = "table"
    ),
    "Invalid value for `position`. Please use either \"above\" or \"below\"."
  )
})