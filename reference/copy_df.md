# Copy a data frame to clipboard for pasting in Excel

This is a pipe-optimised function, that feeds into
[`vivainsights::export()`](https://microsoft.github.io/vivainsights/reference/export.md),
but can be used as a stand-alone function.

Based on the original function from
<https://github.com/martinctc/surveytoolbox>.

## Usage

``` r
copy_df(x, row.names = FALSE, col.names = TRUE, quietly = FALSE, ...)
```

## Arguments

- x:

  Data frame to be passed through. Cannot contain list-columns or nested
  data frames.

- row.names:

  A logical vector for specifying whether to allow row names. Defaults
  to `FALSE`.

- col.names:

  A logical vector for specifying whether to allow column names.
  Defaults to `FALSE`.

- quietly:

  Set this to TRUE to not print data frame on console

- ...:

  Additional arguments for write.table().

## Value

Copies a data frame to the clipboard with no return value.

## See also

Other Import and Export:
[`create_dt()`](https://microsoft.github.io/vivainsights/reference/create_dt.md),
[`export()`](https://microsoft.github.io/vivainsights/reference/export.md),
[`import_query()`](https://microsoft.github.io/vivainsights/reference/import_query.md),
[`prep_query()`](https://microsoft.github.io/vivainsights/reference/prep_query.md)
