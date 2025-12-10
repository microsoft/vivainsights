# Identify Inactive Weeks

This function scans a standard query output for weeks where
collaboration hours is far outside the mean for any individual person in
the dataset. Returns a list of weeks that appear to be inactive weeks
and optionally an edited dataframe with outliers removed.

As best practice, run this function prior to any analysis to remove
atypical collaboration weeks from your dataset.

## Usage

``` r
identify_inactiveweeks(data, sd = 2, return = "text")
```

## Arguments

- data:

  A Standard Person Query dataset in the form of a data frame.

- sd:

  The standard deviation below the mean for collaboration hours that
  should define an outlier week. Enter a positive number. Default is 1
  standard deviation.

- return:

  String specifying what to return. This must be one of the following
  strings:

  - `"text"`

  - `"data_cleaned"`

  - `"data_clean"`

  - `"data_dirty"`

  See `Value` for more information.

## Value

Returns an error message by default, where `'text'` is returned. When
`'data_cleaned'` or `'data_clean'` is passed, a dataset with outlier
weeks removed is returned as a dataframe. When `'data_dirty'` is passed,
a dataset with outlier weeks is returned as a dataframe.

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
[`hrvar_count_all()`](https://microsoft.github.io/vivainsights/reference/hrvar_count_all.md),
[`hrvar_trend()`](https://microsoft.github.io/vivainsights/reference/hrvar_trend.md),
[`identify_churn()`](https://microsoft.github.io/vivainsights/reference/identify_churn.md),
[`identify_holidayweeks()`](https://microsoft.github.io/vivainsights/reference/identify_holidayweeks.md),
[`identify_nkw()`](https://microsoft.github.io/vivainsights/reference/identify_nkw.md),
[`identify_outlier()`](https://microsoft.github.io/vivainsights/reference/identify_outlier.md),
[`identify_privacythreshold()`](https://microsoft.github.io/vivainsights/reference/identify_privacythreshold.md),
[`identify_shifts()`](https://microsoft.github.io/vivainsights/reference/identify_shifts.md),
[`identify_tenure()`](https://microsoft.github.io/vivainsights/reference/identify_tenure.md),
[`track_HR_change()`](https://microsoft.github.io/vivainsights/reference/track_HR_change.md),
[`validation_report()`](https://microsoft.github.io/vivainsights/reference/validation_report.md)
