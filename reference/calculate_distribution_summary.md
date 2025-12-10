# Calculate Distribution Summary Statistics

Internal helper function to calculate comprehensive distribution
statistics for a given metric grouped by a categorical variable. Used by
create_hist(), create_density(), and create_boxplot() to ensure
consistent output.

## Usage

``` r
calculate_distribution_summary(plot_data, metric)
```

## Arguments

- plot_data:

  A data frame containing the metric data with columns:

  - `group`: The grouping variable

  - `<metric>`: The metric column (name specified in metric parameter)

- metric:

  Character string containing the name of the metric column

## Value

A data frame with distribution statistics:

- `group`: The grouping variable

- `mean`: Mean of the metric

- `min`: Minimum value of the metric

- `p10`: 10th percentile of the metric

- `p25`: 25th percentile of the metric

- `p50`: 50th percentile (median) of the metric

- `p75`: 75th percentile of the metric

- `p90`: 90th percentile of the metric

- `max`: Maximum value of the metric

- `sd`: Standard deviation of the metric

- `range`: Range of the metric (max - min)

- `n`: Number of observations
