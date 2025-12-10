# Generate a Data Validation report in HTML

The function generates an interactive HTML report using Standard Person
Query data as an input. The report contains checks on Viva Insights
query outputs to provide diagnostic information for the Analyst prior to
analysis.

An additional Standard Meeting Query can be provided to perform meeting
subject line related checks. This is optional and the validation report
can be run without it.

## Usage

``` r
validation_report(
  data,
  meeting_data = NULL,
  hrvar = "Organization",
  path = "validation report",
  hrvar_threshold = 150,
  timestamp = TRUE
)
```

## Arguments

- data:

  A Standard Person Query dataset in the form of a data frame.

- meeting_data:

  An optional Meeting Query dataset in the form of a data frame.

- hrvar:

  HR Variable by which to split metrics, defaults to "Organization" but
  accepts any character vector, e.g. "Organization"

- path:

  Pass the file path and the desired file name, *excluding the file
  extension*.

- hrvar_threshold:

  Numeric value determining the maximum number of unique values to be
  allowed to qualify as a HR variable. This is passed directly to the
  `threshold` argument within
  [`hrvar_count_all()`](https://microsoft.github.io/vivainsights/reference/hrvar_count_all.md).

- timestamp:

  Logical vector specifying whether to include a timestamp in the file
  name. Defaults to `TRUE`.

## Value

An HTML report with the same file name as specified in the arguments is
generated in the working directory. No outputs are directly returned by
the function.

## Details

For your input to `data` or `meeting_data`, please use the function
[`vivainsights::import_query()`](https://microsoft.github.io/vivainsights/reference/import_query.md)
to import your csv query files into R. This function will standardize
format and prepare the data as input for this report.

For most variables, a note is returned in-line instead of an error if
the variable is not available.

## Checking functions within `validation_report()`

- [`check_query()`](https://microsoft.github.io/vivainsights/reference/check_query.md)

- [`flag_ch_ratio()`](https://microsoft.github.io/vivainsights/reference/flag_ch_ratio.md)

- [`hrvar_count_all()`](https://microsoft.github.io/vivainsights/reference/hrvar_count_all.md)

- [`identify_privacythreshold()`](https://microsoft.github.io/vivainsights/reference/identify_privacythreshold.md)

- [`identify_nkw()`](https://microsoft.github.io/vivainsights/reference/identify_nkw.md)

- [`identify_holidayweeks()`](https://microsoft.github.io/vivainsights/reference/identify_holidayweeks.md)

- `subject_validate()` (available in 'wpa')

- [`identify_tenure()`](https://microsoft.github.io/vivainsights/reference/identify_tenure.md)

- [`flag_outlooktime()`](https://microsoft.github.io/vivainsights/reference/flag_outlooktime.md)

- [`identify_shifts()`](https://microsoft.github.io/vivainsights/reference/identify_shifts.md)

- [`track_HR_change()`](https://microsoft.github.io/vivainsights/reference/track_HR_change.md)

You can browse each individual function for details on calculations.

## Creating a report

Below is an example on how to run the report.

    validation_report(pq_data,
                      hrvar = "Organization")

## See also

Other Reports:
[`IV_report()`](https://microsoft.github.io/vivainsights/reference/IV_report.md),
[`generate_report()`](https://microsoft.github.io/vivainsights/reference/generate_report.md),
[`meeting_tm_report()`](https://microsoft.github.io/vivainsights/reference/meeting_tm_report.md),
[`read_preamble()`](https://microsoft.github.io/vivainsights/reference/read_preamble.md)

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
[`identify_inactiveweeks()`](https://microsoft.github.io/vivainsights/reference/identify_inactiveweeks.md),
[`identify_nkw()`](https://microsoft.github.io/vivainsights/reference/identify_nkw.md),
[`identify_outlier()`](https://microsoft.github.io/vivainsights/reference/identify_outlier.md),
[`identify_privacythreshold()`](https://microsoft.github.io/vivainsights/reference/identify_privacythreshold.md),
[`identify_shifts()`](https://microsoft.github.io/vivainsights/reference/identify_shifts.md),
[`identify_tenure()`](https://microsoft.github.io/vivainsights/reference/identify_tenure.md),
[`track_HR_change()`](https://microsoft.github.io/vivainsights/reference/track_HR_change.md)
