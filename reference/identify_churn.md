# Identify employees who have churned from the dataset

This function identifies and counts the number of employees who have
churned from the dataset by measuring whether an employee who is present
in the first `n` (n1) weeks of the data is present in the last `n` (n2)
weeks of the data.

## Usage

``` r
identify_churn(data, n1 = 6, n2 = 6, return = "message", flip = FALSE)
```

## Arguments

- data:

  A Person Query as a data frame. Must contain a `PersonId`.

- n1:

  A numeric value specifying the number of weeks at the beginning of the
  period that defines the measured employee set. Defaults to 6.

- n2:

  A numeric value specifying the number of weeks at the end of the
  period to calculate whether employees have churned from the data.
  Defaults to 6.

- return:

  String specifying what to return. This must be one of the following
  strings:

  - `"message"` (default)

  - `"text"`

  - `"data"`

  See `Value` for more information.

- flip:

  Logical, defaults to FALSE. This determines whether to reverse the
  logic of identifying the non-overlapping set. If set to `TRUE`, this
  effectively identifies new-joiners, or those who were not present in
  the first n weeks of the data but were present in the final n weeks.

## Value

A different output is returned depending on the value passed to the
`return` argument:

- `"message"`: Message on console. A diagnostic message.

- `"text"`: String. A diagnostic message.

- `"data"`: Character vector containing the the `PersonId` of employees
  who have been identified as churned.

## Details

An additional use case of this function is the ability to identify
"new-joiners" by using the argument `flip`.

If an employee is present in the first `n` weeks of the data but not
present in the last `n` weeks of the data, the function considers the
employee as churned. As the measurement period is defined by the number
of weeks from the start and the end of the passed data frame, you may
consider filtering the dates accordingly before running this function.

Another assumption that is in place is that any employee whose
`PersonId` is not available in the data has churned. Note that there may
be other reasons why an employee's `PersonId` may not be present, e.g.
maternity/paternity leave, Viva Insights license has been removed, shift
to a low-collaboration role (to the extent that he/she becomes
inactive).

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
pq_data %>% identify_churn(n1 = 3, n2 = 3, return = "message")
#> Churn:
#> There are 0 employees from 2024-04-28 to 2024-05-12 (3 weeks) who are no longer present in 2024-09-15 to 2024-09-29 (3 weeks).
```
