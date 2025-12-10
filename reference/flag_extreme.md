# Warn for extreme values by checking against a threshold

This is used as part of data validation to check if there are extreme
values in the dataset.

## Usage

``` r
flag_extreme(
  data,
  metric,
  person = TRUE,
  threshold,
  mode = "above",
  return = "message"
)
```

## Arguments

- data:

  A Standard Person Query dataset in the form of a data frame.

- metric:

  A character string specifying the metric to test.

- person:

  A logical value to specify whether to calculate person-averages.
  Defaults to `TRUE` (person-averages calculated).

- threshold:

  Numeric value specifying the threshold for flagging.

- mode:

  String determining mode to use for identifying extreme values.

  - `"above"`: checks whether value is great than the threshold
    (default)

  - `"equal"`: checks whether value is equal to the threshold

  - `"below"`: checks whether value is below the threshold

- return:

  String specifying what to return. This must be one of the following
  strings:

  - `"text"`

  - `"message"`

  - `"table"`

  See `Value` for more information.

## Value

A different output is returned depending on the value passed to the
`return` argument:

- `"text"`: string. A diagnostic message.

- `"message"`: message on console. A diagnostic message.

- `"table"`: data frame. A person-level table with `PersonId` and the
  extreme values of the selected metric.

## See also

Other Data Validation:
[`check_query()`](https://microsoft.github.io/vivainsights/reference/check_query.md),
[`extract_hr()`](https://microsoft.github.io/vivainsights/reference/extract_hr.md),
[`flag_ch_ratio()`](https://microsoft.github.io/vivainsights/reference/flag_ch_ratio.md),
[`flag_em_ratio()`](https://microsoft.github.io/vivainsights/reference/flag_em_ratio.md),
[`flag_outlooktime()`](https://microsoft.github.io/vivainsights/reference/flag_outlooktime.md),
[`hr_trend()`](https://microsoft.github.io/vivainsights/reference/hr_trend.md),
[`hrvar_count()`](https://microsoft.github.io/vivainsights/reference/hrvar_count.md),
[`hrvar_count_all()`](https://microsoft.github.io/vivainsights/reference/hrvar_count_all.md),
[`hrvar_trend()`](https://microsoft.github.io/vivainsights/reference/hrvar_trend.md),
[`identify_churn()`](https://microsoft.github.io/vivainsights/reference/identify_churn.md),
[`identify_holidayweeks()`](https://microsoft.github.io/vivainsights/reference/identify_holidayweeks.md),
[`identify_inactiveweeks()`](https://microsoft.github.io/vivainsights/reference/identify_inactiveweeks.md),
[`identify_nkw()`](https://microsoft.github.io/vivainsights/reference/identify_nkw.md),
[`identify_outlier()`](https://microsoft.github.io/vivainsights/reference/identify_outlier.md),
[`identify_privacythreshold()`](https://microsoft.github.io/vivainsights/reference/identify_privacythreshold.md),
[`identify_shifts()`](https://microsoft.github.io/vivainsights/reference/identify_shifts.md),
[`identify_tenure()`](https://microsoft.github.io/vivainsights/reference/identify_tenure.md),
[`track_HR_change()`](https://microsoft.github.io/vivainsights/reference/track_HR_change.md),
[`validation_report()`](https://microsoft.github.io/vivainsights/reference/validation_report.md)

## Examples

``` r
# The threshold values are intentionally set low to trigger messages.
flag_extreme(pq_data, "Email_hours", threshold = 15)
#> [Pass] There are no persons where their average Email hours exceeds 15.

# Return a summary table
flag_extreme(pq_data, "Email_hours", threshold = 15, return = "table")
#> # A tibble: 0 × 2
#> # ℹ 2 variables: PersonId <chr>, Email_hours <dbl>

# Person-week level
flag_extreme(pq_data, "Email_hours", person = FALSE, threshold = 15)
#> [Warning] There are 47 rows where their value of Email hours exceeds 15.

# Check for values equal to threshold
flag_extreme(pq_data, "Email_hours", person = TRUE, mode = "equal", threshold = 0)
#> [Pass] There are no persons where their average Email hours are equal to 0.

# Check for values below threshold
flag_extreme(pq_data, "Email_hours", person = TRUE, mode = "below", threshold = 5)
#> [Pass] There are no persons where their average Email hours are less than 5.
```
