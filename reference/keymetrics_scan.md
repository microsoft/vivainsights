# Run a summary of Key Metrics from the Standard Person Query data

Returns a heatmapped table by default, with options to return a table.

## Usage

``` r
keymetrics_scan(
  data,
  hrvar = "Organization",
  mingroup = 5,
  metrics = c("Collaboration_span", "Collaboration_hours",
    "After_hours_collaboration_hours", "Meetings", "Meeting_hours",
    "After_hours_meeting_hours", "Meeting_and_call_hours_with_manager_1_1",
    "Meeting_and_call_hours_with_manager", "Emails_sent", "Email_hours",
    "After_hours_email_hours", "Internal_network_size", "External_network_size"),
  return = "plot",
  low = rgb2hex(7, 111, 161),
  mid = rgb2hex(241, 204, 158),
  high = rgb2hex(216, 24, 42),
  textsize = 2
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

- metrics:

  A character vector containing the variable names to calculate averages
  of.

- return:

  Character vector specifying what to return, defaults to "plot". Valid
  inputs are "plot" and "table".

- low:

  String specifying colour code to use for low-value metrics. Arguments
  are passed directly to
  [`ggplot2::scale_fill_gradient2()`](https://ggplot2.tidyverse.org/reference/scale_gradient.html).

- mid:

  String specifying colour code to use for mid-value metrics. Arguments
  are passed directly to
  [`ggplot2::scale_fill_gradient2()`](https://ggplot2.tidyverse.org/reference/scale_gradient.html).

- high:

  String specifying colour code to use for high-value metrics. Arguments
  are passed directly to
  [`ggplot2::scale_fill_gradient2()`](https://ggplot2.tidyverse.org/reference/scale_gradient.html).

- textsize:

  A numeric value specifying the text size to show in the plot.

## Value

Returns a ggplot object by default, when `'plot'` is passed in `return`.
When `'table'` is passed, a summary table is returned as a data frame.

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

## Examples

``` r
if (FALSE) { # \dontrun{
# Heatmap plot is returned by default
keymetrics_scan(pq_data)

# Heatmap plot with custom colours
keymetrics_scan(pq_data, low = "purple", high = "yellow")

# Return summary table
keymetrics_scan(pq_data, hrvar = "LevelDesignation", return = "table")
} # }
```
