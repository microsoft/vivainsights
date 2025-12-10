# Prepare variable names and types in query data frame for analysis

For applying to data frames that are read into R using *any other
method* other than
[`import_query()`](https://microsoft.github.io/vivainsights/reference/import_query.md),
this function cleans variable names by replacing special characters and
converting the relevant variable types so that they are compatible with
the rest of the functions in **vivainsights**.

## Usage

``` r
prep_query(data, convert_date = TRUE, date_format = "%m/%d/%Y")
```

## Arguments

- data:

  A Standard Person Query dataset in the form of a data frame. You
  should pass the data frame that is read into R using *any other
  method* other than
  [`import_query()`](https://microsoft.github.io/vivainsights/reference/import_query.md),
  as
  [`import_query()`](https://microsoft.github.io/vivainsights/reference/import_query.md)
  automatically performs the same variable operations.

- convert_date:

  Logical. Defaults to `TRUE`. When set to `TRUE`, any variable that
  matches true with
  [`is_date_format()`](https://microsoft.github.io/vivainsights/reference/is_date_format.md)
  gets converted to a Date variable. When set to `FALSE`, this step is
  skipped.

- date_format:

  String specifying the date format for converting any variable that may
  be a date to a Date variable. Defaults to `"%m/%d/%Y"`.

## Value

A `tibble` with the cleaned data frame is returned.

## Examples

The following shows when and how to use `prep_query()`:

     pq_df <- read.csv("path_to_query.csv")
     cleaned_df <- pq_df |> prep_query()

You can then run checks to see that the variables are of the correct
type:

    dplyr::glimpse(cleaned_df)

## See also

Other Import and Export:
[`copy_df()`](https://microsoft.github.io/vivainsights/reference/copy_df.md),
[`create_dt()`](https://microsoft.github.io/vivainsights/reference/create_dt.md),
[`export()`](https://microsoft.github.io/vivainsights/reference/export.md),
[`import_query()`](https://microsoft.github.io/vivainsights/reference/import_query.md)
