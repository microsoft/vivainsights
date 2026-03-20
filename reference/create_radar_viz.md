# Radar Chart (Visualization)

Renders a multi-group radar chart using `ggplot2` + `coord_polar()`.

## Usage

``` r
create_radar_viz(data, metrics, hrvar, fill_missing = "zero", caption = NULL)
```

## Arguments

- data:

  Output table from
  [`create_radar_calc()`](https://microsoft.github.io/vivainsights/reference/create_radar_calc.md).

- metrics:

  Character vector of metric column names.

- hrvar:

  Character string of grouping column name.

- fill_missing:

  Character string specifying how to handle missing values. If `"zero"`
  (default), fill NA values as 0 for plotting. This ensures polygons
  close properly in the radar visualization.

- caption:

  Character string for the plot caption. Typically the output of
  `extract_date_range(data, return = "text")` plus an index-mode label,
  as constructed by
  [`create_radar()`](https://microsoft.github.io/vivainsights/reference/create_radar.md).
  Defaults to `NULL` (no caption).

## Value

ggplot object.
