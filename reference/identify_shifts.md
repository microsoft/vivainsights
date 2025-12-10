# Identify shifts based on outlook time settings for work day start and end time

This function uses outlook calendar settings for start and end time of
work day to identify work shifts. The relevant variables are
`WorkingStartTimeSetInOutlook` and `WorkingEndTimeSetInOutlook`.

## Usage

``` r
identify_shifts(data, return = "plot")
```

## Arguments

- data:

  A data frame containing data from the Hourly Collaboration query.

- return:

  String specifying what to return. This must be one of the following
  strings:

  - `"plot"`

  - `"table"`

  - `"data"`

  See `Value` for more information.

## Value

A different output is returned depending on the value passed to the
`return` argument:

- `"plot"`: ggplot object. A bar plot for the weekly count of shifts.

- `"table"`: data frame. A summary table for the count of shifts.

- `"data`: data frame. Input data appended with the `Shifts` columns.

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
[`identify_privacythreshold()`](https://microsoft.github.io/vivainsights/reference/identify_privacythreshold.md),
[`identify_tenure()`](https://microsoft.github.io/vivainsights/reference/identify_tenure.md),
[`track_HR_change()`](https://microsoft.github.io/vivainsights/reference/track_HR_change.md),
[`validation_report()`](https://microsoft.github.io/vivainsights/reference/validation_report.md)

## Examples

``` r
# Demo with `pq_data` example where Outlook Start and End times are imputed
# Use a small sample for faster runtime
pq_data_small <- dplyr::slice_sample(pq_data, prop = 0.1)

pq_data_small$WorkingStartTimeSetInOutlook <- "6:30"
pq_data_small$WorkingEndTimeSetInOutlook <- "23:30"

# Return plot
pq_data_small %>% identify_shifts()


# Return summary table
pq_data_small %>% identify_shifts(return = "table")
#> # A tibble: 1 × 3
#>   Shifts     WeekCount PersonCount
#>   <chr>          <int>       <int>
#> 1 6:30-23:30       690         279
```
