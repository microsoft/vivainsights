# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See LICENSE.txt in the project root for license information.
# --------------------------------------------------------------------------------------------
library(testthat)
library(vivainsights)

# Deterministic test panel: 3 people, known expected output
make_test_panel <- function() {
  data.frame(
    PersonId = c(rep("A", 5), rep("B", 4), rep("C", 3)),
    MetricDate = as.Date(c(
      "2023-01-01", "2023-02-01", "2023-03-01", "2023-04-01", "2023-05-01",
      "2023-01-01", "2023-02-01", "2023-03-01", "2023-04-01",
      "2023-01-01", "2023-02-01", "2023-03-01"
    )),
    metric = c(
      0, 0, 3, 1, 0,   # Person A: event at period 3
      0, 0, 0, 0,       # Person B: never (censored at period 4)
      5, 0, 0            # Person C: event at period 1
    ),
    Organization = c(rep("Sales", 5), rep("Finance", 4), rep("Sales", 3)),
    stringsAsFactors = FALSE
  )
}

# Basic output structure ------------------------------------------------------------------

test_that("create_survival_prep returns a data frame", {
  result <- create_survival_prep(make_test_panel(), metric = "metric")
  expect_s3_class(result, "data.frame")
})

test_that("create_survival_prep returns one row per PersonId", {
  panel <- make_test_panel()
  result <- create_survival_prep(panel, metric = "metric")
  expect_equal(nrow(result), dplyr::n_distinct(panel$PersonId))
})

test_that("create_survival_prep output has expected columns", {
  result <- create_survival_prep(make_test_panel(), metric = "metric")
  expect_true("PersonId"      %in% names(result))
  expect_true("time"          %in% names(result))
  expect_true("event"         %in% names(result))
  expect_true("Organization"  %in% names(result))
})

test_that("create_survival_prep column order is PersonId, time, event, hrvar", {
  result <- create_survival_prep(make_test_panel(), metric = "metric")
  expect_equal(names(result)[1:4], c("PersonId", "time", "event", "Organization"))
})

# Correct time values ---------------------------------------------------------------------

test_that("time equals period of first event for person who has the event", {
  result <- create_survival_prep(make_test_panel(), metric = "metric")

  # Person A: event at period 3 (rows 1,2,3 -> first TRUE at index 3)
  expect_equal(result$time[result$PersonId == "A"], 3)

  # Person C: event at period 1 (first row is already > 0)
  expect_equal(result$time[result$PersonId == "C"], 1)
})

test_that("time equals total observed periods for censored person", {
  result <- create_survival_prep(make_test_panel(), metric = "metric")

  # Person B: 4 periods, never meets condition -> censored at 4
  expect_equal(result$time[result$PersonId == "B"], 4)
})

# Correct event values --------------------------------------------------------------------

test_that("event = 1 for persons who meet the condition", {
  result <- create_survival_prep(make_test_panel(), metric = "metric")
  expect_equal(result$event[result$PersonId == "A"], 1L)
  expect_equal(result$event[result$PersonId == "C"], 1L)
})

test_that("event = 0 for censored persons", {
  result <- create_survival_prep(make_test_panel(), metric = "metric")
  expect_equal(result$event[result$PersonId == "B"], 0L)
})

test_that("event column is integer", {
  result <- create_survival_prep(make_test_panel(), metric = "metric")
  expect_type(result$event, "integer")
})

# hrvar handling --------------------------------------------------------------------------

test_that("hrvar column is the last observed value per person", {
  result <- create_survival_prep(make_test_panel(), metric = "metric")
  # All persons have a stable org in this panel, so last == only value
  expect_equal(result$Organization[result$PersonId == "A"], "Sales")
  expect_equal(result$Organization[result$PersonId == "B"], "Finance")
})

test_that("hrvar = NULL produces output without grouping column", {
  result <- create_survival_prep(make_test_panel(), metric = "metric", hrvar = NULL)
  expect_false("Organization" %in% names(result))
  expect_equal(names(result), c("PersonId", "time", "event"))
})

