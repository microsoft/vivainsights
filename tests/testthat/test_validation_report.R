# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See LICENSE.txt in the project root for license information.
# --------------------------------------------------------------------------------------------

context("Test validation_report function")

test_that("validation_report handles missing metrics", {
  
  # Create a test dataset with a missing metric
  test_data <- data.frame(
    PersonId = rep(c("person1", "person2"), each = 10),
    Date = rep(seq(as.Date("2020-01-01"), as.Date("2020-01-10"), by = "day"), 2),
    Email_hours = rnorm(20, 2, 0.5),
    Meeting_hours = rnorm(20, 3, 0.5),
    Chat_hours = rnorm(20, 1, 0.2),
    Collaboration_hours = rnorm(20, 6, 1)
    # Deliberately omitting Conflicting_meeting_hours
  )
  
  # Test that validation_report doesn't throw an error
  # We're just testing that it runs without error, not the actual output
  test_run <- try(validation_report(test_data, path = tempfile(), timestamp = FALSE), silent = TRUE)
  
  # Check that the function didn't error
  expect_false(inherits(test_run, "try-error"))
  
  # Add specific assertions for the messages that should be created for missing metrics
  result <- try(validation_report(test_data, path = tempfile(), timestamp = FALSE))
  
  # Create a test dataset with multiple missing metrics
  test_data2 <- data.frame(
    PersonId = rep(c("person1", "person2"), each = 10),
    Date = rep(seq(as.Date("2020-01-01"), as.Date("2020-01-10"), by = "day"), 2),
    Email_hours = rnorm(20, 2, 0.5),
    Meeting_hours = rnorm(20, 3, 0.5)
    # Deliberately omitting Chat_hours, Conflicting_meeting_hours, Collaboration_hours
  )
  
  # Test with multiple missing metrics
  test_run2 <- try(validation_report(test_data2, path = tempfile(), timestamp = FALSE), silent = TRUE)
  
  # Check that the function didn't error with multiple missing metrics
  expect_false(inherits(test_run2, "try-error"))
})