# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See LICENSE.txt in the project root for license information.
# --------------------------------------------------------------------------------------------
library(testthat)
library(vivainsights)

# Basic functionality tests ---------------------------------------------------------------

test_that("create_radar returns a ggplot when return = 'plot'", {

  result <- create_radar(
    data = pq_data,
    metrics = c("Collaboration_hours", "Email_hours", "Meeting_hours"),
    hrvar = "Organization",
    mingroup = 1,
    return = "plot"
  )

  expect_s3_class(result, "ggplot")
})

test_that("create_radar returns a data frame when return = 'table'", {

  result <- create_radar(
    data = pq_data,
    metrics = c("Collaboration_hours", "Email_hours", "Meeting_hours"),
    hrvar = "Organization",
    mingroup = 1,
    return = "table"
  )

  expect_s3_class(result, "data.frame")

  # Check that expected columns are present
  expect_true("Organization" %in% names(result))
  expect_true("Collaboration_hours" %in% names(result))
  expect_true("Email_hours" %in% names(result))
  expect_true("Meeting_hours" %in% names(result))
  expect_true("n" %in% names(result))
})

# Indexing mode tests ---------------------------------------------------------------------

test_that("create_radar works with index_mode = 'total'", {

  result <- create_radar(
    data = pq_data,
    metrics = c("Collaboration_hours", "Email_hours"),
    hrvar = "Organization",
    mingroup = 1,
    index_mode = "total",
    return = "table"
  )

  expect_s3_class(result, "data.frame")
  expect_true(all(!is.na(result$Collaboration_hours)))
  expect_true(all(!is.na(result$Email_hours)))
})

test_that("create_radar works with index_mode = 'none'", {

  result <- create_radar(
    data = pq_data,
    metrics = c("Collaboration_hours", "Email_hours"),
    hrvar = "Organization",
    mingroup = 1,
    index_mode = "none",
    return = "table"
  )

  expect_s3_class(result, "data.frame")

  # Raw values should be different from indexed values
  result_indexed <- create_radar(
    data = pq_data,
    metrics = c("Collaboration_hours", "Email_hours"),
    hrvar = "Organization",
    mingroup = 1,
    index_mode = "total",
    return = "table"
  )

  # Values should differ (unless by coincidence all groups are exactly average)
  expect_false(identical(result$Collaboration_hours, result_indexed$Collaboration_hours))
})

test_that("create_radar works with index_mode = 'ref_group'", {

  result <- create_radar(
    data = pq_data,
    metrics = c("Collaboration_hours", "Email_hours"),
    hrvar = "Organization",
    mingroup = 1,
    index_mode = "ref_group",
    index_ref_group = "Finance",
    return = "table"
  )

  expect_s3_class(result, "data.frame")

  # Reference group should be indexed to 100
  ref_row <- result[result$Organization == "Finance", ]
  expect_equal(ref_row$Collaboration_hours, 100, tolerance = 0.01)
  expect_equal(ref_row$Email_hours, 100, tolerance = 0.01)
})

test_that("create_radar works with index_mode = 'minmax'", {

  result <- create_radar(
    data = pq_data,
    metrics = c("Collaboration_hours", "Email_hours"),
    hrvar = "Organization",
    mingroup = 1,
    index_mode = "minmax",
    return = "table"
  )

  expect_s3_class(result, "data.frame")

  # Check that values are scaled to [0, 100]
  expect_true(all(result$Collaboration_hours >= 0 & result$Collaboration_hours <= 100))
  expect_true(all(result$Email_hours >= 0 & result$Email_hours <= 100))

  # Min should be near 0 and max should be near 100 for each metric
  expect_true(min(result$Collaboration_hours) < 5)
  expect_true(max(result$Collaboration_hours) > 95)
})

# Aggregation method tests ----------------------------------------------------------------

test_that("create_radar works with agg = 'median'", {

  result <- create_radar(
    data = pq_data,
    metrics = c("Collaboration_hours", "Email_hours"),
    hrvar = "Organization",
    mingroup = 1,
    agg = "median",
    return = "table"
  )

  expect_s3_class(result, "data.frame")
})

test_that("create_radar gives different results for mean vs median", {

  result_mean <- create_radar(
    data = pq_data,
    metrics = c("Collaboration_hours", "Email_hours"),
    hrvar = "Organization",
    mingroup = 1,
    agg = "mean",
    index_mode = "none",
    return = "table"
  )

  result_median <- create_radar(
    data = pq_data,
    metrics = c("Collaboration_hours", "Email_hours"),
    hrvar = "Organization",
    mingroup = 1,
    agg = "median",
    index_mode = "none",
    return = "table"
  )

  # Mean and median should generally differ
  expect_false(identical(result_mean$Collaboration_hours, result_median$Collaboration_hours))
})

