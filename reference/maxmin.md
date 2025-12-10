# Max-Min Scaling Function

This function allows you to scale vectors or an entire data frame using
the max-min scaling method A numeric vector is always returned.

## Usage

``` r
maxmin(x)
```

## Arguments

- x:

  Pass a vector or the required columns of a data frame through this
  argument.

## Value

Returns a numeric vector with the input rescaled.

## Details

This is used within
[`keymetrics_scan()`](https://microsoft.github.io/vivainsights/reference/keymetrics_scan.md)
to enable row-wise heatmapping. Originally implemented in
<https://github.com/martinctc/surveytoolbox>.

## See also

Other Support:
[`any_idate()`](https://microsoft.github.io/vivainsights/reference/any_idate.md),
[`camel_clean()`](https://microsoft.github.io/vivainsights/reference/camel_clean.md),
[`check_inputs()`](https://microsoft.github.io/vivainsights/reference/check_inputs.md),
[`cut_hour()`](https://microsoft.github.io/vivainsights/reference/cut_hour.md),
[`extract_date_range()`](https://microsoft.github.io/vivainsights/reference/extract_date_range.md),
[`extract_hr()`](https://microsoft.github.io/vivainsights/reference/extract_hr.md),
[`heat_colours()`](https://microsoft.github.io/vivainsights/reference/heat_colours.md),
[`is_date_format()`](https://microsoft.github.io/vivainsights/reference/is_date_format.md),
[`pairwise_count()`](https://microsoft.github.io/vivainsights/reference/pairwise_count.md),
[`read_preamble()`](https://microsoft.github.io/vivainsights/reference/read_preamble.md),
[`rgb2hex()`](https://microsoft.github.io/vivainsights/reference/rgb2hex.md),
[`totals_bind()`](https://microsoft.github.io/vivainsights/reference/totals_bind.md),
[`totals_col()`](https://microsoft.github.io/vivainsights/reference/totals_col.md),
[`tstamp()`](https://microsoft.github.io/vivainsights/reference/tstamp.md),
[`us_to_space()`](https://microsoft.github.io/vivainsights/reference/us_to_space.md),
[`wrap()`](https://microsoft.github.io/vivainsights/reference/wrap.md)

## Examples

``` r
numbers <- c(15, 40, 10, 2)
maxmin(numbers)
#> [1] 0.3421053 1.0000000 0.2105263 0.0000000
```
