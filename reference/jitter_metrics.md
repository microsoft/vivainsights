# Jitter metrics in a data frame

Convenience wrapper around
[`jitter()`](https://rdrr.io/r/base/jitter.html) to add a layer of
anonymity to a query. This can be used in combination with
[`anonymise()`](https://microsoft.github.io/vivainsights/reference/anonymise.md)
to produce a demo dataset from real data.

## Usage

``` r
jitter_metrics(data, cols = NULL, ...)
```

## Arguments

- data:

  Data frame containing a query.

- cols:

  Character vector containing the metrics to jitter. When set to `NULL`
  (default), all numeric columns in the data frame are jittered.

- ...:

  Additional arguments to pass to
  [`jitter()`](https://rdrr.io/r/base/jitter.html).

## Value

data frame where numeric columns specified by `cols` are jittered using
the function [`jitter()`](https://rdrr.io/r/base/jitter.html).

## See also

anonymise

## Examples

``` r
jittered <- jitter_metrics(pq_data, cols = "Collaboration_hours")

# compare jittered vs original results of top rows
head(
  data.frame(
    original = pq_data$Collaboration_hours,
    jittered = jittered$Collaboration_hours
  )
)
#>   original jittered
#> 1 14.12876 14.12709
#> 2 26.04322 26.04462
#> 3 25.72919 25.72913
#> 4 13.81522 13.81665
#> 5 16.22788 16.22854
#> 6 25.13330 25.13432
```
