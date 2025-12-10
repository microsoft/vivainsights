# Create a density plot for any metric

Provides an analysis of the distribution of a selected metric. Returns a
faceted density plot by default. Additional options available to return
the underlying frequency table.

## Usage

``` r
create_density(
  data,
  metric,
  hrvar = "Organization",
  mingroup = 5,
  ncol = NULL,
  return = "plot"
)
```

## Arguments

- data:

  A Standard Person Query dataset in the form of a data frame.

- metric:

  String containing the name of the metric, e.g. "Collaboration_hours"

- hrvar:

  String containing the name of the HR Variable by which to split
  metrics. Defaults to `"Organization"`. To run the analysis on the
  total instead of splitting by an HR attribute, supply `NULL` (without
  quotes).

- mingroup:

  Numeric value setting the privacy threshold / minimum group size.
  Defaults to 5.

- ncol:

  Numeric value setting the number of columns on the plot. Defaults to
  `NULL` (automatic).

- return:

  String specifying what to return. This must be one of the following
  strings:

  - `"plot"`

  - `"table"`

  - `"data"`

  - `"frequency"`

  See `Value` for more information.

## Value

A different output is returned depending on the value passed to the
`return` argument:

- `"plot"`: 'ggplot' object. A faceted density plot for the metric.

- `"table"`: data frame. A summary table for the metric, containing the
  following columns:

  - `group`: The HR variable by which the metric is split.

  - `mean`: The mean of the metric.

  - `min`: The minimum value of the metric.

  - `p10`: The 10th percentile of the metric.

  - `p25`: The 25th percentile of the metric.

  - `p50`: The 50th percentile of the metric.

  - `p75`: The 75th percentile of the metric.

  - `p90`: The 90th percentile of the metric.

  - `max`: The maximum value of the metric.

  - `sd`: The standard deviation of the metric.

  - `range`: The range of the metric.

  - `n`: The number of observations.

- `"data"`: data frame. Data with calculated person averages.

- `"frequency`: list of data frames. Each data frame contains the
  frequencies used in each panel of the plotted histogram.

## See also

Other Flexible:
[`create_bar()`](https://microsoft.github.io/vivainsights/reference/create_bar.md),
[`create_bar_asis()`](https://microsoft.github.io/vivainsights/reference/create_bar_asis.md),
[`create_boxplot()`](https://microsoft.github.io/vivainsights/reference/create_boxplot.md),
[`create_bubble()`](https://microsoft.github.io/vivainsights/reference/create_bubble.md),
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
[`create_stacked()`](https://microsoft.github.io/vivainsights/reference/create_stacked.md),
[`create_tracking()`](https://microsoft.github.io/vivainsights/reference/create_tracking.md),
[`create_trend()`](https://microsoft.github.io/vivainsights/reference/create_trend.md)

## Examples

``` r
# Return plot for whole organization
create_density(pq_data, metric = "Collaboration_hours", hrvar = NULL)


# Return plot
create_density(pq_data, metric = "Collaboration_hours", hrvar = "Organization")


# Return plot but coerce plot to three columns
create_density(pq_data, metric = "Collaboration_hours", hrvar = "Organization", ncol = 3)


# Return summary table
create_density(pq_data, metric = "Collaboration_hours", hrvar = "Organization", return = "table")
#> # A tibble: 7 × 12
#>   group       mean   min   p10   p25   p50   p75   p90   max    sd range     n
#>   <chr>      <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <int>
#> 1 Finance     23.1  20.3  21.3  22.3  23.1  23.9  25.0  25.4  1.24  5.10    68
#> 2 HR          23.1  21.0  22.0  22.4  22.9  24.0  24.4  24.8  1.01  3.78    33
#> 3 IT          22.8  20.3  21.0  21.7  22.8  23.8  24.5  26.9  1.43  6.65    68
#> 4 Legal       22.5  19.7  21.0  21.5  22.6  23.5  24.2  24.8  1.23  5.06    44
#> 5 Operations  23.5  20.0  21.7  22.6  23.3  24.9  25.5  26.4  1.62  6.39    22
#> 6 Research    23.3  20.1  21.8  22.5  23.3  24.2  25.0  25.5  1.30  5.39    52
#> 7 Sales       23.1  21.2  21.6  22.2  23.2  23.9  24.5  24.7  1.13  3.48    13
```
