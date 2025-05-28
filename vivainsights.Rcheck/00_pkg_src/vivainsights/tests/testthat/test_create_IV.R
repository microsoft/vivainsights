# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See LICENSE.txt in the project root for license information.
# --------------------------------------------------------------------------------------------
library(testthat)
library(vivainsights)

test_that("create_IV returns a data frame when return = 'summary'", {

  result <-
    pq_data %>%
    dplyr::mutate(X = ifelse(Internal_network_size > 40, 1, 0)) %>%
    create_IV(outcome = "X",
              predictors = c("Email_hours", "Meeting_hours"),
              return = "summary")

  # Check if the result is a data frame
  expect_s3_class(result, "data.frame")
})

test_that("create_IV returns a ggplot when return = 'plot'", {

  result <-
    pq_data %>%
    dplyr::mutate(X = ifelse(Internal_network_size > 40, 1, 0)) %>%
    create_IV(outcome = "X",
              predictors = c("Email_hours", "Meeting_hours"),
              return = "plot")

  # Check if the result is a ggplot object
  expect_s3_class(result, "ggplot")
})


test_that("create_IV returns a list when return = 'list'", {

  result <-
    pq_data %>%
    dplyr::mutate(X = ifelse(Internal_network_size > 40, 1, 0)) %>%
    create_IV(outcome = "X",
              predictors = c("Email_hours", "Meeting_hours"),
              return = "list")

  # Check if the result is a list
  expect_true(is.list(result))
})

test_that("create_IV returns a list when return = 'plot-WOE'", {

  result <-
    pq_data %>%
    dplyr::mutate(X = ifelse(Internal_network_size > 40, 1, 0)) %>%
    create_IV(outcome = "X",
              predictors = c("Email_hours", "Meeting_hours"),
              return = "plot-WOE")

  # Check if the result is a list
  expect_true(is.list(result))
})

test_that("create_IV returns a list when return = 'IV'", {

  result <-
    pq_data %>%
    dplyr::mutate(X = ifelse(Internal_network_size > 40, 1, 0)) %>%
    create_IV(outcome = "X",
              predictors = c("Email_hours", "Meeting_hours"),
              return = "IV")

  # Check if the result is a list
  expect_true(is.list(result))
})
