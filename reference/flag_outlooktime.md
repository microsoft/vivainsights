# Flag unusual outlook time settings for work day start and end time

This function flags unusual outlook calendar settings for start and end
time of work day.

## Usage

``` r
flag_outlooktime(data, threshold = c(4, 15), return = "message")
```

## Arguments

- data:

  A data frame containing a Person Query.

- threshold:

  A numeric vector of length two, specifying the hour threshold for
  flagging. Defaults to c(4, 15).

- return:

  String specifying what to return. This must be one of the following
  strings:

  - `"text"` (default)

  - `"message"`

  - `"data"`

## Value

A different output is returned depending on the value passed to the
`return` argument:

- `"text"`: string. A diagnostic message.

- `"message"`: message on console. A diagnostic message.

- `"data"`: data frame. Data where flag is present.

See `Value` for more information.

## See also

Other Data Validation:
[`check_query()`](https://microsoft.github.io/vivainsights/reference/check_query.md),
[`extract_hr()`](https://microsoft.github.io/vivainsights/reference/extract_hr.md),
[`flag_ch_ratio()`](https://microsoft.github.io/vivainsights/reference/flag_ch_ratio.md),
[`flag_em_ratio()`](https://microsoft.github.io/vivainsights/reference/flag_em_ratio.md),
[`flag_extreme()`](https://microsoft.github.io/vivainsights/reference/flag_extreme.md),
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
# Demo with `pq_data` example where Outlook Start and End times are imputed
spq_df <- pq_data

spq_df$WorkingStartTimeSetInOutlook <- "6:30"

spq_df$WorkingEndTimeSetInOutlook <- "23:30"

# Return a message
flag_outlooktime(spq_df, threshold = c(5, 13))
#> [Warning]  100% (6900) of the person-date rows in the data have extreme Outlook settings.
#> 0% (0)  have an Outlook workday shorter than 5 hours, while 100% (6900) have a workday longer than 13 hours.

# Return data
flag_outlooktime(spq_df, threshold = c(5, 13), return = "data")
#> # A tibble: 6,900 × 5
#>    PersonId                   WorkdayRange WorkdayFlag WorkdayFlag1 WorkdayFlag2
#>    <chr>                             <dbl> <lgl>       <lgl>        <lgl>       
#>  1 7d99f98f-c0a6-4df9-b2c3-e…           17 TRUE        FALSE        TRUE        
#>  2 68d86466-5864-45f1-9c15-6…           17 TRUE        FALSE        TRUE        
#>  3 8c64bf0d-57fe-4a89-a538-d…           17 TRUE        FALSE        TRUE        
#>  4 3a12dcc6-c5d5-46e4-a1d2-0…           17 TRUE        FALSE        TRUE        
#>  5 a8f3ad16-01ea-4991-8d88-0…           17 TRUE        FALSE        TRUE        
#>  6 d83e45d2-a702-4ec8-a84a-b…           17 TRUE        FALSE        TRUE        
#>  7 137926f2-3ca2-494f-8d70-9…           17 TRUE        FALSE        TRUE        
#>  8 29f24721-5f90-4219-a628-7…           17 TRUE        FALSE        TRUE        
#>  9 f0dff723-68b7-4f89-98e3-c…           17 TRUE        FALSE        TRUE        
#> 10 f04fbe6e-bf02-42df-847d-a…           17 TRUE        FALSE        TRUE        
#> # ℹ 6,890 more rows
```
