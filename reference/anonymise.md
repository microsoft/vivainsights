# Anonymise a categorical variable by replacing values

Anonymize categorical variables such as HR variables by replacing values
with dummy team names such as 'Team A'. The behaviour is to make 1 to 1
replacements by default, but there is an option to completely randomise
values in the categorical variable.

## Usage

``` r
anonymise(x, scramble = FALSE, replacement = NULL)

anonymize(x, scramble = FALSE, replacement = NULL)
```

## Arguments

- x:

  Character vector to be passed through.

- scramble:

  Logical value determining whether to randomise values in the
  categorical variable.

- replacement:

  Character vector containing the values to replace original values in
  the categorical variable. The length of the vector must be at least as
  great as the number of unique values in the original variable.
  Defaults to `NULL`, where the replacement would consist of `"Team A"`,
  `"Team B"`, etc.

## Value

Character vector with the same length as input `x`, replaced with values
provided in `replacement`.

## See also

jitter

## Examples

``` r
unique(anonymise(pq_data$Organization))
#> [1] "Team A" "Team B" "Team C" "Team D" "Team E" "Team F" "Team G"

rep <- c("Manager+", "Manager", "IC")
unique(anonymise(pq_data$Layer), replacement = rep)
#> Warning: Unknown or uninitialised column: `Layer`.
#> character(0)
```