# Privacy filtering tests -----------------------------------------------------------------

test_that("create_radar respects mingroup threshold", {

  # Create a small test dataset with groups below threshold
  small_data <- pq_data[1:20, ]
  small_data$SmallGroup <- rep(c("A", "B", "C", "D"), each = 5)

  result <- create_radar(
    data = small_data,
    metrics = c("Collaboration_hours", "Email_hours"),
    hrvar = "SmallGroup",
    mingroup = 10,
    return = "table"
  )

  # No groups should pass the threshold
  expect_equal(nrow(result), 0)
})

test_that("create_radar includes groups meeting mingroup", {

  result <- create_radar(
    data = pq_data,
    metrics = c("Collaboration_hours", "Email_hours"),
    hrvar = "Organization",
    mingroup = 5,
    return = "table"
  )

  # All groups should have n >= mingroup
  expect_true(all(result$n >= 5))
})

# Edge cases and error handling -----------------------------------------------------------

test_that("create_radar handles single metric", {

  expect_warning(
    result <- create_radar(
      data = pq_data,
      metrics = c("Collaboration_hours"),
      hrvar = "Organization",
      mingroup = 1,
      return = "plot"
    ),
    "Radar charts work best with 3 or more metrics"
  )

  expect_s3_class(result, "ggplot")
})

test_that("create_radar handles two metrics with warning", {

  expect_warning(
    result <- create_radar(
      data = pq_data,
      metrics = c("Collaboration_hours", "Email_hours"),
      hrvar = "Organization",
      mingroup = 1,
      return = "plot"
    ),
    "Radar charts work best with 3 or more metrics"
  )

  expect_s3_class(result, "ggplot")
})

test_that("create_radar handles na.rm = TRUE", {

  result <- create_radar(
    data = pq_data,
    metrics = c("Collaboration_hours", "Email_hours"),
    hrvar = "Organization",
    mingroup = 1,
    na.rm = TRUE,
    return = "table"
  )

  expect_s3_class(result, "data.frame")
})

test_that("create_radar errors on empty metrics", {

  expect_error(
    create_radar(
      data = pq_data,
      metrics = c(),
      hrvar = "Organization",
      mingroup = 1
    ),
    "valid input for `metrics`"
  )
})

test_that("create_radar errors on missing metrics columns", {

  expect_error(
    create_radar(
      data = pq_data,
      metrics = c("NonExistentColumn"),
      hrvar = "Organization",
      mingroup = 1
    ),
    "not included in the input data frame"
  )
})

test_that("create_radar errors on invalid agg parameter", {

  expect_error(
    create_radar(
      data = pq_data,
      metrics = c("Collaboration_hours", "Email_hours"),
      hrvar = "Organization",
      mingroup = 1,
      agg = "mode"
    ),
    "valid input for `agg`"
  )
})

test_that("create_radar errors on invalid index_mode", {

  expect_error(
    create_radar(
      data = pq_data,
      metrics = c("Collaboration_hours", "Email_hours"),
      hrvar = "Organization",
      mingroup = 1,
      index_mode = "invalid"
    ),
    "valid input for `index_mode`"
  )
})

test_that("create_radar errors on ref_group mode without ref group specified", {

  expect_error(
    create_radar(
      data = pq_data,
      metrics = c("Collaboration_hours", "Email_hours"),
      hrvar = "Organization",
      mingroup = 1,
      index_mode = "ref_group"
    ),
    "index_ref_group"
  )
})

test_that("create_radar errors on invalid ref group", {

  expect_error(
    create_radar(
      data = pq_data,
      metrics = c("Collaboration_hours", "Email_hours"),
      hrvar = "Organization",
      mingroup = 1,
      index_mode = "ref_group",
      index_ref_group = "NonExistentGroup"
    ),
    "not found in `hrvar`"
  )
})

test_that("create_radar errors on invalid return value", {

  expect_error(
    create_radar(
      data = pq_data,
      metrics = c("Collaboration_hours", "Email_hours"),
      hrvar = "Organization",
      mingroup = 1,
      return = "invalid"
    ),
    "valid input for `return`"
  )
})

test_that("create_radar errors on invalid mingroup", {

  expect_error(
    create_radar(
      data = pq_data,
      metrics = c("Collaboration_hours", "Email_hours"),
      hrvar = "Organization",
      mingroup = -1
    ),
    "valid input for `mingroup`"
  )
})

