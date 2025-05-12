library(testthat)
library(vivainsights)

test_that("create_itsa returns a data frame when return = 'table'", {
  result <- create_itsa(
    data = pq_data,
    metrics = c("Collaboration_hours", "Meeting_hours"),
    before_end = "2024-06-30",
    return = "table"
  )
  # Check if the result is a data frame
  expect_s3_class(result, "data.frame")
})

# test_that("create_itsa returns a list of plots when return = 'plot'", {
#   result <- create_itsa(
#     data = pq_data,
#     metrics = c("Collaboration_hours", "Meeting_hours"),
#     before_end = "2024-06-30",
#     return = "plot"
#   )
#   # Check if the result is a list
#   expect_true(is.list(result))
#   # Check if the first element in the list is a ggplot object
#   expect_s3_class(result[[1]], "ggplot")
# })

test_that("create_itsa raises an error when before_end is NULL", {
  expect_error(
    create_itsa(
      data = pq_data,
      metrics = c("Collaboration_hours", "Meeting_hours"),
      before_end = NULL,
      return = "table"
    ),
    "The 'before_end' parameter must be provided."
  )
})

test_that("create_itsa returns a data frame with correct columns", {
  result <- create_itsa(
    data = pq_data,
    metrics = c("Collaboration_hours", "Meeting_hours"),
    before_end = "2024-06-30",
    return = "table"
  )
  # Check if the result contains expected columns
  expect_true(all(c("metric_name", "beta_2", "beta_3", "beta_2_pvalue", "beta_3_pvalue", "AR_flag", "error_warning") %in% colnames(result)))
})
