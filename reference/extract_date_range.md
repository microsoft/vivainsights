# Extract date period

Return a data frame with the start and end date of the query data by
default. There are options to return a descriptive string, which is used
in the caption of plots in this package.

## Usage

``` r
extract_date_range(data, return = "table")
```

## Arguments

- data:

  Data frame containing a query to pass through. The data frame must
  contain a `Date` column. Accepts a Person query or a Meeting query.

- return:

  String specifying what output to return. Returns a table by default
  ("table"), but allows returning a descriptive string ("text").

## Value

A different output is returned depending on the value passed to the
`return` argument:

- `"table"`: data frame. A summary table containing the start and end
  date for the dataset.

- `"text"`: string. Contains a descriptive string on the start and end
  date for the dataset.

## See also

Other Support:
[`any_idate()`](https://microsoft.github.io/vivainsights/reference/any_idate.md),
[`camel_clean()`](https://microsoft.github.io/vivainsights/reference/camel_clean.md),
[`check_inputs()`](https://microsoft.github.io/vivainsights/reference/check_inputs.md),
[`cut_hour()`](https://microsoft.github.io/vivainsights/reference/cut_hour.md),
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
