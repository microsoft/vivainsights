# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See LICENSE.txt in the project root for license information.
# --------------------------------------------------------------------------------------------
library(testthat)
library(vivainsights)

test_that("create_stacked returns a data frame when return = 'table'", {

  result <- pq_data %>%
			create_stacked(hrvar = "FunctionType",
							metrics = c("Meeting_hours",
										"Email_hours",
										"Call_hours",
										"Chat_hours"),
							return = "table")

  # Check if the result is a data frame
  expect_s3_class(result, "data.frame")
})

test_that("create_stacked returns a ggplot when return = 'plot'", {

  result <- pq_data %>%
			create_stacked(hrvar = "LevelDesignation",
						   metrics = c("Meeting_hours", "Email_hours"),
						   return = "plot")

  # Check if the result is a ggplot object
  expect_s3_class(result, "ggplot")
})