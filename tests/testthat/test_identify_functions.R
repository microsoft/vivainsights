context("Test identify functions")

test_that("identify_holidayweeks accepts both data_clean and data_cleaned", {
  # Suppress messages during testing
  suppressMessages({
    result_clean <- identify_holidayweeks(pq_data, return = "data_clean")
    result_cleaned <- identify_holidayweeks(pq_data, return = "data_cleaned")
  })
  
  expect_true(is.data.frame(result_clean))
  expect_true(is.data.frame(result_cleaned))
  expect_equal(nrow(result_clean), nrow(result_cleaned))
})

test_that("identify_inactiveweeks accepts both data_clean and data_cleaned", {
  # Suppress messages during testing
  suppressMessages({
    result_clean <- identify_inactiveweeks(pq_data, return = "data_clean")
    result_cleaned <- identify_inactiveweeks(pq_data, return = "data_cleaned")
  })
  
  expect_true(is.data.frame(result_clean))
  expect_true(is.data.frame(result_cleaned))
  expect_equal(nrow(result_clean), nrow(result_cleaned))
})

test_that("identify_nkw accepts both data_clean and data_cleaned", {
  # Suppress messages during testing
  suppressMessages({
    result_clean <- identify_nkw(pq_data, return = "data_clean")
    result_cleaned <- identify_nkw(pq_data, return = "data_cleaned")
  })
  
  expect_true(is.data.frame(result_clean))
  expect_true(is.data.frame(result_cleaned))
  expect_equal(nrow(result_clean), nrow(result_cleaned))
})

test_that("identify_holidayweeks prints message with data_clean", {
  # Set up message capture
  messages <- capture.output(
    result <- identify_holidayweeks(pq_data, return = "data_clean"),
    type = "message"
  )
  
  expect_true(is.data.frame(result))
  expect_true(any(grepl("flagged as holiday weeks", messages)) || 
              any(grepl("No holiday weeks were detected", messages)))
})

test_that("identify_inactiveweeks prints message with data_clean", {
  # Set up message capture
  messages <- capture.output(
    result <- identify_inactiveweeks(pq_data, return = "data_clean"),
    type = "message"
  )
  
  expect_true(is.data.frame(result))
  expect_true(any(grepl("flagged as inactive weeks", messages)) || 
              any(grepl("No inactive weeks were detected", messages)))
})

test_that("identify_nkw prints message with data_clean", {
  # Set up message capture
  messages <- capture.output(
    result <- identify_nkw(pq_data, return = "data_clean"),
    type = "message"
  )
  
  expect_true(is.data.frame(result))
  expect_true(any(grepl("flagged as non-knowledge workers", messages)) || 
              any(grepl("No employees were identified as non-knowledge workers", messages)))
})