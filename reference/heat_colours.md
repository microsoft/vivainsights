# Generate a vector of `n` contiguous colours, as a red-yellow-green palette.

Takes a numeric value `n` and returns a character vector of colour HEX
codes corresponding to the heat map palette.

## Usage

``` r
heat_colours(n, alpha, rev = FALSE)

heat_colors(n, alpha, rev = FALSE)
```

## Arguments

- n:

  the number of colors (\>= 1) to be in the palette.

- alpha:

  an alpha-transparency level in the range of 0 to 1 (0 means
  transparent and 1 means opaque)

- rev:

  logical indicating whether the ordering of the colors should be
  reversed.

## Value

A character vector containing the HEX codes and the same length as `n`
is returned.

## See also

Other Support:
[`any_idate()`](https://microsoft.github.io/vivainsights/reference/any_idate.md),
[`camel_clean()`](https://microsoft.github.io/vivainsights/reference/camel_clean.md),
[`check_inputs()`](https://microsoft.github.io/vivainsights/reference/check_inputs.md),
[`cut_hour()`](https://microsoft.github.io/vivainsights/reference/cut_hour.md),
[`extract_date_range()`](https://microsoft.github.io/vivainsights/reference/extract_date_range.md),
[`extract_hr()`](https://microsoft.github.io/vivainsights/reference/extract_hr.md),
[`is_date_format()`](https://microsoft.github.io/vivainsights/reference/is_date_format.md),
[`maxmin()`](https://microsoft.github.io/vivainsights/reference/maxmin.md),
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
barplot(rep(10, 50), col = heat_colours(n = 50), border = NA)


barplot(rep(10, 50), col = heat_colours(n = 50, alpha = 0.5, rev = TRUE),
border = NA)

```
