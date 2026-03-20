# Kaplan–Meier Survival Curve (Visualization)

Renders a Kaplan–Meier step curve by group from a long-format survival
table.

## Usage

``` r
create_survival_viz(
  data,
  hrvar = "group",
  title = "Survival Curve",
  subtitle = "Kaplan–Meier estimate",
  caption = NULL
)
```

## Arguments

- data:

  Long survival table produced by
  [`create_survival_calc()`](https://microsoft.github.io/vivainsights/reference/create_survival_calc.md).

- hrvar:

  Character. Group column name in `data`.

- title, subtitle:

  Character. Plot annotations.

- caption:

  Character string for the plot caption. Typically the output of
  `extract_date_range(data, return = "text")`, as constructed by
  [`create_survival()`](https://microsoft.github.io/vivainsights/reference/create_survival.md).
  Defaults to `NULL` (no caption).

## Value

ggplot object.
