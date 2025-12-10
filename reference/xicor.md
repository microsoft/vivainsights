# Calculate Chatterjee's Rank Correlation Coefficient

This function calculates Chatterjee's rank correlation coefficient,
which measures the association between two variables. It is particularly
useful for identifying monotonic relationships between variables, even
if they are not linear.

## Usage

``` r
xicor(x, y, ties = FALSE)
```

## Arguments

- x:

  A numeric vector representing the independent variable.

- y:

  A numeric vector representing the dependent variable.

- ties:

  A logical value indicating whether to handle ties in the data. Default
  is FALSE.

  If `ties = TRUE`, the function adjusts for tied ranks (repeated values
  in the data). This is important when there are many tied values in
  either `x` or `y`, as it ensures accurate calculation by considering
  the maximum rank for tied observations.

  If `ties = FALSE`, the function assumes that there are no ties, or
  that ties can be handled without additional computational effort. This
  option can offer better performance when ties are rare or absent.

## Value

A numeric value representing Chatterjee's rank correlation coefficient.

## Details

Unlike Pearson's correlation (which measures linear relationships),
Chatterjee's coefficient can handle non-linear monotonic relationships.
It is robust to outliers and can handle tied ranks, making it versatile
for datasets with ordinal data or tied ranks. This makes it a valuable
alternative to Spearman's and Kendall's correlations, especially when
the data may not meet the assumptions required by these methods.

By default, `ties = FALSE` is set to prioritize computational
efficiency, as handling ties requires additional processing. In cases
where ties are present or likely (such as when working with ordinal or
categorical data), it is recommended to set `ties = TRUE`.

## Examples

``` r
xicor(x = pq_data$Collaboration_hours, y = pq_data$Internal_network_size, ties = TRUE)
#> Warning: NAs produced by integer overflow
#> [1] NA
xicor(x = pq_data$Collaboration_hours, y = pq_data$Internal_network_size, ties = FALSE)
#> [1] 0.7332091

```
