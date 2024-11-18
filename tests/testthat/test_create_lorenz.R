# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See LICENSE.txt in the project root for license information.
# --------------------------------------------------------------------------------------------
library(testthat)
library(vivainsights)


test_that("create_lorenz returns a data frame when return = 'table'", {

  result <- create_lorenz(data = pq_data, metric = "Emails_sent", return = "table")

  # Check if the result is a data frame
  expect_s3_class(result, "data.frame")
})

test_that("create_lorenz returns a ggplot when return = 'plot'", {

  result <- create_lorenz(data = pq_data, metric = "Emails_sent", return = "plot")

  # Check if the result is a ggplot object
  expect_s3_class(result, "ggplot")
})

test_that("create_lorenz returns a numeric when return = 'gini'", {

  result <- create_lorenz(data = pq_data, metric = "Emails_sent", return = "gini")

  # Check if the result is a numeric
  expect_true(is.numeric(result))
})
