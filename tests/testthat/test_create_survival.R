# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See LICENSE.txt in the project root for license information.
# --------------------------------------------------------------------------------------------
library(testthat)
library(vivainsights)

# Basic functionality tests ---------------------------------------------------------------

test_that("create_survival returns a ggplot when return = 'plot'", {
  
  test_data <- data.frame(
    PersonId = 1:50,
    time = runif(50, 1, 100),
    event = sample(0:1, 50, replace = TRUE),
    group = sample(c("A", "B"), 50, replace = TRUE)
  )
  
  result <- create_survival(
    data = test_data,
    time_col = "time",
    event_col = "event",
    group_col = "group",
    mingroup = 1,
    return = "plot"
  )
  
  expect_s3_class(result, "ggplot")
})

test_that("create_survival returns a data frame when return = 'table'", {
  
  test_data <- data.frame(
    PersonId = 1:50,
    time = runif(50, 1, 100),
    event = sample(0:1, 50, replace = TRUE),
    group = sample(c("A", "B"), 50, replace = TRUE)
  )
  
  result <- create_survival(
    data = test_data,
    time_col = "time",
    event_col = "event",
    group_col = "group",
    mingroup = 1,
    return = "table"
  )
  
  expect_s3_class(result, "data.frame")
  
  # Check expected columns
  expect_true("time" %in% names(result))
  expect_true("survival" %in% names(result))
  expect_true("at_risk" %in% names(result))
  expect_true("events" %in% names(result))
  expect_true("n" %in% names(result))
})

test_that("create_survival works with overall curve (no grouping)", {
  
  test_data <- data.frame(
    PersonId = 1:30,
    time = runif(30, 1, 50),
    event = sample(0:1, 30, replace = TRUE)
  )
  
  result <- create_survival(
    data = test_data,
    time_col = "time",
    event_col = "event",
    group_col = NULL,
    mingroup = 1,
    return = "table"
  )
  
  expect_s3_class(result, "data.frame")
  expect_true("group" %in% names(result))
  expect_equal(unique(result$group), "Overall")
})

# Event coercion tests --------------------------------------------------------------------

test_that("create_survival handles logical event column", {
  
  test_data <- data.frame(
    PersonId = 1:20,
    time = 1:20,
    event = sample(c(TRUE, FALSE), 20, replace = TRUE),
    group = "A"
  )
  
  result <- create_survival(
    data = test_data,
    time_col = "time",
    event_col = "event",
    group_col = "group",
    mingroup = 1,
    return = "table"
  )
  
  expect_s3_class(result, "data.frame")
  expect_true(nrow(result) > 0)
})

test_that("create_survival handles numeric 0/1 event column", {
  
  test_data <- data.frame(
    PersonId = 1:20,
    time = 1:20,
    event = sample(0:1, 20, replace = TRUE),
    group = "A"
  )
  
  result <- create_survival(
    data = test_data,
    time_col = "time",
    event_col = "event",
    group_col = "group",
    mingroup = 1,
    return = "table"
  )
  
  expect_s3_class(result, "data.frame")
  expect_true(nrow(result) > 0)
})

test_that("create_survival handles positive numeric event column", {
  
  test_data <- data.frame(
    PersonId = 1:20,
    time = 1:20,
    event = sample(c(0, 2, 5), 20, replace = TRUE),
    group = "A"
  )
  
  result <- create_survival(
    data = test_data,
    time_col = "time",
    event_col = "event",
    group_col = "group",
    mingroup = 1,
    return = "table"
  )
  
  expect_s3_class(result, "data.frame")
  expect_true(nrow(result) > 0)
})

test_that("create_survival handles character event column", {
  
  test_data <- data.frame(
    PersonId = 1:20,
    time = 1:20,
    event = sample(c("yes", "no"), 20, replace = TRUE),
    group = "A"
  )
  
  result <- create_survival(
    data = test_data,
    time_col = "time",
    event_col = "event",
    group_col = "group",
    mingroup = 1,
    return = "table"
  )
  
  expect_s3_class(result, "data.frame")
  expect_true(nrow(result) > 0)
})

test_that("create_survival handles mixed character formats", {
  
  test_data <- data.frame(
    PersonId = 1:20,
    time = 1:20,
    event = c(rep("true", 5), rep("false", 5), rep("1", 5), rep("0", 5)),
    group = "A"
  )
  
  result <- create_survival(
    data = test_data,
    time_col = "time",
    event_col = "event",
    group_col = "group",
    mingroup = 1,
    return = "table"
  )
  
  expect_s3_class(result, "data.frame")
  expect_true(nrow(result) > 0)
})

# Privacy filtering tests -----------------------------------------------------------------

test_that("create_survival respects mingroup threshold", {
  
  test_data <- data.frame(
    PersonId = 1:15,
    time = 1:15,
    event = sample(0:1, 15, replace = TRUE),
    group = c(rep("A", 3), rep("B", 12))  # A has only 3, B has 12
  )
  
  result <- create_survival(
    data = test_data,
    time_col = "time",
    event_col = "event",
    group_col = "group",
    mingroup = 5,
    return = "table"
  )
  
  # Only group B should pass threshold
  expect_true(all(result$group == "B"))
  expect_false("A" %in% result$group)
})

