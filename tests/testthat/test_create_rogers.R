# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See LICENSE.txt in the project root for license information.
# --------------------------------------------------------------------------------------------

library(testthat)
library(vivainsights)
library(dplyr)

test_that("create_rogers returns a data frame when return = 'data'", {
  result <- create_rogers(
    data = pq_data,
    metric = "Copilot_actions_taken_in_Teams",
    return = "data"
  )
  # Check if the result is a data frame
  expect_s3_class(result, "data.frame")
})

test_that("create_rogers includes IsHabit column when return = 'data'", {
  result <- create_rogers(
    data = pq_data,
    metric = "Copilot_actions_taken_in_Teams",
    return = "data"
  )
  # Check if IsHabit column exists
  expect_true("IsHabit" %in% colnames(result))
})

test_that("create_rogers includes adoption_week column when return = 'data'", {
  result <- create_rogers(
    data = pq_data,
    metric = "Copilot_actions_taken_in_Teams",
    return = "data"
  )
  # Check if adoption_week column exists
  expect_true("adoption_week" %in% colnames(result))
})

test_that("create_rogers includes Rogers segment columns when start_metric is provided", {
  result <- create_rogers(
    data = pq_data,
    metric = "Copilot_actions_taken_in_Teams",
    start_metric = "Total_Copilot_enabled_days",
    return = "data"
  )
  # Check if Rogers segment columns exist
  expect_true("enable_week" %in% colnames(result))
  expect_true("weeks_to_adopt" %in% colnames(result))
  expect_true("RogersSegment" %in% colnames(result))
})

test_that("create_rogers does not include Rogers segment when start_metric is not provided", {
  result <- suppressMessages(create_rogers(
    data = pq_data,
    metric = "Copilot_actions_taken_in_Teams",
    return = "data"
  ))
  # Rogers segment columns should not exist when start_metric is not provided
  expect_false("RogersSegment" %in% colnames(result))
})

test_that("create_rogers raises an error when start_metric is missing for plot mode 3", {
  expect_error(
    create_rogers(
      data = pq_data,
      metric = "Copilot_actions_taken_in_Teams",
      plot_mode = 3,
      return = "plot"
    ),
    "The 'start_metric' parameter is required"
  )
})

test_that("create_rogers raises an error when start_metric is missing for plot mode 4", {
  expect_error(
    create_rogers(
      data = pq_data,
      metric = "Copilot_actions_taken_in_Teams",
      plot_mode = 4,
      return = "plot"
    ),
    "The 'start_metric' parameter is required"
  )
})

test_that("create_rogers returns a ggplot when return = 'plot'", {
  result <- create_rogers(
    data = pq_data,
    metric = "Copilot_actions_taken_in_Teams",
    plot_mode = 1,
    return = "plot"
  )

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

test_that("create_rogers returns a summary table when return = 'table'", {
  result <- create_rogers(
    data = pq_data,
    metric = "Copilot_actions_taken_in_Teams",
    return = "table"
  )
  # Check if the result is a data frame
  expect_s3_class(result, "data.frame")
  # Check if expected summary columns exist
  expect_true("total_adopters" %in% colnames(result))
})

test_that("create_rogers RogersSegment has correct categories", {
  result <- suppressMessages(create_rogers(
    data = pq_data,
    metric = "Copilot_actions_taken_in_Teams",
    start_metric = "Total_Copilot_enabled_days",
    return = "data"
  ))
  
  # Check if RogersSegment column contains expected categories
  unique_segments <- unique(result$RogersSegment[!is.na(result$RogersSegment)])
  expected_segments <- c("Innovators", "Early Adopters", "Early Majority", "Late Majority", "Laggards")
  expect_true(all(unique_segments %in% expected_segments))
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

test_that("create_rogers plot mode 2 respects label parameter", {
  # Plot mode 2 labels should be controlled by label parameter
  result_no_label <- create_rogers(
    data = test_data,
    metric = "Copilot_actions_taken_in_Teams",
    plot_mode = 2,
    label = FALSE
  )
  
  result_with_label <- create_rogers(
    data = test_data,
    metric = "Copilot_actions_taken_in_Teams",
    plot_mode = 2,
    label = TRUE
  )
  
  # Check if the results are ggplot objects
  expect_s3_class(result_no_label, "ggplot")
  expect_s3_class(result_with_label, "ggplot")
  
  # Should NOT contain geom_text layer when label = FALSE
  layer_classes_no_label <- sapply(result_no_label$layers, function(x) class(x$geom)[1])
  expect_false("GeomText" %in% layer_classes_no_label)
  
  # Should contain geom_text layer when label = TRUE
  layer_classes_with_label <- sapply(result_with_label$layers, function(x) class(x$geom)[1])
  expect_true("GeomText" %in% layer_classes_with_label)
})

test_that("create_rogers plot mode 3 respects label parameter", {
  # Plot mode 3 labels should be controlled by label parameter
  result_no_label <- create_rogers(
    data = test_data,
    metric = "Copilot_actions_taken_in_Teams",
    start_metric = "Total_Copilot_enabled_days",
    plot_mode = 3,
    label = FALSE
  )
  
  result_with_label <- create_rogers(
    data = test_data,
    metric = "Copilot_actions_taken_in_Teams",
    start_metric = "Total_Copilot_enabled_days",
    plot_mode = 3,
    label = TRUE
  )
  
  # Check if the results are ggplot objects
  expect_s3_class(result_no_label, "ggplot")
  expect_s3_class(result_with_label, "ggplot")
  
  # Should NOT contain geom_text layer when label = FALSE
  layer_classes_no_label <- sapply(result_no_label$layers, function(x) class(x$geom)[1])
  expect_false("GeomText" %in% layer_classes_no_label)
  
  # Should contain geom_text layer when label = TRUE
  layer_classes_with_label <- sapply(result_with_label$layers, function(x) class(x$geom)[1])
  expect_true("GeomText" %in% layer_classes_with_label)
})
