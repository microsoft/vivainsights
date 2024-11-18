# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See LICENSE.txt in the project root for license information.
# --------------------------------------------------------------------------------------------
library(testthat)
library(vivainsights)

test_that("create_tracking returns a ggplot.", {

  result <- pq_data %>%
            create_tracking(
             metric = "Collaboration_hours",
             percent = FALSE
            )

  # Check if the result is a ggplot object
  expect_s3_class(result, "ggplot")
})