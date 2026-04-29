# Identify Retention Rate Between Two Time Periods

**\[experimental\]**

This function calculates the retention rate of individuals who meet a
specific category condition in one time period and checks whether they
still meet that condition in a subsequent time period. This function
complements
[`identify_usage_segments()`](https://microsoft.github.io/vivainsights/reference/identify_usage_segments.md).

## Usage

``` r
identify_retention(
  data,
  start_x,
  end_x,
  start_y,
  end_y = NULL,
  category,
  category_values = TRUE,
  return = "summary"
)
```

## Arguments

- data:

  A data frame containing person-level time series data with at minimum
  `PersonId`, `MetricDate`, and the column specified in `category`.

- start_x:

  Start date for the first time period (Date or character in
  `"YYYY-MM-DD"` format).

- end_x:

  End date for the first time period (exclusive).

- start_y:

  Start date for the second time period.

- end_y:

  End date for the second time period (exclusive). If `NULL`, uses all
  data from `start_y` onwards.

- category:

  A string specifying the column name containing the binary/categorical
  variable to evaluate (e.g. `"IsHabitualUser"`).

- category_values:

  A character vector of values in `category` that define the "positive"
  condition (e.g. `c("Power User", "Habitual User")`). Defaults to
  `TRUE` for binary columns.

- return:

  A string specifying the return type. Valid options are:

  - `"summary"` (default): A tibble with retention statistics.

  - `"data"`: A list with person-level retention status and breakdown.

  - `"message"`: Prints a formatted message and returns the summary
    tibble invisibly.

## Value

Depending on `return`:

- `"summary"`: A tibble with the following columns:

  - `PeriodX_Start`, `PeriodX_End`: Start and end dates of period X.

  - `PeriodY_Start`, `PeriodY_End`: Start and end dates of period Y.

  - `Category`: The category column name.

  - `CategoryValues`: The category values used.

  - `N_Original`: Number of individuals meeting the condition in period
    X.

  - `N_Tracked`: Number of those individuals found in period Y.

  - `N_Lost`: Number of individuals not found in period Y.

  - `N_Retained`: Number still meeting the condition in period Y.

  - `RetentionPct`: Retention percentage.

- `"data"`: A list containing `summary`, `person_status`, and
  `breakdown`.

- `"message"`: Prints a formatted message; returns the summary tibble
  invisibly.

## Author

Martin Chan

## Examples

``` r
if (FALSE) { # \dontrun{
# Retention of Power/Habitual users from Nov 2025 to Jan 2026
identify_retention(
  data = pq_week_df,
  start_x = "2025-11-01",
  end_x = "2025-12-01",
  start_y = "2026-01-01",
  end_y = "2026-02-01",
  category = "UsageSegments_12w",
  category_values = c("Power User", "Habitual User")
)
} # }
```
