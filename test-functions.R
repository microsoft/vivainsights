# Load required libraries
library(testthat)

# Source the functions we're testing
source("R/identify_holidayweeks.R")
source("R/identify_inactiveweeks.R")
source("R/identify_nkw.R")

# Create a minimal mock dataset for testing
create_mock_data <- function() {
  dates <- seq(as.Date("2023-01-01"), as.Date("2023-03-01"), by = "week")
  person_ids <- c("P1", "P2", "P3", "P4", "P5")
  
  # Create combinations
  df <- expand.grid(PersonId = person_ids, MetricDate = dates)
  
  # Add collaboration hours (with some low values for testing)
  set.seed(123)
  df$Collaboration_hours <- runif(nrow(df), 0, 20)
  
  # Set some values to be low to test holiday/inactive detection
  df$Collaboration_hours[df$MetricDate == as.Date("2023-01-15")] <- 1
  df$Collaboration_hours[df$MetricDate == as.Date("2023-01-22")] <- 1.5
  
  # Add Organization column for nkw test
  df$Organization <- sample(c("HR", "IT", "Finance"), nrow(df), replace = TRUE)
  
  return(df)
}

# Create test data
test_data <- create_mock_data()

# Test 1: identify_holidayweeks - data_clean and data_cleaned should return same structure
print("Testing identify_holidayweeks...")
result1 <- capture.output(
  clean <- identify_holidayweeks(test_data, sd = 1, return = "data_clean"),
  type = "message"
)
result2 <- capture.output(
  cleaned <- identify_holidayweeks(test_data, sd = 1, return = "data_cleaned"),
  type = "message"
)

print("Messages for data_clean:")
print(result1)
print("Messages for data_cleaned:")
print(result2)
print("Are dimensions equal?")
print(dim(clean) == dim(cleaned))

# Test 2: identify_inactiveweeks - data_clean and data_cleaned should return same structure
print("Testing identify_inactiveweeks...")
result3 <- capture.output(
  clean <- identify_inactiveweeks(test_data, sd = 1, return = "data_clean"),
  type = "message"
)
result4 <- capture.output(
  cleaned <- identify_inactiveweeks(test_data, sd = 1, return = "data_cleaned"),
  type = "message"
)

print("Messages for data_clean:")
print(result3)
print("Messages for data_cleaned:")
print(result4)
print("Are dimensions equal?")
print(dim(clean) == dim(cleaned))

# Test 3: identify_nkw - data_clean and data_cleaned should return same structure
print("Testing identify_nkw...")
result5 <- capture.output(
  clean <- identify_nkw(test_data, collab_threshold = 10, return = "data_clean"),
  type = "message"
)
result6 <- capture.output(
  cleaned <- identify_nkw(test_data, collab_threshold = 10, return = "data_cleaned"),
  type = "message"
)

print("Messages for data_clean:")
print(result5)
print("Messages for data_cleaned:")
print(result6)
print("Are dimensions equal?")
print(dim(clean) == dim(cleaned))