test_that("create_survival returns empty table when no groups meet mingroup", {
  
  test_data <- data.frame(
    PersonId = 1:8,
    time = 1:8,
    event = sample(0:1, 8, replace = TRUE),
    group = c(rep("A", 4), rep("B", 4))
  )
  
  result <- create_survival(
    data = test_data,
    time_col = "time",
    event_col = "event",
    group_col = "group",
    mingroup = 10,
    return = "table"
  )
  
  expect_equal(nrow(result), 0)
})

# Edge cases and Kaplan-Meier calculation -------------------------------------------------

test_that("create_survival handles all events scenario", {
  
  test_data <- data.frame(
    PersonId = 1:10,
    time = 1:10,
    event = rep(1, 10),  # All have events
    group = "A"
  )
  
  result <- create_survival(
    data = test_data,
    time_col = "time",
    event_col = "event",
    group_col = "group",
    mingroup = 1,
    return = "table"
  )
  
  expect_s3_class(result, "data.frame")
  
  # Survival should decrease to 0
  expect_equal(min(result$survival), 0)
})

test_that("create_survival handles no events scenario", {
  
  test_data <- data.frame(
    PersonId = 1:10,
    time = 1:10,
    event = rep(0, 10),  # No events
    group = "A"
  )
  
  result <- create_survival(
    data = test_data,
    time_col = "time",
    event_col = "event",
    group_col = "group",
    mingroup = 1,
    return = "table"
  )
  
  expect_s3_class(result, "data.frame")
  
  # Survival should remain at 1
  expect_true(all(result$survival == 1))
})

test_that("create_survival survival probabilities are between 0 and 1", {
  
  test_data <- data.frame(
    PersonId = 1:50,
    time = runif(50, 1, 100),
    event = sample(0:1, 50, replace = TRUE),
    group = "A"
  )
  
  result <- create_survival(
    data = test_data,
    time_col = "time",
    event_col = "event",
    group_col = "group",
    mingroup = 1,
    return = "table"
  )
  
  expect_true(all(result$survival >= 0 & result$survival <= 1))
})

test_that("create_survival survival is non-increasing", {
  
  test_data <- data.frame(
    PersonId = 1:30,
    time = 1:30,
    event = sample(0:1, 30, replace = TRUE),
    group = "A"
  )
  
  result <- create_survival(
    data = test_data,
    time_col = "time",
    event_col = "event",
    group_col = "group",
    mingroup = 1,
    return = "table"
  )
  
  # Survival should be non-increasing
  diffs <- diff(result$survival)
  expect_true(all(diffs <= 0))
})

test_that("create_survival at_risk is non-increasing", {
  
  test_data <- data.frame(
    PersonId = 1:30,
    time = 1:30,
    event = sample(0:1, 30, replace = TRUE),
    group = "A"
  )
  
  result <- create_survival(
    data = test_data,
    time_col = "time",
    event_col = "event",
    group_col = "group",
    mingroup = 1,
    return = "table"
  )
  
  # At risk should be non-increasing
  diffs <- diff(result$at_risk)
  expect_true(all(diffs <= 0))
})

# dropna parameter tests ------------------------------------------------------------------

test_that("create_survival with dropna = TRUE removes NA rows", {
  
  test_data <- data.frame(
    PersonId = 1:20,
    time = c(1:15, rep(NA, 5)),
    event = c(rep(1, 10), rep(0, 10)),
    group = "A"
  )
  
  # Should not error with dropna = TRUE
  expect_silent(
    result <- create_survival(
      data = test_data,
      time_col = "time",
      event_col = "event",
      group_col = "group",
      mingroup = 1,
      dropna = TRUE,
      return = "table"
    )
  )
  
  expect_s3_class(result, "data.frame")
})

test_that("create_survival with dropna = FALSE keeps NA rows (but they get filtered in coercion)", {
  
  test_data <- data.frame(
    PersonId = 1:20,
    time = c(1:15, rep(NA, 5)),
    event = c(rep(1, 10), rep(0, 10)),
    group = "A"
  )
  
  # With dropna = FALSE, NAs still get filtered in coercion step
  expect_warning(
    result <- create_survival(
      data = test_data,
      time_col = "time",
      event_col = "event",
      group_col = "group",
      mingroup = 1,
      dropna = FALSE,
      return = "table"
    ),
    "row\\(s\\) dropped"
  )
  
  expect_s3_class(result, "data.frame")
})

# Warning tests ---------------------------------------------------------------------------

test_that("create_survival warns when coercion drops rows", {
  
  test_data <- data.frame(
    PersonId = 1:20,
    time = c(1:15, "invalid", "bad", "text", "here", "!"),
    event = rep(1, 20),
    group = "A"
  )
  
  expect_warning(
    result <- create_survival(
      data = test_data,
      time_col = "time",
      event_col = "event",
      group_col = "group",
      mingroup = 1,
      return = "table"
    ),
    "row\\(s\\) dropped due to NA values"
  )
})

