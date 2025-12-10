# Create an incidence analysis reflecting proportion of population scoring above or below a threshold for a metric

An incidence analysis is generated, with each value in the table
reflecting the proportion of the population that is above or below a
threshold for a specified metric. There is an option to only provide a
single `hrvar` in which a bar plot is generated, or two `hrvar` values
where an incidence table (heatmap) is generated.

## Usage

``` r
create_inc(
  data,
  metric,
  hrvar,
  mingroup = 5,
  threshold,
  position,
  return = "plot"
)

create_incidence(
  data,
  metric,
  hrvar,
  mingroup = 5,
  threshold,
  position,
  return = "plot"
)
```

## Arguments

- data:

  A Standard Person Query dataset in the form of a data frame.

- metric:

  Character string containing the name of the metric, e.g.
  "Collaboration_hours"

- hrvar:

  Character vector of at most length 2 containing the name of the HR
  Variable by which to split metrics. Accepts `NULL`, where the total
  population is used for the analysis.

- mingroup:

  Numeric value setting the privacy threshold / minimum group size.
  Defaults to 5.

- threshold:

  Numeric value specifying the threshold.

- position:

  String containing the below valid values:

  - `"above"`: show incidence of those equal to or above the threshold

  - `"below"`: show incidence of those equal to or below the threshold

- return:

  String specifying what to return. This must be one of the following
  strings:

  - `"plot"`

  - `"table"`

  See `Value` for more information.

## Value

A different output is returned depending on the value passed to the
`return` argument:

- `"plot"`: 'ggplot' object. A heat map.

- `"table"`: data frame. A summary table.

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
[`create_line()`](https://microsoft.github.io/vivainsights/reference/create_line.md),
[`create_line_asis()`](https://microsoft.github.io/vivainsights/reference/create_line_asis.md),
[`create_period_scatter()`](https://microsoft.github.io/vivainsights/reference/create_period_scatter.md),
[`create_rank()`](https://microsoft.github.io/vivainsights/reference/create_rank.md),
[`create_sankey()`](https://microsoft.github.io/vivainsights/reference/create_sankey.md),
[`create_scatter()`](https://microsoft.github.io/vivainsights/reference/create_scatter.md),
[`create_stacked()`](https://microsoft.github.io/vivainsights/reference/create_stacked.md),
[`create_tracking()`](https://microsoft.github.io/vivainsights/reference/create_tracking.md),
[`create_trend()`](https://microsoft.github.io/vivainsights/reference/create_trend.md)

## Examples

``` r
# Only a single HR attribute
create_inc(
  data = pq_data,
  metric = "After_hours_collaboration_hours",
  hrvar = "Organization",
  threshold = 4,
  position = "above"
)


# Total population (NULL hrvar)
create_inc(
  data = pq_data,
  metric = "Collaboration_hours",
  hrvar = NULL,
  threshold = 20,
  position = "below"
)


# Two HR attributes
create_inc(
  data = pq_data,
  metric = "Collaboration_hours",
  hrvar = c("LevelDesignation", "Organization"),
  threshold = 20,
  position = "below"
)

```
