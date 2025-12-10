# Plot Usage Segments over time

Returns a vertical stacked bar plot that displays the proportion of the
Usage Segments over time. This visualization helps to understand the
distribution of user segments across different time periods. While a
main use case is for Copilot metrics, this function can be applied to
other metrics, such as 'Chats_sent'.

## Usage

``` r
plot_ts_us(
  data,
  metric,
  cus,
  caption,
  threshold = NULL,
  width = NULL,
  max_window = NULL,
  power_thres = 15,
  version = NULL
)
```

## Arguments

- data:

  A data frame with a column containing the Usage Segments, denoted by
  `cus`. The data frame must also include a `MetricDate` column.

- metric:

  A string representing the name of the metric column to be classified.

- cus:

  A string representing the name of the column containing the usage
  segment classifications (e.g., "UsageSegments_12w").

- caption:

  A string representing the caption for the plot. This is typically used
  to provide additional context or information about the visualization.

- threshold:

  Numeric value specifying the minimum threshold for a valid count. Only
  used when creating custom parameter captions. Defaults to NULL.

- width:

  Integer specifying the number of qualifying counts to consider for a
  habit. Only used when creating custom parameter captions. Defaults to
  NULL.

- max_window:

  Integer specifying the maximum window to consider for a habit. Only
  used when creating custom parameter captions. Defaults to NULL.

- power_thres:

  Numeric value specifying the minimum weekly average actions required
  to be classified as a 'Power User'. Defaults to 15.

- version:

  A string indicating the version of the classification. Valid options
  are "12w", "4w", or NULL for custom parameters. Used to determine
  which definitions to show in the caption.

## Value

A ggplot object representing the stacked bar plot of usage segments.