# Date ordering ---------------------------------------------------------------------------

test_that("periods are counted in date order regardless of row order in input", {
  # Shuffle the rows; result should be identical to sorted input
  panel <- make_test_panel()
  shuffled <- panel[sample(nrow(panel)), ]

  result_ordered  <- create_survival_prep(panel,    metric = "metric")
  result_shuffled <- create_survival_prep(shuffled, metric = "metric")

  # Align by PersonId before comparing
  result_ordered  <- result_ordered[order(result_ordered$PersonId), ]
  result_shuffled <- result_shuffled[order(result_shuffled$PersonId), ]

  expect_equal(result_ordered$time,  result_shuffled$time)
  expect_equal(result_ordered$event, result_shuffled$event)
})

# Custom event_condition ------------------------------------------------------------------

test_that("custom event_condition is applied correctly", {
  panel <- make_test_panel()

  # Use a higher threshold: event only when metric > 2
  # Person A: values 0,0,3,1,0 -> first > 2 at period 3, same as default
  # Person C: values 5,0,0     -> first > 2 at period 1, same as default
  result_gt2 <- create_survival_prep(panel, metric = "metric",
                                     event_condition = function(x) x > 2)
  expect_equal(result_gt2$time[result_gt2$PersonId == "A"], 3)

  # With threshold > 3: Person A's value of 3 no longer qualifies;
  # only period 4 (value 1) also doesn't qualify -> Person A now censored
  result_gt3 <- create_survival_prep(panel, metric = "metric",
                                     event_condition = function(x) x > 3)
  expect_equal(result_gt3$event[result_gt3$PersonId == "A"], 0L)
  expect_equal(result_gt3$time[result_gt3$PersonId == "A"], 5)  # full 5 periods
})

# Integration with pq_data ----------------------------------------------------------------

test_that("create_survival_prep works with pq_data and returns one row per PersonId", {
  result <- create_survival_prep(
    data = pq_data,
    metric = "Copilot_actions_taken_in_Teams"
  )

  expect_s3_class(result, "data.frame")
  expect_equal(nrow(result), dplyr::n_distinct(pq_data$PersonId))
})

test_that("create_survival_prep output from pq_data has valid time and event values", {
  result <- create_survival_prep(
    data = pq_data,
    metric = "Copilot_actions_taken_in_Teams"
  )

  expect_true(all(result$time >= 1))
  expect_true(all(result$event %in% c(0L, 1L)))
})

test_that("create_survival_prep output can be passed directly to create_survival", {
  surv_data <- create_survival_prep(
    data = pq_data,
    metric = "Copilot_actions_taken_in_Teams"
  )

  result <- create_survival(
    data = surv_data,
    time_col = "time",
    event_col = "event",
    hrvar = "Organization",
    mingroup = 1,
    return = "plot"
  )

  expect_s3_class(result, "ggplot")
})

# Error handling --------------------------------------------------------------------------

test_that("create_survival_prep errors when metric column is missing", {
  expect_error(
    create_survival_prep(make_test_panel(), metric = "NonExistent"),
    "not included in the input data frame"
  )
})

test_that("create_survival_prep errors when hrvar column is missing", {
  expect_error(
    create_survival_prep(make_test_panel(), metric = "metric", hrvar = "NonExistent"),
    "not included in the input data frame"
  )
})

test_that("create_survival_prep errors when event_condition is not a function", {
  expect_error(
    create_survival_prep(make_test_panel(), metric = "metric",
                         event_condition = 0),
    "`event_condition` must be a function"
  )
})

test_that("create_survival_prep errors when event_condition returns non-logical", {
  expect_error(
    create_survival_prep(make_test_panel(), metric = "metric",
                         event_condition = function(x) as.character(x > 0)),
    "`event_condition` must return a logical vector"
  )
})
