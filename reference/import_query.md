# Import a query from Viva Insights Analyst Experience

Import a Viva Insights Query from a .csv file, with variable
classifications optimised for other functions in the package.

## Usage

``` r
import_query(
  x,
  pid = NULL,
  dateid = NULL,
  date_format = "%m/%d/%Y",
  convert_date = TRUE,
  encoding = "UTF-8"
)
```

## Arguments

- x:

  String containing the path to the Viva Insights query to be imported.
  The input file must be a .csv file, and the file extension must be
  explicitly entered, e.g. `"/files/standard query.csv"`

- pid:

  String specifying the unique person or individual identifier variable.
  `import_query` renames this to `PersonId` so that this is compatible
  with other functions in the package. Defaults to `NULL`, where no
  action is taken.

- dateid:

  String specifying the date variable. `import_query` renames this to
  `MetricDate` so that this is compatible with other functions in the
  package. Defaults to `NULL`, where no action is taken.

- date_format:

  String specifying the date format for converting any variable that may
  be a date to a Date variable. Defaults to `"%m/%d/%Y"`.

- convert_date:

  Logical. Defaults to `TRUE`. When set to `TRUE`, any variable that
  matches true with
  [`is_date_format()`](https://microsoft.github.io/vivainsights/reference/is_date_format.md)
  gets converted to a Date variable. When set to `FALSE`, this step is
  skipped.

- encoding:

  String to specify encoding to be used within
  [`data.table::fread()`](https://rdatatable.gitlab.io/data.table/reference/fread.html).
  See
  [`data.table::fread()`](https://rdatatable.gitlab.io/data.table/reference/fread.html)
  documentation for more information. Defaults to `'UTF-8'`.

## Value

A `tibble` is returned.

## Details

`import_query()` uses
[`data.table::fread()`](https://rdatatable.gitlab.io/data.table/reference/fread.html)
to import .csv files for speed, and by default `stringsAsFactors` is set
to FALSE. A data frame is returned by the function (not a `data.table`).
Column names are automatically cleaned, replacing spaces and special
characters with underscores.

## See also

Other Import and Export:
[`copy_df()`](https://microsoft.github.io/vivainsights/reference/copy_df.md),
[`create_dt()`](https://microsoft.github.io/vivainsights/reference/create_dt.md),
[`export()`](https://microsoft.github.io/vivainsights/reference/export.md),
[`prep_query()`](https://microsoft.github.io/vivainsights/reference/prep_query.md)
