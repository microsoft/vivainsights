library(testthat)
library(vivainsights)

# Define the unit test
test_that("network_p2p returns a data frame when return = 'table'", {

    result <- network_p2p(p2p_data, return = "table")

    # Check if the result is a data frame
    expect_s3_class(result, "data.frame")
})
