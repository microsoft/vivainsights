# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See LICENSE.txt in the project root for license information.
# --------------------------------------------------------------------------------------------
library(testthat)
library(vivainsights)
library(dplyr)

# Test data creation - mock data with required columns
test_data <- data.frame(
  PersonId = rep(paste0("Person", 1:20), each = 10),
  MetricDate = rep(seq(as.Date("2023-01-01"), by = "week", length.out = 10), 20),
  Copilot_actions_taken_in_Teams = sample(0:5, 200, replace = TRUE),
  Total_Copilot_enabled_days = sample(c(0, 1), 200, replace = TRUE),
  Organization = rep(c("Org1", "Org2"), each = 100)
)

test_that("create_rogers returns a ggplot when return = 'plot'", {
  result <- create_rogers(
    data = test_data,
    metric = "Copilot_actions_taken_in_Teams",
    plot_mode = 1
  )
  
  # Check if the result is a ggplot object
  expect_s3_class(result, "ggplot")
})

test_that("create_rogers with label = FALSE behaves as before for plot mode 1", {
  result <- create_rogers(
    data = test_data,
    metric = "Copilot_actions_taken_in_Teams",
    plot_mode = 1,
    label = FALSE
  )
  
  # Check if the result is a ggplot object
  expect_s3_class(result, "ggplot")
  
  # Should contain geom_point layer (default behavior)
  layer_classes <- sapply(result$layers, function(x) class(x$geom)[1])
  expect_true("GeomPoint" %in% layer_classes)
  # Should not contain geom_text layer when label = FALSE
  expect_false("GeomText" %in% layer_classes)
})

test_that("create_rogers with label = TRUE adds text layers for plot mode 1", {
  result <- create_rogers(
    data = test_data,
    metric = "Copilot_actions_taken_in_Teams",
    plot_mode = 1,
    label = TRUE
  )
  
  # Check if the result is a ggplot object
  expect_s3_class(result, "ggplot")
  
  # Should contain geom_point and geom_text layers when label = TRUE
  layer_classes <- sapply(result$layers, function(x) class(x$geom)[1])
  expect_true("GeomPoint" %in% layer_classes)
  expect_true("GeomText" %in% layer_classes)
})

test_that("create_rogers with label = TRUE adds text layers for plot mode 4", {
  result <- create_rogers(
    data = test_data,
    metric = "Copilot_actions_taken_in_Teams",
    start_metric = "Total_Copilot_enabled_days",
    plot_mode = 4,
    label = TRUE
  )
  
  # Check if the result is a ggplot object
  expect_s3_class(result, "ggplot")
  
  # Should contain geom_point and geom_text layers when label = TRUE
  layer_classes <- sapply(result$layers, function(x) class(x$geom)[1])
  expect_true("GeomPoint" %in% layer_classes)
  expect_true("GeomText" %in% layer_classes)
})

test_that("create_rogers plot mode 1 has updated title and subtitle", {
  result <- create_rogers(
    data = test_data,
    metric = "Copilot_actions_taken_in_Teams",
    plot_mode = 1
  )
  
  # Check title and subtitle
  expect_equal(result$labels$title, "Rogers cumulative adoption curve")
  expect_match(result$labels$subtitle, "Based on Copilot actions taken in Teams")
})

test_that("create_rogers plot mode 4 has updated title and subtitle", {
  result <- create_rogers(
    data = test_data,
    metric = "Copilot_actions_taken_in_Teams",
    start_metric = "Total_Copilot_enabled_days",
    plot_mode = 4
  )
  
  # Check title and subtitle
  expect_equal(result$labels$title, "Enablement-adjusted cumulative adoption curve")
  expect_match(result$labels$subtitle, "Based on Copilot actions taken in Teams")
})

test_that("create_rogers plot mode 2 has updated subtitle mentioning moving average", {
  result <- create_rogers(
    data = test_data,
    metric = "Copilot_actions_taken_in_Teams",
    plot_mode = 2
  )
  
  # Check subtitle mentions moving average
  expect_match(result$labels$subtitle, "line indicating moving average")
})

test_that("create_rogers plot mode 3 caption includes segment proportions", {
  result <- create_rogers(
    data = test_data,
    metric = "Copilot_actions_taken_in_Teams",
    start_metric = "Total_Copilot_enabled_days",
    plot_mode = 3
  )
  
  # Check caption includes proportions
  expect_match(result$labels$caption, "Innovators:")
  expect_match(result$labels$caption, "%")
})

test_that("create_rogers label parameter doesn't affect non-cumulative plots", {
  # Plot mode 2 should not be affected by label parameter
  result <- create_rogers(
    data = test_data,
    metric = "Copilot_actions_taken_in_Teams",
    plot_mode = 2,
    label = TRUE
  )
  
  # Check if the result is a ggplot object
  expect_s3_class(result, "ggplot")
  
  # Should not contain geom_text layer for plot mode 2
  layer_classes <- sapply(result$layers, function(x) class(x$geom)[1])
  expect_false("GeomText" %in% layer_classes)
})