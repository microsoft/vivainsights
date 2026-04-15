# Rank all groups across HR attributes on a selected Viva Insights metric

This function scans a standard Person query output for groups with high
levels of a given Viva Insights Metric. Returns a plot by default, with
an option to return a table with all groups (across multiple HR
attributes) ranked by the specified metric.

## Usage

``` r
create_rank(
  data,
  metric,
  hrvar = extract_hr(data, exclude_constants = TRUE),
  mingroup = 5,
  return = "table",
  mode = "simple",
  plot_mode = 1
)
```

## Arguments

- data:

  A Standard Person Query dataset in the form of a data frame. This must
  be a **panel dataset** where each row represents one employee per time
  period, with the columns `PersonId` and `MetricDate` present. If your
  data is already aggregated (e.g. one row per group), use the
  equivalent `*_asis()` variant of this function instead.

- metric:

  Character string containing the name of the metric, e.g.
  "Collaboration_hours"

- hrvar:

  String containing the name of the HR Variable by which to split
  metrics. Defaults to `"Organization"`. To run the analysis on the
  total instead of splitting by an HR attribute, supply `NULL` (without
  quotes).

- mingroup:

  Numeric value setting the privacy threshold / minimum group size.
  Defaults to 5.

- return:

  String specifying what to return. This must be one of the following
  strings:

  - `"plot"` (default)

  - `"table"`

  See `Value` for more information.

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

## Value

A different output is returned depending on the value passed to the
`return` argument:

- `"plot"`: 'ggplot' object. A bubble plot where the x-axis represents
  the metric, the y-axis represents the HR attributes, and the size of
  the bubbles represent the size of the organizations. Note that there
  is no plot output if `mode` is set to `"combine"`.

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
[`create_radar()`](https://microsoft.github.io/vivainsights/reference/create_radar.md),
[`create_rogers()`](https://microsoft.github.io/vivainsights/reference/create_rogers.md),
[`create_sankey()`](https://microsoft.github.io/vivainsights/reference/create_sankey.md),
[`create_scatter()`](https://microsoft.github.io/vivainsights/reference/create_scatter.md),
[`create_stacked()`](https://microsoft.github.io/vivainsights/reference/create_stacked.md),
[`create_survival()`](https://microsoft.github.io/vivainsights/reference/create_survival.md),
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
[`one2one_rank()`](https://microsoft.github.io/vivainsights/reference/one2one_rank.md),
[`one2one_sum()`](https://microsoft.github.io/vivainsights/reference/one2one_sum.md),
[`one2one_trend()`](https://microsoft.github.io/vivainsights/reference/one2one_trend.md)

Other Flexible:
[`create_bar()`](https://microsoft.github.io/vivainsights/reference/create_bar.md),
[`create_bar_asis()`](https://microsoft.github.io/vivainsights/reference/create_bar_asis.md),
[`create_boxplot()`](https://microsoft.github.io/vivainsights/reference/create_boxplot.md),
[`create_bubble()`](https://microsoft.github.io/vivainsights/reference/create_bubble.md),
[`create_density()`](https://microsoft.github.io/vivainsights/reference/create_density.md),
[`create_dist()`](https://microsoft.github.io/vivainsights/reference/create_dist.md),
[`create_fizz()`](https://microsoft.github.io/vivainsights/reference/create_fizz.md),
[`create_hist()`](https://microsoft.github.io/vivainsights/reference/create_hist.md),
[`create_inc()`](https://microsoft.github.io/vivainsights/reference/create_inc.md),
[`create_line()`](https://microsoft.github.io/vivainsights/reference/create_line.md),
[`create_line_asis()`](https://microsoft.github.io/vivainsights/reference/create_line_asis.md),
[`create_period_scatter()`](https://microsoft.github.io/vivainsights/reference/create_period_scatter.md),
[`create_radar()`](https://microsoft.github.io/vivainsights/reference/create_radar.md),
[`create_sankey()`](https://microsoft.github.io/vivainsights/reference/create_sankey.md),
[`create_scatter()`](https://microsoft.github.io/vivainsights/reference/create_scatter.md),
[`create_stacked()`](https://microsoft.github.io/vivainsights/reference/create_stacked.md),
[`create_survival()`](https://microsoft.github.io/vivainsights/reference/create_survival.md),
[`create_tracking()`](https://microsoft.github.io/vivainsights/reference/create_tracking.md),
[`create_trend()`](https://microsoft.github.io/vivainsights/reference/create_trend.md)

## Author

Carlos Morales Torrado <carlos.morales@microsoft.com>

Martin Chan <martin.chan@microsoft.com>

## Examples

``` r
pq_data_small <- dplyr::slice_sample(pq_data, prop = 0.1)

# Plot mode 1 - show top and bottom five groups
create_rank(
  data = pq_data_small,
  hrvar = c("FunctionType", "LevelDesignation"),
  metric = "Emails_sent",
  return = "plot",
  plot_mode = 1
)


# Plot mode 2 - show top and bottom groups per HR variable
create_rank(
  data = pq_data_small,
  hrvar = c("FunctionType", "LevelDesignation"),
  metric = "Emails_sent",
  return = "plot",
  plot_mode = 2
)


# Return a table
create_rank(
  data = pq_data_small,
  metric = "Emails_sent",
  return = "table"
)
#> 1 column(s) excluded due to max_unique = 50: PersonId (279).
#> Adjust the `max_unique` argument if you wish to include these columns.
#> # A tibble: 22 × 4
#>    hrvar               group     Emails_sent     n
#>    <chr>               <chr>           <dbl> <int>
#>  1 FunctionType        Advisor          45.8    83
#>  2 Organization        IT               45.3    61
#>  3 Organization        Research         44.7    46
#>  4 FunctionType        Manager          44.5   140
#>  5 Level               Level4           44.3   126
#>  6 LevelDesignation    Junior IC        44.3   126
#>  7 SupervisorIndicator IC               44.3    32
#>  8 Organization        Finance          44.0    65
#>  9 SupervisorIndicator Manager          43.7   247
#> 10 Level               Level3           43.7    84
#> # ℹ 12 more rows

# \donttest{
# Return a table - combination mode
create_rank(
  data = pq_data_small,
  metric = "Emails_sent",
  mode = "combine",
  return = "table"
)
#> 1 column(s) excluded due to max_unique = 50: PersonId (279).
#> Adjust the `max_unique` argument if you wish to include these columns.
#> # A tibble: 296 × 4
#>    hrvar    group                                              Emails_sent     n
#>    <chr>    <chr>                                                    <dbl> <int>
#>  1 Combined [FunctionType] Advisor [SupervisorIndicator] IC           52.3     8
#>  2 Combined [FunctionType] Manager [SupervisorIndicator] IC           49.5    19
#>  3 Combined [FunctionType] Advisor [SupervisorIndicator] Mana…        45.1    75
#>  4 Combined [FunctionType] Specialist [SupervisorIndicator] M…        43.8   146
#>  5 Combined [FunctionType] Manager [SupervisorIndicator] Mana…        43.7   121
#>  6 Combined [FunctionType] Consultant [SupervisorIndicator] M…        43.4    77
#>  7 Combined [FunctionType] Technician [SupervisorIndicator] M…        43.0    45
#>  8 Combined [FunctionType] Technician [SupervisorIndicator] IC        42.7     6
#>  9 Combined [FunctionType] Consultant [SupervisorIndicator] IC        40      11
#> 10 Combined [FunctionType] Specialist [SupervisorIndicator] IC        39.2    23
#> # ℹ 286 more rows
# }
```
