# Distribution of Manager 1:1 Time as a 100% stacked bar

Analyze Manager 1:1 Time distribution. Returns a stacked bar plot of
different buckets of 1:1 time. Additional options available to return a
table with distribution elements.

## Usage

``` r
one2one_dist(
  data,
  hrvar = "Organization",
  mingroup = 5,
  dist_colours = c("#facebc", "#fcf0eb", "#b4d5dd", "#bfe5ee"),
  return = "plot",
  cut = c(5, 15, 30)
)
```

## Arguments

- data:

  A Standard Person Query dataset in the form of a data frame.

- hrvar:

  String containing the name of the HR Variable by which to split
  metrics. Defaults to `"Organization"`. To run the analysis on the
  total instead of splitting by an HR attribute, supply `NULL` (without
  quotes).

- mingroup:

  Numeric value setting the privacy threshold / minimum group size.
  Defaults to 5.

- dist_colours:

  A character vector of length four to specify colour codes for the
  stacked bars.

- return:

  String specifying what to return. This must be one of the following
  strings:

  - `"plot"`

  - `"table"`

  See `Value` for more information.

- cut:

  A numeric vector of length three to specify the breaks for the
  distribution, e.g. c(10, 15, 20)

## Value

A different output is returned depending on the value passed to the
`return` argument:

- `"plot"`: 'ggplot' object. A stacked bar plot for the metric.

- `"table"`: data frame. A summary table for the metric.

## See also

