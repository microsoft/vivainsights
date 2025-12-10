# Identify groups under privacy threshold

This function scans a standard query output for groups with of employees
under the privacy threshold. The method consists in reviewing each
individual HR attribute, and count the distinct people within each
group.

## Usage

``` r
identify_privacythreshold(
  data,
  hrvar = extract_hr(data),
  mingroup = 5,
  return = "table"
)
```

## Arguments

- data:

  A Standard Person Query dataset in the form of a data frame.

- hrvar:

  A list of HR Variables to consider in the scan. Defaults to all HR
  attributes identified.

- mingroup:

  Numeric value setting the privacy threshold / minimum group size.
  Defaults to 5.

- return:

  String specifying what to return. This must be one of the following
  strings:

  - `"table"`

  - `"text"`

  See `Value` for more information.

## Value

A different output is returned depending on the value passed to the
`return` argument:

- `"table"`: data frame. A summary table of groups that fall below the
  privacy threshold.

- `"text"`: string. A diagnostic message.

Returns a ggplot object by default, where 'plot' is passed in `return`.
When 'table' is passed, a summary table is returned as a data frame.

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
[`identify_nkw()`](https://microsoft.github.io/vivainsights/reference/identify_nkw.md),
[`identify_outlier()`](https://microsoft.github.io/vivainsights/reference/identify_outlier.md),
[`identify_shifts()`](https://microsoft.github.io/vivainsights/reference/identify_shifts.md),
[`identify_tenure()`](https://microsoft.github.io/vivainsights/reference/identify_tenure.md),
[`track_HR_change()`](https://microsoft.github.io/vivainsights/reference/track_HR_change.md),
[`validation_report()`](https://microsoft.github.io/vivainsights/reference/validation_report.md)

## Examples

``` r
if (FALSE) { # \dontrun{
# Return a summary table
pq_data %>% identify_privacythreshold(return = "table")

# Return a diagnostic message
pq_data %>% identify_privacythreshold(return = "text")
} # }
```
