# Check whether a data frame contains all the required variable

Checks whether a data frame contains all the required variables.
Matching works via variable names, and used to support individual
functions in the package. Not used directly.

## Usage

``` r
check_inputs(input, requirements, return = "stop")
```

## Arguments

- input:

  Pass a data frame for checking

- requirements:

  A character vector specifying the required variable names

- return:

  A character string specifying what to return. The default value is
  "stop". Also accepts "names" and "warning".

## Value

The default behaviour is to return an error message, informing the user
what variables are not included. When `return` is set to "names", a
character vector containing the unmatched variable names is returned.

## See also

Other Support:
[`any_idate()`](https://microsoft.github.io/vivainsights/reference/any_idate.md),
[`camel_clean()`](https://microsoft.github.io/vivainsights/reference/camel_clean.md),
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
# Return error message
if (FALSE) { # \dontrun{
check_inputs(iris, c("Sepal.Length", "mpg"))
} # }

#' # Return warning message
check_inputs(iris, c("Sepal.Length", "mpg"), return = "warning")
#> Warning: The following variables are not included in the input data frame:
#>  mpg

# Return variable names
check_inputs(iris, c("Sepal.Length", "Sepal.Width", "RandomVariable"), return = "names")
#> [1] "RandomVariable"
```
