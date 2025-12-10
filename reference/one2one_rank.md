# Manager 1:1 Time Ranking

This function scans a standard query output for groups with high levels
of 'Manager 1:1 Time'. Returns a plot by default, with an option to
return a table with a all of groups (across multiple HR attributes)
ranked by manager 1:1 time.

## Usage

``` r
one2one_rank(
  data,
  hrvar = extract_hr(data),
  mingroup = 5,
  mode = "simple",
  plot_mode = 1,
  return = "plot"
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

- mode:

  String to specify calculation mode. Must be either:

  - `"simple"`

  - `"combine"`

- plot_mode:

  Numeric vector to determine which plot mode to return. Must be either
  `1` or `2`, and is only used when `return = "plot"`.

  - `1`: Top and bottom five groups across the data population are
    highlighted

  - `2`: Top and bottom groups *per* organizational attribute are
    highlighted

- return:

  String specifying what to return. This must be one of the following
  strings:

  - `"plot"` (default)

  - `"table"`

  See `Value` for more information.

## Value

A different output is returned depending on the value passed to the
`return` argument:

- `"plot"`: 'ggplot' object. A bubble plot where the x-axis represents
  the metric, the y-axis represents the HR attributes, and the size of
  the bubbles represent the size of the organizations. Note that there
  is no plot output if `mode` is set to `"combine"`.

- `"table"`: data frame. A summary table for the metric.

## Details

Uses the metric `Meeting_and_call_hours_with_manager_1_1`. See
[`create_rank()`](https://microsoft.github.io/vivainsights/reference/create_rank.md)
for applying the same analysis to a different metric.

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
[`one2one_dist()`](https://microsoft.github.io/vivainsights/reference/one2one_dist.md),
[`one2one_fizz()`](https://microsoft.github.io/vivainsights/reference/one2one_fizz.md),
[`one2one_freq()`](https://microsoft.github.io/vivainsights/reference/one2one_freq.md),
[`one2one_line()`](https://microsoft.github.io/vivainsights/reference/one2one_line.md),
[`one2one_sum()`](https://microsoft.github.io/vivainsights/reference/one2one_sum.md),
[`one2one_trend()`](https://microsoft.github.io/vivainsights/reference/one2one_trend.md)

Other Managerial Relations:
[`one2one_dist()`](https://microsoft.github.io/vivainsights/reference/one2one_dist.md),
[`one2one_fizz()`](https://microsoft.github.io/vivainsights/reference/one2one_fizz.md),
[`one2one_freq()`](https://microsoft.github.io/vivainsights/reference/one2one_freq.md),
[`one2one_line()`](https://microsoft.github.io/vivainsights/reference/one2one_line.md),
[`one2one_sum()`](https://microsoft.github.io/vivainsights/reference/one2one_sum.md),
[`one2one_trend()`](https://microsoft.github.io/vivainsights/reference/one2one_trend.md)

## Examples

``` r
# Return rank table
one2one_rank(data = pq_data, return = "table")
#> # A tibble: 22 × 4
#>    hrvar               group      Meeting_and_call_hours_with_manager_1_1     n
#>    <chr>               <chr>                                        <dbl> <int>
#>  1 FunctionType        Technician                                   0.968   274
#>  2 SupervisorIndicator IC                                           0.929    34
#>  3 Organization        Sales                                        0.924    13
#>  4 Organization        Research                                     0.907    52
#>  5 Organization        Finance                                      0.895    68
#>  6 FunctionType        Specialist                                   0.894   300
#>  7 Level               Level4                                       0.892   136
#>  8 LevelDesignation    Junior IC                                    0.892   136
#>  9 Level               Level1                                       0.885    37
#> 10 LevelDesignation    Executive                                    0.885    37
#> # ℹ 12 more rows

# Return plot
one2one_rank(data = pq_data, return = "plot")

```
