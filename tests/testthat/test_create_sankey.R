# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See LICENSE.txt in the project root for license information.
# --------------------------------------------------------------------------------------------
library(testthat)
library(vivainsights)
library(dplyr)

test_that("create_sankey returns a sankeyNetwork object.", {

  result <-pq_data %>%
		   dplyr::count(Organization, FunctionType) %>%
		   create_sankey(var1 = "Organization", var2 = "FunctionType")

  # Check if the result is a sankeyNetwork object
  expect_s3_class(result, "sankeyNetwork")
})