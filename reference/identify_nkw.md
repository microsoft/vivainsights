# Identify Non-Knowledge workers in a Person Query using Collaboration Hours

This function scans a standard query output to identify employees with
consistently low collaboration signals. Returns the % of non-knowledge
workers identified by Organization, and optionally an edited data frame
with non-knowledge workers removed, or the full data frame with the
kw/nkw flag added.

## Usage

``` r
identify_nkw(data, collab_threshold = 5, return = "data_summary")
```

## Arguments

- data:

  A Standard Person Query dataset in the form of a data frame.

- collab_threshold:

  Positive numeric value representing the collaboration hours threshold
  that should be exceeded as an average for the entire analysis period
  for the employee to be categorized as a knowledge worker ("kw").
  Default is set to 5 collaboration hours. Any versions after v1.4.3,
  this uses a "greater than or equal to" logic (`>=`), in which case
  persons with exactly 5 collaboration hours will pass.

- return:

  String specifying what to return. This must be one of the following
  strings:

  - `"text"`

  - `"data_with_flag"`

  - `"data_clean"`

  - `"data_cleaned"`

  - `"data_summary"`

  See `Value` for more information.

## Value

A different output is returned depending on the value passed to the
`return` argument:

- `"text"`: string. Returns a diagnostic message.

- `"data_with_flag"`: data frame. Original input data with an additional
  column containing the `kw`/`nkw` flag.

- `"data_clean"` or `"data_cleaned"`: data frame. Data frame with
  non-knowledge workers excluded.

- `"data_summary"`: data frame. A summary table by organization listing
  the number and % of non-knowledge workers.

## See also

Other Data Validation:
[`check_query()`](https://microsoft.github.io/vivainsights/reference/check_query.md),
[`extract_hr()`](https://microsoft.github.io/vivainsights/reference/extract_hr.md),
[`flag_ch_ratio()`](https://microsoft.github.io/vivainsights/reference/flag_ch_ratio.md),
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
[`identify_outlier()`](https://microsoft.github.io/vivainsights/reference/identify_outlier.md),
[`identify_privacythreshold()`](https://microsoft.github.io/vivainsights/reference/identify_privacythreshold.md),
[`identify_shifts()`](https://microsoft.github.io/vivainsights/reference/identify_shifts.md),
[`identify_tenure()`](https://microsoft.github.io/vivainsights/reference/identify_tenure.md),
[`track_HR_change()`](https://microsoft.github.io/vivainsights/reference/track_HR_change.md),
[`validation_report()`](https://microsoft.github.io/vivainsights/reference/validation_report.md)
