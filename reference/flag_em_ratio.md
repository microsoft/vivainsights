# Flag Persons with unusually high Email Hours to Emails Sent ratio

This function flags persons who have an unusual ratio of email hours to
emails sent. If the ratio between Email Hours and Emails Sent is greater
than the threshold, then observations tied to a `PersonId` is flagged as
unusual.

## Usage

``` r
flag_em_ratio(data, threshold = 1, return = "text")
```

## Arguments

- data:

  A data frame containing a Person Query.

- threshold:

  Numeric value specifying the threshold for flagging. Defaults to 1.

- return:

  String specifying what to return. This must be one of the following
  strings:

  - `"text"`

  - `"data"`

  See `Value` for more information.

## Value

A different output is returned depending on the value passed to the
`return` argument:

- `"text"`: string. A diagnostic message.

- `"data"`: data frame. Person-level data with those flagged with
  unusual ratios.

## See also

Other Data Validation:
[`check_query()`](https://microsoft.github.io/vivainsights/reference/check_query.md),
[`extract_hr()`](https://microsoft.github.io/vivainsights/reference/extract_hr.md),
[`flag_ch_ratio()`](https://microsoft.github.io/vivainsights/reference/flag_ch_ratio.md),
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
flag_em_ratio(pq_data)
#> [1] "0 % (0) of the population have an unusually high email hours to emails sent ratio."
```
