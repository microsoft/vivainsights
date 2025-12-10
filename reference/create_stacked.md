# Horizontal stacked bar plot for any metric

Creates either a single bar plot, of a stacked bar using selected
metrics (where the typical use case is to create different definitions
of collaboration hours). Returns a plot by default. Additional options
available to return a summary table.

## Usage

``` r
create_stacked(
  data,
  hrvar = "Organization",
  metrics = c("Meeting_hours", "Email_hours"),
  mingroup = 5,
  return = "plot",
  stack_colours = c("#1d627e", "#34b1e2", "#b4d5dd", "#adc0cb"),
  percent = FALSE,
  plot_title = "Collaboration Hours",
  plot_subtitle = paste("Average by", tolower(camel_clean(hrvar))),
  legend_lab = NULL,
  rank = "descending",
  xlim = NULL,
  text_just = 0.5,
  text_colour = "#FFFFFF"
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

- metrics:

  A character vector to specify variables to be used in calculating the
  "Total" value, e.g. c("Meeting_hours", "Email_hours"). The order of
  the variable names supplied determine the order in which they appear
  on the stacked plot.

- mingroup:

  Numeric value setting the privacy threshold / minimum group size.
  Defaults to 5.

- return:

  Character vector specifying what to return, defaults to "plot". Valid
  inputs are "plot" and "table".

- stack_colours:

  A character vector to specify the colour codes for the stacked bar
  charts.

- percent:

  Logical value to determine whether to show labels as percentage signs.
  Defaults to `FALSE`.

- plot_title:

  String. Option to override plot title.

- plot_subtitle:

  String. Option to override plot subtitle.

- legend_lab:

  String. Option to override legend title/label. Defaults to `NULL`,
  where the metric name will be populated instead.

- rank:

  String specifying how to rank the bars. Valid inputs are:

  - `"descending"` - ranked highest to lowest from top to bottom
    (default).

  - `"ascending"` - ranked lowest to highest from top to bottom.

  - `NULL` - uses the original levels of the HR attribute.

- xlim:

  An option to set max value in x axis.

- text_just:

  **\[experimental\]** A numeric value controlling for the horizontal
  position of the text labels. Defaults to 0.5.

- text_colour:

  **\[experimental\]** String to specify colour to use for the text
  labels. Defaults to `"#FFFFFF"`.

## Value

Returns a 'ggplot' object by default, where 'plot' is passed in
`return`. When 'table' is passed, a summary table is returned as a data
frame.

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
[`create_rank()`](https://microsoft.github.io/vivainsights/reference/create_rank.md),
[`create_sankey()`](https://microsoft.github.io/vivainsights/reference/create_sankey.md),
[`create_scatter()`](https://microsoft.github.io/vivainsights/reference/create_scatter.md),
[`create_tracking()`](https://microsoft.github.io/vivainsights/reference/create_tracking.md),
[`create_trend()`](https://microsoft.github.io/vivainsights/reference/create_trend.md)

## Examples

``` r
pq_data %>%
  create_stacked(hrvar = "LevelDesignation",
                 metrics = c("Meeting_hours", "Email_hours"),
                 return = "plot")


pq_data %>%
  create_stacked(hrvar = "FunctionType",
                 metrics = c("Meeting_hours",
                             "Email_hours",
                             "Call_hours",
                             "Chat_hours"),
                 return = "plot",
                 rank = "ascending")


pq_data %>%
  create_stacked(hrvar = "FunctionType",
                 metrics = c("Meeting_hours",
                             "Email_hours",
                             "Call_hours",
                             "Chat_hours"),
                 return = "table")
#> # A tibble: 5 × 7
#>   group     Meeting_hours Email_hours Call_hours Chat_hours Total Employee_Count
#>   <chr>             <dbl>       <dbl>      <dbl>      <dbl> <dbl>          <int>
#> 1 Advisor            18.4        8.73       9.49       3.34  40.0            293
#> 2 Consulta…          19.3        8.81      10.2        3.12  41.4            288
#> 3 Manager            18.4        8.75      10.3        3.14  40.7            300
#> 4 Speciali…          19.1        8.75      10.3        2.95  41.1            300
#> 5 Technici…          18.8        8.88      11.6        2.98  42.2            274
```
