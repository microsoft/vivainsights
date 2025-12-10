# Create count of distinct fields and percentage of employees with missing values for all HR variables

**\[experimental\]**

This function enables you to create a summary table to validate
organizational data. This table will provide a summary of the data found
in the Viva Insights *Data sources* page. This function will return a
summary table with the count of distinct fields per HR attribute and the
percentage of employees with missing values for that attribute. See
[`hrvar_count()`](https://microsoft.github.io/vivainsights/reference/hrvar_count.md)
function for more detail on the specific HR attribute of interest.

## Usage

``` r
hrvar_count_all(
  data,
  n_var = 50,
  return = "message",
  threshold = 100,
  maxna = 20
)
```

## Arguments

- data:

  A Standard Person Query dataset in the form of a data frame.

- n_var:

  number of HR variables to include in report as rows. Default is set to
  50 HR variables.

- return:

  String to specify what to return

- threshold:

  The max number of unique values allowed for any attribute. Default is
  100.

- maxna:

  The max percentage of NAs allowable for any column. Default is 20.

## Value

Returns an error message by default, where 'text' is passed in `return`.

- `'table'`: data frame. A summary table listing the number of distinct
  fields and percentage of missing values for the specified number of HR
  attributes will be returned.

- `'message'`: outputs a message indicating which values are beyond the
  specified thresholds.

## See also

Other Data Validation:
[`check_query()`](https://microsoft.github.io/vivainsights/reference/check_query.md),
[`extract_hr()`](https://microsoft.github.io/vivainsights/reference/extract_hr.md),
[`flag_ch_ratio()`](https://microsoft.github.io/vivainsights/reference/flag_ch_ratio.md),
[`flag_em_ratio()`](https://microsoft.github.io/vivainsights/reference/flag_em_ratio.md),
[`flag_extreme()`](https://microsoft.github.io/vivainsights/reference/flag_extreme.md),
[`flag_outlooktime()`](https://microsoft.github.io/vivainsights/reference/flag_outlooktime.md),
[`hr_trend()`](https://microsoft.github.io/vivainsights/reference/hr_trend.md),
[`hrvar_count()`](https://microsoft.github.io/vivainsights/reference/hrvar_count.md),
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
# Return a summary table of all HR attributes
hrvar_count_all(pq_data, return = "table")
#> # A tibble: 5 × 4
#>   Attributes          `Unique values` `Total missing values` `% missing values`
#>   <chr>                         <dbl>                  <dbl>              <dbl>
#> 1 FunctionType                      5                      0                  0
#> 2 Level                             4                      0                  0
#> 3 LevelDesignation                  4                      0                  0
#> 4 Organization                      7                      0                  0
#> 5 SupervisorIndicator               2                      0                  0
```
