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

