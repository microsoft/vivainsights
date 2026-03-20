# Create combination pairs of HR variables and run 'create_rank()'

Create pairwise combinations of HR variables and compute an average of a
specified advanced insights metric.

## Usage

``` r
create_rank_combine(data, hrvar = extract_hr(data), metric, mingroup = 5)
```

## Arguments

- data:

  A Standard Person Query dataset in the form of a data frame.

- hrvar:

  String containing the name of the HR Variable by which to split
  metrics. Defaults to `"Organization"`. To run the analysis on the
  total instead of splitting by an HR attribute, supply `NULL` (without
  quotes).

- metric:

  Character string containing the name of the metric, e.g.
  "Collaboration_hours"

- mingroup:

  Numeric value setting the privacy threshold / minimum group size.
  Defaults to 5.

## Value

Data frame containing the following variables:

- `hrvar`: placeholder column that denotes the output as `"Combined"`.

- `group`: pairwise combinations of HR attributes with the HR attribute
  in square brackets followed by the value of the HR attribute.

- Name of the metric (as passed to `metric`)

- `n`

## Details

This function is called when the `mode` argument in
[`create_rank()`](https://microsoft.github.io/vivainsights/reference/create_rank.md)
is specified as `"combine"`.

## Examples

``` r
# Use a small sample for faster runtime
pq_data_small <- dplyr::slice_sample(pq_data, prop = 0.1)

create_rank_combine(
  data = pq_data_small,
  metric = "Email_hours",
  hrvar = c("Organization", "FunctionType", "LevelDesignation")
)
#> # A tibble: 140 × 4
#>    hrvar    group                                              Email_hours     n
#>    <chr>    <chr>                                                    <dbl> <int>
#>  1 Combined [Organization] Sales [FunctionType] Specialist           10.2      6
#>  2 Combined [Organization] Operations [FunctionType] Advisor         10.2      8
#>  3 Combined [Organization] HR [FunctionType] Technician               9.94    12
#>  4 Combined [Organization] Research [FunctionType] Consultant         9.84    11
#>  5 Combined [Organization] HR [FunctionType] Advisor                  9.75     7
#>  6 Combined [Organization] HR [FunctionType] Specialist               9.74    19
#>  7 Combined [Organization] Operations [FunctionType] Manager          9.63     8
#>  8 Combined [Organization] Operations [FunctionType] Speciali…        9.49     9
#>  9 Combined [Organization] Research [FunctionType] Technician         9.43    12
#> 10 Combined [Organization] Finance [FunctionType] Technician          9.39    17
#> # ℹ 130 more rows
```
