# Fabricate a 'Total' HR variable

Create a 'Total' column of character type comprising exactly of one
unique value. This is a convenience function for returning a no-HR
attribute view when `NULL` is supplied to the `hrvar` argument in
functions.

## Usage

``` r
totals_col(data, total_value = "Total")
```

## Arguments

- data:

  data frame

- total_value:

  Character value defining the name and the value of the `"Total"`
  column. Defaults to `"Total"`. An error is returned if an existing
  variable has the same name as the supplied value.

## Value

data frame containing an additional 'Total' column on top of the input
data frame.

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
[`maxmin()`](https://microsoft.github.io/vivainsights/reference/maxmin.md),
[`pairwise_count()`](https://microsoft.github.io/vivainsights/reference/pairwise_count.md),
[`read_preamble()`](https://microsoft.github.io/vivainsights/reference/read_preamble.md),
[`rgb2hex()`](https://microsoft.github.io/vivainsights/reference/rgb2hex.md),
[`totals_bind()`](https://microsoft.github.io/vivainsights/reference/totals_bind.md),
[`tstamp()`](https://microsoft.github.io/vivainsights/reference/tstamp.md),
[`us_to_space()`](https://microsoft.github.io/vivainsights/reference/us_to_space.md),
[`wrap()`](https://microsoft.github.io/vivainsights/reference/wrap.md)

## Examples

``` r
# Create a visual without HR attribute breaks
pq_data %>%
  totals_col() %>%
  create_fizz(hrvar = "Total", metric = "Email_hours")

```
