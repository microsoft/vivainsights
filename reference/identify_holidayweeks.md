# Identify Holiday Weeks based on outliers

This function scans a standard query output for weeks where
collaboration hours is far outside the mean. Returns a list of weeks
that appear to be holiday weeks and optionally an edited dataframe with
outliers removed. By default, missing values are excluded.

As best practice, run this function prior to any analysis to remove
atypical collaboration weeks from your dataset.

## Usage

``` r
identify_holidayweeks(data, sd = 1, return = "message")
```

## Arguments

- data:

  A Standard Person Query dataset in the form of a data frame.

- sd:

  The standard deviation below the mean for collaboration hours that
  should define an outlier week. Enter a positive number. Default is 1
  standard deviation.

- return:

  String specifying what to return. This must be one of the following
  strings:

  - `"message"` (default)

  - `"data"`

  - `"data_cleaned"`

  - `"data_dirty"`

  - `"plot"`

  See `Value` for more information.

## Value

A different output is returned depending on the value passed to the
`return` argument:

- `"message"`: message on console. a message is printed identifying
  holiday weeks.

- `"data"`: data frame. A dataset with outlier weeks flagged in a new
  column is returned as a dataframe.

- `"data_cleaned"`: data frame. A dataset with outlier weeks removed is
  returned.

- `"data_dirty"`: data frame. A dataset with only outlier weeks is
  returned.

- `"plot"`: ggplot object. A line plot of Collaboration Hours with
  holiday weeks highlighted.

## Metrics used

The metric `Collaboration_hours` is used in the calculations. Please
ensure that your query contains a metric with the exact same name.

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
# Return a message by default
identify_holidayweeks(pq_data)
#> The weeks where collaboration was 1 standard deviations below the mean (23) are: 
#> `2024-07-14`, `2024-07-21`, `2024-09-01`, `2024-09-08`, `2024-09-15`

# Return plot
identify_holidayweeks(pq_data, return = "plot")

```
