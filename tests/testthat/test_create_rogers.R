library(testthat)
library(vivainsights)

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
