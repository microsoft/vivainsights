# Flag unusual high collaboration hours to after-hours collaboration hours ratio

This function flags persons who have an unusual ratio of collaboration
hours to after-hours collaboration hours. Returns a character string by
default.

## Usage

``` r
flag_ch_ratio(data, threshold = c(1, 30), return = "message")
```

## Arguments

- data:

  A data frame containing a Person Query.

- threshold:

  Numeric value specifying the threshold for flagging. Defaults to 30.

- return:

  String to specify what to return. Options include:

  - `"message"`

  - `"text"`

  - `"data"`

## Value

A different output is returned depending on the value passed to the
`return` argument:

- `"message"`: message in the console containing diagnostic summary

- `"text"`: string containing diagnostic summary

- `"data"`: data frame. Person-level data with flags on unusually high
  or low ratios

## Metrics used

The metric `Collaboration_hours` is used in the calculations. Please
ensure that your query contains a metric with the exact same name.

## See also

Other Data Validation:
[`check_query()`](https://microsoft.github.io/vivainsights/reference/check_query.md),
[`extract_hr()`](https://microsoft.github.io/vivainsights/reference/extract_hr.md),
[`flag_em_ratio()`](https://microsoft.github.io/vivainsights/reference/flag_em_ratio.md),
[`flag_extreme()`](https://microsoft.github.io/vivainsights/reference/flag_extreme.md),
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
flag_ch_ratio(pq_data)
#> [Pass] The ratio of after-hours collaboration to total collaboration hours is outside the expected threshold for only 0 employees (0 % of the total).
#> - 0 employees (0 %) have an unusually high after-hours collaboration (relative to weekly collaboration hours)
#> - 0 employees (0 %) have an unusually low after-hours collaboration


data.frame(PersonId = c("Alice", "Bob"),
           Collaboration_hours = c(30, 0.5),
           After_hours_collaboration_hours = c(0.5, 30)) %>%
  flag_ch_ratio()
#> [Warning]  The ratio of after-hours collaboration to total collaboration hours is outside the expected threshold for 2 employees (100 % of the total).
#> - 1 employees (50 %) have an unusually high after-hours collaboration (relative to weekly collaboration hours)
#> - 1 employees (50 %) have an unusually low after-hours collaboration
```
