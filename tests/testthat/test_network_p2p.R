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

test_that("network_p2p errors with informative message when multiple MetricDates are present", {
    # Create test data with multiple MetricDate values
    multi_date_data <- p2p_data
    
    # Add a second date by duplicating the data and changing the date
    second_date_data <- p2p_data
    second_date_data$MetricDate <- as.Date(second_date_data$MetricDate) + 7  # Add 7 days
    
    # Combine both sets
    multi_date_data <- rbind(p2p_data, second_date_data)
    
    # Test that appropriate error is thrown
    expect_error(
        network_p2p(multi_date_data, return = "table"),
        "Multiple `MetricDate` values detected"
    )
})
