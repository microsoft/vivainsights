# Export 'vivainsights' outputs to CSV, clipboard, or save as images

A general use function to export 'vivainsights' outputs to CSV,
clipboard, or save as images. By default, `export()` copies a data frame
to the clipboard. If the input is a 'ggplot' object, the default
behaviour is to export a PNG.

## Usage

``` r
export(
  x,
  method = "clipboard",
  path = "insights export",
  timestamp = TRUE,
  width = 12,
  height = 9
)
```

## Arguments

- x:

  Data frame or 'ggplot' object to be passed through.

- method:

  Character string specifying the method of export. Valid inputs
  include:

  - `"clipboard"` (default if input is data frame)

  - `"csv"`

  - `"png"` (default if input is 'ggplot' object)

  - `"svg"`

  - `"jpeg"`

  - `"pdf"`

- path:

  If exporting a file, enter the path and the desired file name,
  *excluding the file extension*. For example, `"Analysis/SQ Overview"`.

- timestamp:

  Logical vector specifying whether to include a timestamp in the file
  name. Defaults to `TRUE`.

- width:

  Width of the plot

- height:

  Height of the plot

## Value

A different output is returned depending on the value passed to the
`method` argument:

- `"clipboard"`: no return - data frame is saved to clipboard.

- `"csv"`: CSV file containing data frame is saved to specified path.

- `"png"`: PNG file containing 'ggplot' object is saved to specified
  path.

- `"svg"`: SVG file containing 'ggplot' object is saved to specified
  path.

- `"jpeg"`: JPEG file containing 'ggplot' object is saved to specified
  path.

- `"pdf"`: PDF file containing 'ggplot' object is saved to specified
  path.

## See also

Other Import and Export:
[`copy_df()`](https://microsoft.github.io/vivainsights/reference/copy_df.md),
[`create_dt()`](https://microsoft.github.io/vivainsights/reference/create_dt.md),
[`import_query()`](https://microsoft.github.io/vivainsights/reference/import_query.md),
[`prep_query()`](https://microsoft.github.io/vivainsights/reference/prep_query.md)

## Author

Martin Chan <martin.chan@microsoft.com>
