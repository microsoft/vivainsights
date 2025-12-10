# Identify date frequency based on a series of dates

**\[experimental\]**

Takes a vector of dates and identify whether the frequency is 'daily',
'weekly', or 'monthly'. The primary use case for this function is to
provide an accurate description of the query type used and for raising
errors should a wrong date grouping be used in the data input.

## Usage

``` r
identify_datefreq(x)
```

## Arguments

- x:

  Vector containing a series of dates.

## Value

String describing the detected date frequency, i.e.:

- `'daily'`

- `'weekly'`

- `'monthly'`

## Details

Date frequency detection works as follows:

- If at least three days of the week are present (e.g., Monday,
  Wednesday, Thursday) in the series, then the series is classified as
  'daily'

- If the total number of months in the series is equal to the length,
  then the series is classified as 'monthly'

- If the total number of sundays in the series is equal to the length of
  the series, then the series is classified as 'weekly

## Limitations

One of the assumptions made behind the classification is that weeks are
denoted with Sundays, hence the count of sundays to measure the number
of weeks. In this case, weeks where a Sunday is missing would result in
an 'unable to classify' error.

Another assumption made is that dates are evenly distributed, i.e. that
the gap between dates are equal. If dates are unevenly distributed, e.g.
only two days of the week are available for a given week, then the
algorithm will fail to identify the frequency as 'daily'.

## Examples

``` r
start_date <- as.Date("2022/06/26")
end_date <- as.Date("2022/11/27")

# Daily
day_seq <-
  seq.Date(
    from = start_date,
    to = end_date,
    by = "day"
  )

identify_datefreq(day_seq)
#> [1] "monthly"

# Weekly
week_seq <-
  seq.Date(
    from = start_date,
    to = end_date,
    by = "week"
  )

identify_datefreq(week_seq)
#> [1] "monthly"

# Monthly
month_seq <-
  seq.Date(
    from = start_date,
    to = end_date,
    by = "month"
  )
identify_datefreq(month_seq)
#> [1] "monthly"
```
