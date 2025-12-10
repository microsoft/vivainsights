# Identify metric outliers over a date interval

This function takes in a selected metric and uses z-score (number of
standard deviations) to identify outliers across time. There are
applications in this for identifying weeks with abnormally low
collaboration activity, e.g. holidays. Time as a grouping variable can
be overridden with the `group_var` argument.

## Usage

``` r
identify_outlier(
  data,
  group_var = "MetricDate",
  metric = "Collaboration_hours"
)
```

## Arguments

- data:

  A Standard Person Query dataset in the form of a data frame.

- group_var:

  A string with the name of the grouping variable. Defaults to `Date`.

- metric:

  Character string containing the name of the metric, e.g.
  "Collaboration_hours"

## Value

Returns a data frame with `MetricDate` (if grouping variable is not
set), the metric, and the corresponding z-score.

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
[`identify_privacythreshold()`](https://microsoft.github.io/vivainsights/reference/identify_privacythreshold.md),
[`identify_shifts()`](https://microsoft.github.io/vivainsights/reference/identify_shifts.md),
[`identify_tenure()`](https://microsoft.github.io/vivainsights/reference/identify_tenure.md),
[`track_HR_change()`](https://microsoft.github.io/vivainsights/reference/track_HR_change.md),
[`validation_report()`](https://microsoft.github.io/vivainsights/reference/validation_report.md)

## Examples

``` r
identify_outlier(pq_data, metric = "Collaboration_hours")
#> # A tibble: 23 × 3
#>    MetricDate Collaboration_hours  zscore
#>    <date>                   <dbl>   <dbl>
#>  1 2024-04-28                22.8 -0.419 
#>  2 2024-05-05                22.7 -0.806 
#>  3 2024-05-12                23.9  2.22  
#>  4 2024-05-19                23.2  0.422 
#>  5 2024-05-26                23.5  1.14  
#>  6 2024-06-02                23.1  0.169 
#>  7 2024-06-09                23.0 -0.0570
#>  8 2024-06-16                23.5  1.18  
#>  9 2024-06-23                23.0 -0.0483
#> 10 2024-06-30                23.3  0.791 
#> # ℹ 13 more rows
```
