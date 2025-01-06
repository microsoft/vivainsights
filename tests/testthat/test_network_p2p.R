# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See LICENSE.txt in the project root for license information.
# --------------------------------------------------------------------------------------------
library(testthat)
library(vivainsights)

# Define the unit test
test_that("network_p2p returns a data frame when return = 'table'", {

    result <- network_p2p(p2p_data, return = "table")

    # Check if the result is a data frame
    expect_s3_class(result, "data.frame")
})
