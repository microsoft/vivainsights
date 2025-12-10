# Sankey chart of organizational movement between HR attributes and missing values (outside company move) (Data Overview)

Creates a list of everyone at a specified start date and a specified end
date then aggregates up people who have moved between organizations
between this to points of time and visualizes the move through a sankey
chart.

Through this chart you can see:

- The HR attribute/orgs that have the highest move out

- The HR attribute/orgs that have the highest move in

- The number of people that do not have that HR attribute or if they are
  no longer in the system

## Usage

``` r
track_HR_change(
  data,
  start_date = min(data$MetricDate),
  end_date = max(data$MetricDate),
  hrvar = "Organization",
  mingroup = 5,
  return = "plot",
  NA_replacement = "Out of Company"
)
```

## Arguments

- data:

  A Person Query dataset in the form of a data frame.

- start_date:

  A start date to compare changes. See `end_date`.

- end_date:

  An end date to compare changes. See `start_date`.

- hrvar:

  HR Variable by which to compare changes between, defaults to
  `"Organization"` but accepts any character vector, e.g.
  `"LevelDesignation"`

- mingroup:

  Numeric value setting the privacy threshold / minimum group size.
  Defaults to 5.

- return:

  Character vector specifying what to return, defaults to `"plot"`.
  Valid inputs are `"plot"` and `"table"`.

- NA_replacement:

  Character replacement for NA defaults to "out of company"

## Value

Returns a 'NetworkD3' object by default, where 'plot' is passed in
`return`. When 'table' is passed, a summary table is returned as a data
frame.

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
[`identify_tenure()`](https://microsoft.github.io/vivainsights/reference/identify_tenure.md),
[`validation_report()`](https://microsoft.github.io/vivainsights/reference/validation_report.md)

## Author

Tannaz Sattari Tabrizi <Tannaz.Sattari@microsoft.com>

## Examples

``` r
pq_data %>% track_HR_change()

{"x":{"links":{"source":[0,1,2,3,4,5,6],"target":[7,8,9,10,11,12,13],"value":[68,68,52,44,33,22,13]},"nodes":{"name":["Finance","IT","Research","Legal","HR","Operations","Sales","Finance ","IT ","Research ","Legal ","HR ","Operations ","Sales "],"group":["Finance","IT","Research","Legal","HR","Operations","Sales","Finance ","IT ","Research ","Legal ","HR ","Operations ","Sales "]},"options":{"NodeID":"name","NodeGroup":"name","LinkGroup":null,"colourScale":"d3.scaleOrdinal(d3.schemeCategory20);","fontSize":7,"fontFamily":null,"nodeWidth":15,"nodePadding":10,"units":"count","margin":{"top":null,"right":null,"bottom":null,"left":null},"iterations":32,"sinksRight":false}},"evals":[],"jsHooks":[]}
```
