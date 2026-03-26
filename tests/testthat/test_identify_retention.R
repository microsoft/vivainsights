# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See LICENSE.txt in the project root for license information.
# --------------------------------------------------------------------------------------------

library(testthat)
library(vivainsights)

skip_if_not_installed("dplyr")
skip_if_not_installed("tibble")

library(dplyr)
library(tibble)

# Helper: create simple person-level time series data with a categorical column
make_retention_data <- function() {
  data.frame(
    PersonId = c(
      "A", "A", "A",
      "B", "B", "B",
      "C", "C", "C"
    ),
    MetricDate = as.Date(c(
      "2024-01-01", "2024-02-01", "2024-03-01",
      "2024-01-01", "2024-02-01", "2024-03-01",
      "2024-01-01", "2024-02-01", "2024-03-01"
    )),
    Segment = c(
      "Power User", "Power User", "Power User",   # A stays Power User
      "Power User", "Low User",   "Low User",     # B drops out
      "Low User",   "Low User",   "Power User"    # C is not in X set
    ),
    stringsAsFactors = FALSE
  )
}

test_that("identify_retention returns summary tibble by default", {
  df <- make_retention_data()
  result <- identify_retention(
    data             = df,
    start_x          = "2024-01-01",
    end_x            = "2024-02-01",
    start_y          = "2024-02-01",
    end_y            = "2024-04-01",
    category         = "Segment",
    category_values  = c("Power User")
  )

  expect_s3_class(result, "data.frame")
  expect_true("RetentionPct" %in% names(result))
  expect_equal(result$N_Original, 2L)  # A and B are Power Users in Jan
  expect_equal(result$N_Tracked,  2L)  # Both appear in period Y
  expect_equal(result$N_Retained, 1L)  # Only A stays Power User
  expect_equal(result$RetentionPct, 50)
})

test_that("identify_retention return = 'data' gives a list with three elements", {
  df <- make_retention_data()
  result <- identify_retention(
    data             = df,
    start_x          = "2024-01-01",
    end_x            = "2024-02-01",
    start_y          = "2024-02-01",
    end_y            = "2024-04-01",
    category         = "Segment",
    category_values  = c("Power User"),
    return           = "data"
  )

  expect_type(result, "list")
  expect_named(result, c("summary", "person_status", "breakdown"))
  expect_s3_class(result$summary, "data.frame")
  expect_s3_class(result$person_status, "data.frame")
  expect_s3_class(result$breakdown, "data.frame")
  expect_true("StillPositive" %in% names(result$person_status))
})

test_that("identify_retention return = 'message' prints and returns invisibly", {
  df <- make_retention_data()
  expect_message(
    result <- identify_retention(
      data             = df,
      start_x          = "2024-01-01",
      end_x            = "2024-02-01",
      start_y          = "2024-02-01",
      end_y            = "2024-04-01",
      category         = "Segment",
      category_values  = c("Power User"),
      return           = "message"
    ),
    "RETENTION ANALYSIS"
  )
  # The returned object should still be the summary tibble
  expect_s3_class(result, "data.frame")
  expect_true("RetentionPct" %in% names(result))
})

test_that("identify_retention errors on invalid return value", {
  df <- make_retention_data()
  expect_error(
    identify_retention(
      data             = df,
      start_x          = "2024-01-01",
      end_x            = "2024-02-01",
      start_y          = "2024-02-01",
      end_y            = "2024-04-01",
      category         = "Segment",
      category_values  = c("Power User"),
      return           = "invalid"
    ),
    "`return` must be one of"
  )
})

test_that("identify_retention errors when required columns are missing", {
  df <- make_retention_data()
  df$PersonId <- NULL
  expect_error(
    identify_retention(
      data             = df,
      start_x          = "2024-01-01",
      end_x            = "2024-02-01",
      start_y          = "2024-02-01",
      category         = "Segment",
      category_values  = c("Power User")
    ),
    "Missing required columns"
  )
})

test_that("identify_retention errors when data is not a data frame", {
  expect_error(
    identify_retention(
      data             = list(a = 1),
      start_x          = "2024-01-01",
      end_x            = "2024-02-01",
      start_y          = "2024-02-01",
      category         = "Segment",
      category_values  = c("Power User")
    ),
    "`data` must be a data frame"
  )
})

test_that("identify_retention warns and returns NULL when no individuals in period X", {
  df <- make_retention_data()
  expect_warning(
    result <- identify_retention(
      data             = df,
      start_x          = "2024-01-01",
      end_x            = "2024-02-01",
      start_y          = "2024-02-01",
      end_y            = "2024-04-01",
      category         = "Segment",
      category_values  = c("Non-existent Segment")
    ),
    "No individuals found"
  )
  expect_null(result)
})

test_that("identify_retention works with NULL end_y (open-ended period Y)", {
  df <- make_retention_data()
  result <- identify_retention(
    data             = df,
    start_x          = "2024-01-01",
    end_x            = "2024-02-01",
    start_y          = "2024-02-01",
    end_y            = NULL,
    category         = "Segment",
    category_values  = c("Power User")
  )

  expect_s3_class(result, "data.frame")
  expect_true(!is.na(result$PeriodY_End))
})

test_that("identify_retention handles binary category_values = TRUE", {
  df <- data.frame(
    PersonId   = c("A", "A", "B", "B"),
    MetricDate = as.Date(c("2024-01-01", "2024-03-01",
                           "2024-01-01", "2024-03-01")),
    IsActive   = c(TRUE, TRUE, TRUE, FALSE),
    stringsAsFactors = FALSE
  )
  result <- identify_retention(
    data            = df,
    start_x         = "2024-01-01",
    end_x           = "2024-02-01",
    start_y         = "2024-02-01",
    end_y           = "2024-04-01",
    category        = "IsActive",
    category_values = TRUE
  )

  expect_s3_class(result, "data.frame")
  expect_equal(result$N_Original, 2L)
  expect_equal(result$N_Retained, 1L)
})
