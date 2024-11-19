# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See LICENSE.txt in the project root for license information.
# --------------------------------------------------------------------------------------------
library(testthat)
library(vivainsights)

test_that("create_rank returns a data frame when return = 'table'", {

  result <-create_rank(
		   data = pq_data,
		   metric = "Emails_sent",
		   return = "table"
		   )

  # Check if the result is a data frame
  expect_s3_class(result, "data.frame")
})

test_that("create_rank returns a ggplot when return = 'plot' and plot_mode = 1", {

  result <- create_rank(
                data = pq_data,
                hrvar = c("FunctionType", "LevelDesignation"),
                metric = "Emails_sent",
                return = "plot",
                plot_mode = 1
                )

  # Check if the result is a ggplot object
  expect_s3_class(result, "ggplot")
})

test_that("create_rank returns a ggplot when return = 'plot' and plot_mode = 2", {

  result <- create_rank(
                data = pq_data,
                hrvar = c("FunctionType", "LevelDesignation"),
                metric = "Emails_sent",
                return = "plot",
                plot_mode = 2
                )

  # Check if the result is a ggplot object
  expect_s3_class(result, "ggplot")
})

test_that("create_rank returns a data frame when mode = 'combine'. In this case return type doesnt matter.", {

  result <-create_rank(
            data = pq_data,
            hrvar = c("FunctionType", "LevelDesignation"),
            metric = "Emails_sent",
            mode = "combine"
            )

  # Check if the result is a data frame
  expect_s3_class(result, "data.frame")
  })