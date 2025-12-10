# Tenure calculation based on different input dates, returns data summary table or histogram

This function calculates employee tenure based on different input dates.
`identify_tenure` uses the latest Date available if user selects
"MetricDate", but also have flexibility to select a specific date, e.g.
"1/1/2020".

## Usage

``` r
identify_tenure(
  data,
  end_date = "MetricDate",
  beg_date = "HireDate",
  maxten = 40,
  return = "message"
)
```

## Arguments

- data:

  A Standard Person Query dataset in the form of a data frame.

- end_date:

  A string specifying the name of the date variable representing the
  latest date. Defaults to "MetricDate".

- beg_date:

  A string specifying the name of the date variable representing the
  hire date. Defaults to "HireDate".

- maxten:

  A numeric value representing the maximum tenure. If the tenure exceeds
  this threshold, it would be accounted for in the flag message.

- return:

  String specifying what to return. This must be one of the following
  strings:

  - `"message"`

  - `"text"`

  - `"plot"`

  - `"data_cleaned"`

  - `"data_dirty"`

  - `"data"`

  See `Value` for more information.

## Value

A different output is returned depending on the value passed to the
`return` argument:

- `"message"`: message on console with a diagnostic message.

- `"text"`: string containing a diagnostic message.

- `"plot"`: 'ggplot' object. A line plot showing tenure.

- `"data_cleaned"`: data frame filtered only by rows with tenure values
  lying within the threshold.

- `"data_dirty"`: data frame filtered only by rows with tenure values
  lying outside the threshold.

- `"data"`: data frame with the `PersonId` and a calculated variable
  called `TenureYear` is returned.

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
[`identify_shifts()`](https://microsoft.github.io/vivainsights/reference/identify_shifts.md),
[`track_HR_change()`](https://microsoft.github.io/vivainsights/reference/track_HR_change.md),
[`validation_report()`](https://microsoft.github.io/vivainsights/reference/validation_report.md)

## Examples

``` r
library(dplyr)
# Add HireDate to `pq_data`
pq_data2 <-
  pq_data %>%
  mutate(HireDate = as.Date("1/1/2015", format = "%m/%d/%Y"))

identify_tenure(pq_data2)
#> The mean tenure is 9.8 years.
#> The max tenure is 9.8.
#> There are 0 employees with a tenure greater than 40 years.
```
