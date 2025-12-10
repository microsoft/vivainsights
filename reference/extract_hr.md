# Extract HR attribute variables

This function uses a combination of variable class, number of unique
values, and regular expression matching to extract HR / organisational
attributes from a data frame.

## Usage

``` r
extract_hr(data, max_unique = 50, exclude_constants = TRUE, return = "names")
```

## Arguments

- data:

  A data frame to be passed through.

- max_unique:

  A numeric value representing the maximum number of unique values to
  accept for an HR attribute. Defaults to 50.

- exclude_constants:

  Logical value to specify whether single-value HR attributes are to be
  excluded. Defaults to `TRUE`.

- return:

  String specifying what to return. This must be one of the following
  strings:

  - `"names"`

  - `"vars"`

  See `Value` for more information.

## Value

A different output is returned depending on the value passed to the
`return` argument:

- `"names"`: character vector identifying all the names of HR variables
  present in the data.

- `"vars"`: data frame containing all the columns of HR variables
  present in the data.

## See also

Other Support:
[`any_idate()`](https://microsoft.github.io/vivainsights/reference/any_idate.md),
[`camel_clean()`](https://microsoft.github.io/vivainsights/reference/camel_clean.md),
[`check_inputs()`](https://microsoft.github.io/vivainsights/reference/check_inputs.md),
[`cut_hour()`](https://microsoft.github.io/vivainsights/reference/cut_hour.md),
[`extract_date_range()`](https://microsoft.github.io/vivainsights/reference/extract_date_range.md),
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

Other Data Validation:
[`check_query()`](https://microsoft.github.io/vivainsights/reference/check_query.md),
[`flag_ch_ratio()`](https://microsoft.github.io/vivainsights/reference/flag_ch_ratio.md),
[`flag_em_ratio()`](https://microsoft.github.io/vivainsights/reference/flag_em_ratio.md),
[`flag_extreme()`](https://microsoft.github.io/vivainsights/reference/flag_extreme.md),
[`flag_outlooktime()`](https://microsoft.github.io/vivainsights/reference/flag_outlooktime.md),
[`hr_trend()`](https://microsoft.github.io/vivainsights/reference/hr_trend.md),
[`hrvar_count()`](https://microsoft.github.io/vivainsights/reference/hrvar_count.md),
[`hrvar_count_all()`](https://microsoft.github.io/vivainsights/reference/hrvar_count_all.md),
[`hrvar_trend()`](https://microsoft.github.io/vivainsights/reference/hrvar_trend.md),
[`identify_churn()`](https://microsoft.github.io/vivainsights/reference/identify_churn.md),
[`identify_holidayweeks()`](https://microsoft.github.io/vivainsights/reference/identify_holidayweeks.md),
[`identify_inactiveweeks()`](https://microsoft.github.io/vivainsights/reference/identify_inactiveweeks.md),
[`identify_nkw()`](https://microsoft.github.io/vivainsights/reference/identify_nkw.md),
[`identify_outlier()`](https://microsoft.github.io/vivainsights/reference/identify_outlier.md),
[`identify_privacythreshold()`](https://microsoft.github.io/vivainsights/reference/identify_privacythreshold.md),
[`identify_shifts()`](https://microsoft.github.io/vivainsights/reference/identify_shifts.md),
[`identify_tenure()`](https://microsoft.github.io/vivainsights/reference/identify_tenure.md),
[`track_HR_change()`](https://microsoft.github.io/vivainsights/reference/track_HR_change.md),
[`validation_report()`](https://microsoft.github.io/vivainsights/reference/validation_report.md)

## Examples

``` r
pq_data %>% extract_hr(return = "names")
#> [1] "FunctionType"        "SupervisorIndicator" "Level"              
#> [4] "Organization"        "LevelDesignation"   

pq_data %>% extract_hr(return = "vars")
#> # A tibble: 6,900 × 5
#>    FunctionType SupervisorIndicator Level  Organization LevelDesignation
#>    <chr>        <chr>               <chr>  <chr>        <chr>           
#>  1 Specialist   Manager             Level3 IT           Senior IC       
#>  2 Consultant   Manager             Level2 Legal        Senior Manager  
#>  3 Advisor      Manager             Level4 Legal        Junior IC       
#>  4 Consultant   Manager             Level1 HR           Executive       
#>  5 Technician   Manager             Level1 Finance      Executive       
#>  6 Advisor      Manager             Level3 Finance      Senior IC       
#>  7 Specialist   IC                  Level4 Finance      Junior IC       
#>  8 Advisor      Manager             Level3 IT           Senior IC       
#>  9 Manager      Manager             Level3 HR           Senior IC       
#> 10 Advisor      Manager             Level1 IT           Executive       
#> # ℹ 6,890 more rows
```
