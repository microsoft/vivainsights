# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See LICENSE.txt in the project root for license information.
# --------------------------------------------------------------------------------------------
library(testthat)
library(vivainsights)

# Define the unit test
test_that("network_p2p returns a data frame when return = 'table'", {
    # Use p2p_data_sim() to generate test data
    sim_data <- p2p_data_sim(size = 50, nei = 2)
    
    result <- network_p2p(sim_data, return = "table")

    # Check if the result is a data frame
    expect_s3_class(result, "data.frame")
})

test_that("network_p2p errors with informative message when multiple MetricDates are present", {
    # Create test data with multiple MetricDate values using p2p_data_sim()
    base_data <- p2p_data_sim(size = 50, nei = 2)
    
    # Add a MetricDate column to the simulated data
    base_data$MetricDate <- as.Date("2023-01-01")
    
    # Create a second dataset with different MetricDate
    second_date_data <- base_data
    second_date_data$MetricDate <- as.Date("2023-01-08")  # Add 7 days
    
    # Combine both sets
    multi_date_data <- rbind(base_data, second_date_data)
    
    # Test that appropriate error is thrown
    expect_error(
        network_p2p(multi_date_data, return = "table"),
        "Multiple `MetricDate` values detected"
    )
})