test_that("create_radar errors on invalid na.rm", {

  expect_error(
    create_radar(
      data = pq_data,
      metrics = c("Collaboration_hours", "Email_hours"),
      hrvar = "Organization",
      mingroup = 1,
      na.rm = "yes"
    ),
    "valid input for `na.rm`"
  )
})

# Helper function tests -------------------------------------------------------------------

test_that("create_radar_calc returns list with correct structure", {

  result <- create_radar_calc(
    data = pq_data,
    metrics = c("Collaboration_hours", "Email_hours"),
    hrvar = "Organization",
    mingroup = 1
  )

  expect_type(result, "list")
  expect_true("table" %in% names(result))
  expect_true("ref" %in% names(result))
  expect_s3_class(result$table, "data.frame")
})

test_that("create_radar_viz returns ggplot", {

  calc_result <- create_radar_calc(
    data = pq_data,
    metrics = c("Collaboration_hours", "Email_hours", "Meeting_hours"),
    hrvar = "Organization",
    mingroup = 1
  )

  viz_result <- create_radar_viz(
    data = calc_result$table,
    metrics = c("Collaboration_hours", "Email_hours", "Meeting_hours"),
    hrvar = "Organization"
  )

  expect_s3_class(viz_result, "ggplot")
})

# Multiple metrics test -------------------------------------------------------------------

test_that("create_radar works with many metrics", {

  result <- create_radar(
    data = pq_data,
    metrics = c("Collaboration_hours", "Email_hours", "Meeting_hours",
                "After_hours_collaboration_hours", "Internal_network_size"),
    hrvar = "Organization",
    mingroup = 1,
    return = "plot"
  )

  expect_s3_class(result, "ggplot")
})

# Zero denominator handling tests ---------------------------------------------------------

test_that("create_radar handles zero denominator in 'total' mode with warning", {

  test_data <- pq_data
  test_data[["Zero_Metric"]] <- 0

  expect_warning(
    result <- create_radar(
      data = test_data,
      metrics = c("Collaboration_hours", "Zero_Metric"),
      hrvar = "Organization",
      mingroup = 1,
      index_mode = "total",
      return = "table"
    ),
    "zero or NA reference values"
  )

  # Check that zero metric is set to 100 (neutral baseline)
  expect_true(all(result$Zero_Metric == 100, na.rm = TRUE))

  # Check that other metric is still indexed normally
  expect_true(any(result$Collaboration_hours != 100))

  # Check no NaN values
  expect_false(any(is.nan(result$Zero_Metric)))
})

test_that("create_radar handles zero denominator in 'ref_group' mode with warning", {

  test_data <- pq_data
  test_data[["Zero_Metric"]] <- 0

  expect_warning(
    result <- create_radar(
      data = test_data,
      metrics = c("Collaboration_hours", "Zero_Metric"),
      hrvar = "Organization",
      mingroup = 1,
      index_mode = "ref_group",
      index_ref_group = "Finance",
      return = "table"
    ),
    "zero or NA values in reference group"
  )

  # Check that zero metric is set to 100 (neutral baseline)
  expect_true(all(result$Zero_Metric == 100, na.rm = TRUE))

  # Check no NaN values
  expect_false(any(is.nan(result$Zero_Metric)))
})

test_that("create_radar handles multiple zero metrics", {

  test_data <- pq_data
  test_data[["Zero_Metric_1"]] <- 0
  test_data[["Zero_Metric_2"]] <- 0

  expect_warning(
    result <- create_radar(
      data = test_data,
      metrics = c("Collaboration_hours", "Zero_Metric_1", "Zero_Metric_2"),
      hrvar = "Organization",
      mingroup = 1,
      index_mode = "total",
      return = "table"
    ),
    "Zero_Metric_1, Zero_Metric_2"
  )

  # Both zero metrics should be set to 100
  expect_true(all(result$Zero_Metric_1 == 100, na.rm = TRUE))
  expect_true(all(result$Zero_Metric_2 == 100, na.rm = TRUE))
})

test_that("create_radar handles NA denominator gracefully", {

  test_data <- pq_data
  test_data[["NA_Metric"]] <- NA_real_

  expect_warning(
    result <- create_radar(
      data = test_data,
      metrics = c("Collaboration_hours", "NA_Metric"),
      hrvar = "Organization",
      mingroup = 1,
      index_mode = "total",
      return = "table"
    ),
    "zero or NA reference values"
  )

  # NA metric should be set to 100
  expect_true(all(result$NA_Metric == 100, na.rm = TRUE))
})
