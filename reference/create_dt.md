# Create interactive tables in HTML with 'download' buttons.

See
<https://martinctc.github.io/blog/vignette-downloadable-tables-in-rmarkdown-with-the-dt-package/>
for more.

## Usage

``` r
create_dt(x, rounding = 1, freeze = 2, percent = FALSE)
```

## Arguments

- x:

  Data frame to be passed through.

- rounding:

  Numeric vector to specify the number of decimal points to display

- freeze:

  Number of columns from the left to 'freeze'. Defaults to 2, which
  includes the row number column.

- percent:

  Logical value specifying whether to display numeric columns as
  percentages.

## Value

Returns an HTML widget displaying rectangular data.

## Details

This is exported from
[`wpa::create_dt()`](https://microsoft.github.io/wpa/reference/create_dt.html).

## See also

Other Import and Export:
[`copy_df()`](https://microsoft.github.io/vivainsights/reference/copy_df.md),
[`export()`](https://microsoft.github.io/vivainsights/reference/export.md),
[`import_query()`](https://microsoft.github.io/vivainsights/reference/import_query.md),
[`prep_query()`](https://microsoft.github.io/vivainsights/reference/prep_query.md)

## Examples

``` r
output <- hrvar_count(pq_data, return = "table")
create_dt(output)

{"x":{"filter":"none","vertical":false,"extensions":["Buttons","FixedColumns"],"data":[["1","2","3","4","5","6","7"],["IT","Finance","Research","Legal","HR","Operations","Sales"],[68,68,52,44,33,22,13]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>Organization<\/th>\n      <th>n<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"dom":"Blfrtip","fixedColumns":{"leftColumns":2},"scrollX":true,"buttons":["copy","csv","excel","pdf","print"],"lengthMenu":[[10,25,50,-1],["10","25","50","All"]],"columnDefs":[{"targets":2,"render":"function(data, type, row, meta) {\n    return type !== 'display' ? data : DTWidget.formatRound(data, 1, 3, \",\", \".\", null);\n  }"},{"className":"dt-right","targets":2},{"orderable":false,"targets":0},{"name":" ","targets":0},{"name":"Organization","targets":1},{"name":"n","targets":2}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":["options.columnDefs.0.render"],"jsHooks":[]}
```
