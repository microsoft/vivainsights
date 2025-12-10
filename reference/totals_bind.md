# Row-bind an identical data frame for computing grouped totals

Row-bind an identical data frame and impute a specific column with the
`target_value`, which defaults as "Total". The purpose of this is to
enable to creation of summary tables with a calculated "Total" row. See
example below on usage.

## Usage

``` r
totals_bind(data, target_col, target_value = "Total")
```

## Arguments

- data:

  data frame

- target_col:

  Character value of the column in which to impute `"Total"`. This is
  usually the intended grouping column.

- target_value:

  Character value to impute in the new data frame to row-bind. Defaults
  to `"Total"`.

## Value

data frame with twice the number of rows of the input data frame, where
half of those rows will have the `target_col` column imputed with the
value from `target_value`.

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
[`totals_col()`](https://microsoft.github.io/vivainsights/reference/totals_col.md),
[`tstamp()`](https://microsoft.github.io/vivainsights/reference/tstamp.md),
[`us_to_space()`](https://microsoft.github.io/vivainsights/reference/us_to_space.md),
[`wrap()`](https://microsoft.github.io/vivainsights/reference/wrap.md)

## Examples

``` r
pq_data %>%
  totals_bind(target_col = "LevelDesignation", target_value = "Total") %>%
  create_bar(hrvar = "LevelDesignation", metric = "Email_hours", return = "table")
#> # A tibble: 5 × 3
#>   group          Email_hours     n
#>   <chr>                <dbl> <int>
#> 1 Executive             8.83    37
#> 2 Junior IC             8.72   136
#> 3 Senior IC             8.82    87
#> 4 Senior Manager        8.70    40
#> 5 Total                 8.76   300
```