test_that("create_survival warns with correct count of dropped rows", {
  
  test_data <- data.frame(
    PersonId = 1:25,
    time = c(1:20, rep(NA, 5)),
    event = rep(1, 25),
    group = "A"
  )
  
  expect_warning(
    result <- create_survival(
      data = test_data,
      time_col = "time",
      event_col = "event",
      group_col = "group",
      mingroup = 1,
      dropna = FALSE,  # Need dropna = FALSE to trigger coercion warning
      return = "table"
    ),
    "5 row\\(s\\) dropped"
  )
})

# Error handling tests --------------------------------------------------------------------

test_that("create_survival errors on missing time_col", {
  
  test_data <- data.frame(
    PersonId = 1:10,
    time = 1:10,
    event = sample(0:1, 10, replace = TRUE),
    group = "A"
  )
  
  expect_error(
    create_survival(
      data = test_data,
      time_col = "NonExistent",
      event_col = "event",
      group_col = "group",
      mingroup = 1
    ),
    "not included in the input data frame"
  )
})

test_that("create_survival errors on missing event_col", {
  
  test_data <- data.frame(
    PersonId = 1:10,
    time = 1:10,
    event = sample(0:1, 10, replace = TRUE),
    group = "A"
  )
  
  expect_error(
    create_survival(
      data = test_data,
      time_col = "time",
      event_col = "NonExistent",
      group_col = "group",
      mingroup = 1
    ),
    "not included in the input data frame"
  )
})

test_that("create_survival errors on missing group_col", {
  
  test_data <- data.frame(
    PersonId = 1:10,
    time = 1:10,
    event = sample(0:1, 10, replace = TRUE),
    group = "A"
  )
  
  expect_error(
    create_survival(
      data = test_data,
      time_col = "time",
      event_col = "event",
      group_col = "NonExistent",
      mingroup = 1
    ),
    "not included in the input data frame|not found in data"
  )
})

test_that("create_survival errors on invalid mingroup", {
  
  test_data <- data.frame(
    PersonId = 1:10,
    time = 1:10,
    event = sample(0:1, 10, replace = TRUE),
    group = "A"
  )
  
  expect_error(
    create_survival(
      data = test_data,
      time_col = "time",
      event_col = "event",
      group_col = "group",
      mingroup = -1
    ),
    "valid input for `mingroup`"
  )
})

test_that("create_survival errors on invalid dropna", {
  
  test_data <- data.frame(
    PersonId = 1:10,
    time = 1:10,
    event = sample(0:1, 10, replace = TRUE),
    group = "A"
  )
  
  expect_error(
    create_survival(
      data = test_data,
      time_col = "time",
      event_col = "event",
      group_col = "group",
      mingroup = 1,
      dropna = "yes"
    ),
    "valid input for `dropna`"
  )
})

test_that("create_survival errors on invalid return", {
  
  test_data <- data.frame(
    PersonId = 1:10,
    time = 1:10,
    event = sample(0:1, 10, replace = TRUE),
    group = "A"
  )
  
  expect_error(
    create_survival(
      data = test_data,
      time_col = "time",
      event_col = "event",
      group_col = "group",
      mingroup = 1,
      return = "invalid"
    ),
    "valid input for `return`"
  )
})

# Helper function tests -------------------------------------------------------------------

test_that("create_survival_calc returns list with correct structure", {
  
  test_data <- data.frame(
    PersonId = 1:30,
    time = runif(30, 1, 50),
    event = sample(0:1, 30, replace = TRUE),
    group = sample(c("A", "B"), 30, replace = TRUE)
  )
  
  result <- create_survival_calc(
    data = test_data,
    time_col = "time",
    event_col = "event",
    group_col = "group",
    mingroup = 1
  )
  
  expect_type(result, "list")
  expect_true("table" %in% names(result))
  expect_true("counts" %in% names(result))
  expect_s3_class(result$table, "data.frame")
  expect_s3_class(result$counts, "data.frame")
})

test_that("create_survival_viz returns ggplot", {
  
  test_data <- data.frame(
    PersonId = 1:30,
    time = runif(30, 1, 50),
    event = sample(0:1, 30, replace = TRUE),
    group = "A"
  )
  
  calc_result <- create_survival_calc(
    data = test_data,
    time_col = "time",
    event_col = "event",
    group_col = "group",
    mingroup = 1
  )
  
  viz_result <- create_survival_viz(
    data = calc_result$table,
    group_col = "group"
  )
  
  expect_s3_class(viz_result, "ggplot")
})

# Multiple groups test --------------------------------------------------------------------

test_that("create_survival works with multiple groups", {
  
  test_data <- data.frame(
    PersonId = 1:60,
    time = runif(60, 1, 100),
    event = sample(0:1, 60, replace = TRUE),
    group = rep(c("A", "B", "C"), each = 20)
  )
  
  result <- create_survival(
    data = test_data,
    time_col = "time",
    event_col = "event",
    group_col = "group",
    mingroup = 5,
    return = "table"
  )
  
  expect_s3_class(result, "data.frame")
  expect_equal(length(unique(result$group)), 3)
})
