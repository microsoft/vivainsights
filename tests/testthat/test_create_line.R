# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See LICENSE.txt in the project root for license information.
# --------------------------------------------------------------------------------------------
library(testthat)
library(vivainsights)

test_that("create_line returns a data frame when return = 'table'", {

  result <- pq_data %>% create_line(metric = "Collaboration_hours", return = "table")

  # Check if the result is a data frame
  expect_s3_class(result, "data.frame")
})

test_that("create_line returns a ggplot when return = 'plot'", {

  result <- pq_data %>% create_line(metric = "Collaboration_hours", return = "plot")

  # Check if the result is a ggplot object
  expect_s3_class(result, "ggplot")
})

test_that("create_line with label = FALSE behaves as before", {

  result <- pq_data %>% create_line(metric = "Collaboration_hours", label = FALSE, return = "plot")

  # Check if the result is a ggplot object
  expect_s3_class(result, "ggplot")
  
  # Should not contain geom_point or geom_text layers (default behavior)
  layer_classes <- sapply(result$layers, function(x) class(x$geom)[1])
  expect_false("GeomPoint" %in% layer_classes)
  expect_false("GeomText" %in% layer_classes)
})

test_that("create_line with label = TRUE adds point and text layers", {

  result <- pq_data %>% create_line(metric = "Collaboration_hours", label = TRUE, return = "plot")

  # Check if the result is a ggplot object
  expect_s3_class(result, "ggplot")
  
  # Should contain geom_point and geom_text layers when label = TRUE
  layer_classes <- sapply(result$layers, function(x) class(x$geom)[1])
  expect_true("GeomPoint" %in% layer_classes)
  expect_true("GeomText" %in% layer_classes)
})