Other Visualization:
[`afterhours_dist()`](https://microsoft.github.io/vivainsights/reference/afterhours_dist.md),
[`afterhours_fizz()`](https://microsoft.github.io/vivainsights/reference/afterhours_fizz.md),
[`afterhours_line()`](https://microsoft.github.io/vivainsights/reference/afterhours_line.md),
[`afterhours_rank()`](https://microsoft.github.io/vivainsights/reference/afterhours_rank.md),
[`afterhours_summary()`](https://microsoft.github.io/vivainsights/reference/afterhours_summary.md),
[`afterhours_trend()`](https://microsoft.github.io/vivainsights/reference/afterhours_trend.md),
[`collaboration_area()`](https://microsoft.github.io/vivainsights/reference/collaboration_area.md),
[`collaboration_dist()`](https://microsoft.github.io/vivainsights/reference/collaboration_dist.md),
[`collaboration_fizz()`](https://microsoft.github.io/vivainsights/reference/collaboration_fizz.md),
[`collaboration_line()`](https://microsoft.github.io/vivainsights/reference/collaboration_line.md),
[`collaboration_rank()`](https://microsoft.github.io/vivainsights/reference/collaboration_rank.md),
[`collaboration_sum()`](https://microsoft.github.io/vivainsights/reference/collaboration_sum.md),
[`collaboration_trend()`](https://microsoft.github.io/vivainsights/reference/collaboration_trend.md),
[`create_bar()`](https://microsoft.github.io/vivainsights/reference/create_bar.md),
[`create_bar_asis()`](https://microsoft.github.io/vivainsights/reference/create_bar_asis.md),
[`create_boxplot()`](https://microsoft.github.io/vivainsights/reference/create_boxplot.md),
[`create_bubble()`](https://microsoft.github.io/vivainsights/reference/create_bubble.md),
[`create_dist()`](https://microsoft.github.io/vivainsights/reference/create_dist.md),
[`create_fizz()`](https://microsoft.github.io/vivainsights/reference/create_fizz.md),
[`create_inc()`](https://microsoft.github.io/vivainsights/reference/create_inc.md),
[`create_line()`](https://microsoft.github.io/vivainsights/reference/create_line.md),
[`create_line_asis()`](https://microsoft.github.io/vivainsights/reference/create_line_asis.md),
[`create_period_scatter()`](https://microsoft.github.io/vivainsights/reference/create_period_scatter.md),
[`create_rank()`](https://microsoft.github.io/vivainsights/reference/create_rank.md),
[`create_rogers()`](https://microsoft.github.io/vivainsights/reference/create_rogers.md),
[`create_sankey()`](https://microsoft.github.io/vivainsights/reference/create_sankey.md),
[`create_scatter()`](https://microsoft.github.io/vivainsights/reference/create_scatter.md),
[`create_stacked()`](https://microsoft.github.io/vivainsights/reference/create_stacked.md),
[`create_tracking()`](https://microsoft.github.io/vivainsights/reference/create_tracking.md),
[`create_trend()`](https://microsoft.github.io/vivainsights/reference/create_trend.md),
[`email_dist()`](https://microsoft.github.io/vivainsights/reference/email_dist.md),
[`email_fizz()`](https://microsoft.github.io/vivainsights/reference/email_fizz.md),
[`email_line()`](https://microsoft.github.io/vivainsights/reference/email_line.md),
[`email_rank()`](https://microsoft.github.io/vivainsights/reference/email_rank.md),
[`email_summary()`](https://microsoft.github.io/vivainsights/reference/email_summary.md),
[`email_trend()`](https://microsoft.github.io/vivainsights/reference/email_trend.md),
[`external_dist()`](https://microsoft.github.io/vivainsights/reference/external_dist.md),
[`external_fizz()`](https://microsoft.github.io/vivainsights/reference/external_fizz.md),
[`external_line()`](https://microsoft.github.io/vivainsights/reference/external_line.md),
[`external_rank()`](https://microsoft.github.io/vivainsights/reference/external_rank.md),
[`external_sum()`](https://microsoft.github.io/vivainsights/reference/external_sum.md),
[`hr_trend()`](https://microsoft.github.io/vivainsights/reference/hr_trend.md),
[`hrvar_count()`](https://microsoft.github.io/vivainsights/reference/hrvar_count.md),
[`hrvar_trend()`](https://microsoft.github.io/vivainsights/reference/hrvar_trend.md),
[`keymetrics_scan()`](https://microsoft.github.io/vivainsights/reference/keymetrics_scan.md),
[`meeting_dist()`](https://microsoft.github.io/vivainsights/reference/meeting_dist.md),
[`meeting_fizz()`](https://microsoft.github.io/vivainsights/reference/meeting_fizz.md),
[`meeting_line()`](https://microsoft.github.io/vivainsights/reference/meeting_line.md),
[`meeting_rank()`](https://microsoft.github.io/vivainsights/reference/meeting_rank.md),
[`meeting_summary()`](https://microsoft.github.io/vivainsights/reference/meeting_summary.md),
[`meeting_trend()`](https://microsoft.github.io/vivainsights/reference/meeting_trend.md),
[`one2one_fizz()`](https://microsoft.github.io/vivainsights/reference/one2one_fizz.md),
[`one2one_freq()`](https://microsoft.github.io/vivainsights/reference/one2one_freq.md),
[`one2one_line()`](https://microsoft.github.io/vivainsights/reference/one2one_line.md),
[`one2one_rank()`](https://microsoft.github.io/vivainsights/reference/one2one_rank.md),
[`one2one_sum()`](https://microsoft.github.io/vivainsights/reference/one2one_sum.md),
[`one2one_trend()`](https://microsoft.github.io/vivainsights/reference/one2one_trend.md)

Other Managerial Relations:
[`one2one_fizz()`](https://microsoft.github.io/vivainsights/reference/one2one_fizz.md),
[`one2one_freq()`](https://microsoft.github.io/vivainsights/reference/one2one_freq.md),
[`one2one_line()`](https://microsoft.github.io/vivainsights/reference/one2one_line.md),
[`one2one_rank()`](https://microsoft.github.io/vivainsights/reference/one2one_rank.md),
[`one2one_sum()`](https://microsoft.github.io/vivainsights/reference/one2one_sum.md),
[`one2one_trend()`](https://microsoft.github.io/vivainsights/reference/one2one_trend.md)

## Examples

``` r
# Return plot
one2one_dist(pq_data, hrvar = "Organization", return = "plot")


# Return summary table
one2one_dist(pq_data, hrvar = "Organization", return = "table")
#> # A tibble: 7 × 4
#>   group      `15 - 30 minutes` `30+ minutes` Employee_Count
#>   <fct>                  <dbl>         <dbl>          <int>
#> 1 Finance              NA              1                 68
#> 2 HR                   NA              1                 33
#> 3 IT                    0.0147         0.985             68
#> 4 Legal                NA              1                 44
#> 5 Operations           NA              1                 22
#> 6 Research             NA              1                 52
#> 7 Sales                NA              1                 13
```
