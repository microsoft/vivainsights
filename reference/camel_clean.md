# Convert "CamelCase" to "Camel Case"

Convert a text string from the format "CamelCase" to "Camel Case". This
is used for converting variable names such as "LevelDesignation" to
"Level Designation" for the purpose of prettifying plot labels.

## Usage

``` r
camel_clean(string)
```

## Arguments

- string:

  A string vector in 'CamelCase' format to format

## Value

Returns a formatted string.

## See also

Other Support:
[`any_idate()`](https://microsoft.github.io/vivainsights/reference/any_idate.md),
[`check_inputs()`](https://microsoft.github.io/vivainsights/reference/check_inputs.md),
[`cut_hour()`](https://microsoft.github.io/vivainsights/reference/cut_hour.md),
[`extract_date_range()`](https://microsoft.github.io/vivainsights/reference/extract_date_range.md),
[`extract_hr()`](https://microsoft.github.io/vivainsights/reference/extract_hr.md),
[`heat_colours()`](https://microsoft.github.io/vivainsights/reference/heat_colours.md),
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
camel_clean("NoteHowTheStringIsFormatted")
#> [1] "Note How The String Is Formatted"
```
