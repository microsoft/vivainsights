# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See LICENSE.txt in the project root for license information.
# --------------------------------------------------------------------------------------------
library(testthat)
library(vivainsights)
library(dplyr)

test_that("create_line_asis returns a ggplot", {

  # Median `Emails_sent` grouped by `MetricDate`
  # Without Person Averaging
  med_df <-
    pq_data %>%
    group_by(MetricDate) %>%
    summarise(Emails_sent_median = median(Emails_sent))

  result <- med_df %>%
                create_line_asis(
                  date_var = "MetricDate",
                  metric = "Emails_sent_median",
                  title = "Median Emails Sent",
                  subtitle = "Person Averaging Not Applied",
                  caption = extract_date_range(pq_data, return = "text")
                )
  # Check if the result is a ggplot object
  expect_s3_class(result, "ggplot")
})

test_that("create_line_asis with label = FALSE behaves as before", {

  # Median `Emails_sent` grouped by `MetricDate`
  med_df <-
    pq_data %>%
    group_by(MetricDate) %>%
    summarise(Emails_sent_median = median(Emails_sent))

  result <- med_df %>%
                create_line_asis(
                  date_var = "MetricDate",
                  metric = "Emails_sent_median",
                  label = FALSE
                )

  # Check if the result is a ggplot object
  expect_s3_class(result, "ggplot")
  
  # Should not contain geom_point or geom_text layers (default behavior)
  layer_classes <- sapply(result$layers, function(x) class(x$geom)[1])
  expect_false("GeomPoint" %in% layer_classes)
  expect_false("GeomText" %in% layer_classes)
})

test_that("create_line_asis with label = TRUE adds point and text layers", {

  # Median `Emails_sent` grouped by `MetricDate`
  med_df <-
    pq_data %>%
    group_by(MetricDate) %>%
    summarise(Emails_sent_median = median(Emails_sent))

  result <- med_df %>%
                create_line_asis(
                  date_var = "MetricDate",
                  metric = "Emails_sent_median",
                  label = TRUE
                )

  # Check if the result is a ggplot object
  expect_s3_class(result, "ggplot")
  
  # Should contain geom_point and geom_text layers when label = TRUE
  layer_classes <- sapply(result$layers, function(x) class(x$geom)[1])
  expect_true("GeomPoint" %in% layer_classes)
  expect_true("GeomText" %in% layer_classes)
})

