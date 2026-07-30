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

test_that("network_p2p safely dispatches documented community algorithms", {
    set.seed(1)
    sim_data <- p2p_data_sim(size = 30, nei = 2)

    result <- network_p2p(
        sim_data,
        community = "louvain",
        return = "network"
    )

    expect_s3_class(result, "igraph")
    expect_true("cluster" %in% igraph::vertex_attr_names(result))
})

test_that("network_p2p supports documented palette names and functions", {
    set.seed(1)
    sim_data <- p2p_data_sim(size = 30, nei = 2)

    expect_s3_class(
        network_p2p(
            sim_data,
            style = "ggraph",
            palette = "rainbow"
        ),
        "ggplot"
    )
    expect_s3_class(
        network_p2p(
            sim_data,
            style = "ggraph",
            palette = "heat_colors"
        ),
        "ggplot"
    )
    expect_s3_class(
        network_p2p(
            sim_data,
            style = "ggraph",
            palette = function(n) rep("#0078D4", n)
        ),
        "ggplot"
    )
})

test_that("network_p2p rejects executable palette strings", {
    set.seed(1)
    sim_data <- p2p_data_sim(size = 30, nei = 2)
    payload_name <- ".network_p2p_payload_executed"
    on.exit({
        if (exists(payload_name, envir = .GlobalEnv, inherits = FALSE)) {
            rm(list = payload_name, envir = .GlobalEnv)
        }
    }, add = TRUE)

    payload <- paste0(
        "(function(n) { assign('",
        payload_name,
        "', TRUE, envir = .GlobalEnv); rainbow(n) })"
    )

    expect_error(
        network_p2p(sim_data, style = "ggraph", palette = payload),
        "`palette` must be"
    )
    expect_false(exists(payload_name, envir = .GlobalEnv, inherits = FALSE))
})

test_that("network_p2p safely dispatches igraph layouts", {
    set.seed(1)
    sim_data <- p2p_data_sim(size = 30, nei = 2)
    plot_file <- tempfile(fileext = ".pdf")
    grDevices::pdf(plot_file)
    on.exit({
        grDevices::dev.off()
        unlink(plot_file)
    }, add = TRUE)

    expect_no_error(
        suppressWarnings(
            network_p2p(
                sim_data,
                style = "igraph",
                layout = "mds"
            )
        )
    )
    expect_error(
        network_p2p(
            sim_data,
            style = "igraph",
            layout = "mds; base::stop('executed')"
        ),
        "layout.*must be one of"
    )
})
