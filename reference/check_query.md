# Check a query to ensure that it is suitable for analysis

Prints diagnostic data about the data query to the R console, with
information such as date range, number of employees, HR attributes
identified, etc.

## Usage

``` r
check_query(data, return = "message", validation = FALSE)
```

## Arguments

- data:

  A person-level query in the form of a data frame. This includes:

  - Standard Person Query

  - Ways of Working Assessment Query

  - Hourly Collaboration Query

  All person-level query have a `PersonId` column and a `MetricDate`
  column.

- return:

  String specifying what to return. This must be one of the following
  strings:

  - `"message"` (default)

  - `"text"`

  See `Value` for more information.

- validation:

  Logical value to specify whether to show summarized version. Defaults
  to `FALSE`. To hide checks on variable names, set `validation` to
  `TRUE`.

## Value

A different output is returned depending on the value passed to the
`return` argument:

- `"message"`: a message is returned to the console.

- `"text"`: string containing the diagnostic message.

## Details

This can be used with any person-level query, such as the standard
person query, Ways of Working assessment query, and the hourly
collaboration query. When run, this prints diagnostic data to the R
console.

## See also

Other Data Validation:
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
[`identify_privacythreshold()`](https://microsoft.github.io/vivainsights/reference/identify_privacythreshold.md),
[`identify_shifts()`](https://microsoft.github.io/vivainsights/reference/identify_shifts.md),
[`identify_tenure()`](https://microsoft.github.io/vivainsights/reference/identify_tenure.md),
[`track_HR_change()`](https://microsoft.github.io/vivainsights/reference/track_HR_change.md),
[`validation_report()`](https://microsoft.github.io/vivainsights/reference/validation_report.md)

## Examples

``` r
check_query(pq_data)
#> 
#> 
#> 
#> There are 300 employees in this dataset.
#> 
#> Date ranges from 2024-04-28 to 2024-09-29.
#> 
#> There are 5 (estimated) HR attributes in the data:
#> `FunctionType`, `SupervisorIndicator`, `Level`, `Organization`, `LevelDesignation`
#> The `IsActive` flag is not present in the data.
```
