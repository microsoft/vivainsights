# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See LICENSE.txt in the project root for license information.
# --------------------------------------------------------------------------------------------
library(testthat)
library(vivainsights)


test_that("create_dt returns a htmlwidget", {

    output <- hrvar_count(pq_data, return = "table")
    result <- create_dt(output)

  # Check if the result is a htmlwidget object
  expect_s3_class(result, "htmlwidget")
})