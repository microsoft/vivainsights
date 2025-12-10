# Generate a Information Value HTML Report

The function generates an interactive HTML report using Standard Person
Query data as an input. The report contains a full Information Value
analysis, a data exploration technique that helps determine which
columns in a data set have predictive power or influence on the value of
a specified dependent variable.

## Usage

``` r
IV_report(
  data,
  predictors = NULL,
  outcome,
  bins = 5,
  max_var = 9,
  path = "IV report",
  timestamp = TRUE
)
```

## Arguments

- data:

  A Standard Person Query dataset in the form of a data frame.

- predictors:

  A character vector specifying the columns to be used as predictors.
  Defaults to NULL, where all numeric vectors in the data will be used
  as predictors.

- outcome:

  A string specifying a binary variable, i.e. can only contain the
  values 1 or 0.

- bins:

  Number of bins to use in `Information::create_infotables()`, defaults
  to 10.

- max_var:

  Numeric value to represent the maximum number of variables to show on
  plots.

- path:

  Pass the file path and the desired file name, *excluding the file
  extension*. For example, `"IV report"`.

- timestamp:

  Logical vector specifying whether to include a timestamp in the file
  name. Defaults to TRUE.

## Value

An HTML report with the same file name as specified in the arguments is
generated in the working directory. No outputs are directly returned by
the function.

## Creating a report

Below is an example on how to run the report.

    library(dplyr)

    pq_data %>%
      mutate(CH_binary = ifelse(Collaboration_hours > 12, 1, 0)) %>% # Simulate binary variable
      IV_report(outcome =  "CH_binary",
                predictors = c("Email_hours", "Meeting_hours"))

## See also

Other Reports:
[`generate_report()`](https://microsoft.github.io/vivainsights/reference/generate_report.md),
[`meeting_tm_report()`](https://microsoft.github.io/vivainsights/reference/meeting_tm_report.md),
[`read_preamble()`](https://microsoft.github.io/vivainsights/reference/read_preamble.md),
[`validation_report()`](https://microsoft.github.io/vivainsights/reference/validation_report.md)

Other Variable Association:
[`create_IV()`](https://microsoft.github.io/vivainsights/reference/create_IV.md)

Other Information Value:
[`create_IV()`](https://microsoft.github.io/vivainsights/reference/create_IV.md)
