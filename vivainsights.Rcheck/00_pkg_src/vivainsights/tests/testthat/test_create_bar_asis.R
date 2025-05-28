# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See LICENSE.txt in the project root for license information.
# --------------------------------------------------------------------------------------------
library(testthat)
library(vivainsights)
library(dplyr)

test_that("create_bar_asis returns a ggplot", {

  # Summarise Non-person-average median `Emails_sent`
  med_df <-
    pq_data %>%
    group_by(Organization) %>%
    summarise(Emails_sent_median = median(Emails_sent))
 
  result <- med_df %>%
            create_bar_asis(
            group_var = "Organization",
            bar_var = "Emails_sent_median",
            title = "Emails sent by organization",
            subtitle = "Median values",
            bar_colour = "darkblue",
            caption = extract_date_range(pq_data, return = "text")
            )

  # Check if the result is a ggplot object
  expect_s3_class(result, "ggplot")
})