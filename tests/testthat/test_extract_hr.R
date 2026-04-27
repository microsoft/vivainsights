# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See LICENSE.txt in the project root for license information.
# --------------------------------------------------------------------------------------------

library(testthat)
library(vivainsights)

test_that("extract_hr returns a character vector when return = 'names'", {

  result <- pq_data %>% extract_hr(return = "names")

  expect_type(result, "character")
  expect_true(length(result) > 0)
})

test_that("extract_hr returns a data frame when return = 'vars'", {

  result <- pq_data %>% extract_hr(return = "vars")

  expect_s3_class(result, "data.frame")
  expect_true(ncol(result) > 0)
})

test_that("extract_hr emits message when columns exceed max_unique", {

  # Use a low threshold so some columns are excluded
  expect_message(
    pq_data %>% extract_hr(max_unique = 3, return = "names"),
    "column\\(s\\) excluded due to max_unique"
  )
})

test_that("extract_hr emits no message when no columns exceed max_unique", {

  # Use a very high threshold so nothing is excluded
  expect_no_message(
    pq_data %>% extract_hr(max_unique = 10000, return = "names")
  )
})

test_that("extract_hr errors on invalid return argument", {

  expect_error(
    pq_data %>% extract_hr(return = "invalid"),
    "Invalid input for return"
  )
})
