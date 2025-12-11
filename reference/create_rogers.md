# Generate Rogers Adoption Curve plots for Copilot usage

Creates various visualizations based on the Rogers adoption curve
theory, analyzing the adoption patterns of Copilot usage. The function
identifies habitual users using the
[`identify_habit()`](https://microsoft.github.io/vivainsights/reference/identify_habit.md)
function and then creates adoption curve visualizations based on
different time frames and organizational groupings.

## Usage

``` r
create_rogers(
  data,
  hrvar = NULL,
  metric,
  width = 9,
  max_window = 12,
  threshold = 1,
  start_metric = NULL,
  return = "plot",
  plot_mode = 1,
  label = FALSE
)
```

## Arguments

- data:

  Data frame containing Person Query data to be analyzed. Must contain
  `PersonId`, `MetricDate`, and the specified metrics.

- hrvar:

  Character string specifying the HR attribute or organizational
  variable to group by. Default is `NULL`, for no grouping.

- metric:

  Character string containing the name of the metric to analyze for
  habit identification, e.g. "Total_Copilot_actions". This is passed to
  [`identify_habit()`](https://microsoft.github.io/vivainsights/reference/identify_habit.md).

- width:

  Integer specifying the number of qualifying counts to consider for a
  habit. Passed to
  [`identify_habit()`](https://microsoft.github.io/vivainsights/reference/identify_habit.md).
  Default is 9.

- max_window:

  Integer specifying the maximum unit of dates to consider a qualifying
  window for a habit. Passed to
  [`identify_habit()`](https://microsoft.github.io/vivainsights/reference/identify_habit.md).
  Default is 12.

- threshold:

  Numeric value specifying the minimum threshold for the metric to be
  considered a qualifying count. Passed to
  [`identify_habit()`](https://microsoft.github.io/vivainsights/reference/identify_habit.md).
  Default is 1.

- start_metric:

  Character string containing the name of the metric used for
  determining enablement start date. This metric should track when users
  first gained access to the technology being analyzed. The function
  identifies the earliest date where this metric is greater than 0 for
  each user as their "enablement date". This is then used in plot modes
  3 and 4 to calculate time-to-adoption and Rogers segment
  classifications. The suggested variable is
  "Total_Copilot_enabled_days", but any metric that indicates access or
  licensing status can be used (e.g., "License_assigned_days",
  "Access_granted"). This parameter is optional for plot modes 1 and 2,
  but required for plot modes 3 and 4. When `return = "data"` and
  `start_metric` is provided, Rogers segment classifications will be
  included in the returned data frame. Default is `NULL`.

- return:

  Character vector specifying what to return. Valid inputs are "plot",
  "data", and "table". Default is "plot".

- plot_mode:

  Integer or character string determining which plot to return. Valid
  inputs are:

  - 1 or "cumulative": Rogers Adoption Curve showing cumulative adoption

  - 2 or "weekly": Weekly Rate of adoption showing new habitual users

  - 3 or "enablement": Enablement-based adoption rate with Rogers
    segments

  - 4 or "cumulative_enablement": Cumulative adoption adjusted for
    enablement

  Default is 1.

- label:

  Logical value to determine whether to show data point labels on the
  plot for cumulative adoption curves (plot modes 1 and 4). If `TRUE`,
  both `geom_point()` and `geom_text()` are added to display data labels
  rounded to 1 decimal place above each data point. Defaults to `FALSE`.

## Value

Returns a 'ggplot' object by default when 'plot' is passed in `return`.
When 'table' is passed, a summary table is returned as a data frame.
When 'data' is passed, the processed data with habit classifications is
returned.

When `return = "data"`, the returned data frame includes:

- All original columns from the input data

- `IsHabit`: Binary indicator of whether the user has developed a habit

- `adoption_week`: The week when the user first exhibited habitual
  behavior

- `enable_week`: (if `start_metric` provided) The week when the user was
  first enabled

- `weeks_to_adopt`: (if `start_metric` provided) Number of weeks from
  enablement to adoption

- `RogersSegment`: (if `start_metric` provided) Rogers adoption segment
  classification:

  - "Innovators" (fastest 2.5\\

  - "Early Adopters" (next 13.5\\

  - "Early Majority" (next 34\\

  - "Late Majority" (next 34\\

  - "Laggards" (slowest 16\\

## Details

This function provides four distinct plot modes to analyze adoption
patterns:

**Plot Mode 1 - Cumulative Adoption Curve:** Shows the classic Rogers
adoption curve with cumulative percentage of habitual users over time.
This S-shaped curve helps identify the pace of adoption and when
saturation begins. Steep sections indicate rapid adoption periods, while
flat sections suggest slower uptake or natural limits.

**Plot Mode 2 - Weekly Adoption Rate:** Displays the number of new
habitual users identified each week, with a 3-week moving average line
to smooth volatility. This view helps identify adoption spikes, seasonal
patterns, and the natural ebb and flow of user onboarding. High bars
indicate successful onboarding periods.

**Plot Mode 3 - Enablement-Based Adoption:** Analyzes adoption relative
to when users were first enabled (had access). Users are classified into
Rogers segments (Innovators, Early Adopters, Early/Late Majority,
Laggards) based on how quickly they adopted after enablement. This helps
understand the natural distribution of adoption speed within your
organization.

**Plot Mode 4 - Cumulative Enablement-Adjusted:** Similar to Mode 1 but
only includes users who had enablement data, providing a more accurate
view of adoption among those who actually had access to the technology.
This removes noise from users who may not have been properly enabled.

**Interpretation Guidelines:**

- Early steep curves suggest strong product-market fit

- Plateaus may indicate training needs or feature limitations

- Seasonal patterns often reflect organizational training cycles

- Rogers segments help identify user personas for targeted interventions

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

## Author

Chris Gideon <chris.gideon@microsoft.com>

## Examples

``` r
# Basic Rogers adoption curve
create_rogers(
  data = pq_data,
  metric = "Copilot_actions_taken_in_Teams",
  plot_mode = 1
)
#> Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
#> ℹ Please use `linewidth` instead.
#> ℹ The deprecated feature was likely used in the vivainsights package.
#>   Please report the issue at
#>   <https://github.com/microsoft/vivainsights/issues/>.


# Weekly adoption rate by organization
create_rogers(
  data = pq_data,
  hrvar = "Organization",
  metric = "Copilot_actions_taken_in_Teams",
  plot_mode = 2
)
#> Warning: Removed 14 rows containing missing values or values outside the scale range
#> (`geom_line()`).
#> `geom_line()`: Each group consists of only one observation.
#> ℹ Do you need to adjust the group aesthetic?


# Enablement-based adoption
create_rogers(
  data = pq_data,
  metric = "Copilot_actions_taken_in_Teams",
  start_metric = "Total_Copilot_enabled_days",
  plot_mode = 3
)


# Return data with Rogers segments
rogers_data <- create_rogers(
  data = pq_data,
  metric = "Copilot_actions_taken_in_Teams",
  start_metric = "Total_Copilot_enabled_days",
  return = "data"
)
#> Rogers segments calculated based on Total_Copilot_enabled_days
#> Total users with Rogers segments: 300

# Rogers adoption curve with data point labels
create_rogers(
  data = pq_data,
  metric = "Copilot_actions_taken_in_Teams",
  plot_mode = 1,
  label = TRUE
)

```
