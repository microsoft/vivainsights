# Generate HTML report based on existing RMarkdown documents

This is a support function that accepts parameters and creates a HTML
document based on an RMarkdown template. This is an alternative to
[`generate_report()`](https://microsoft.github.io/vivainsights/reference/generate_report.md)
which instead creates an RMarkdown document from scratch using
individual code chunks.

## Usage

``` r
generate_report2(
  output_format = rmarkdown::html_document(toc = TRUE, toc_depth = 6, theme = "cosmo"),
  output_file = "report.html",
  output_dir = getwd(),
  report_title = "Report",
  rmd_dir = system.file("rmd_template/minimal.rmd", package = "vivainsights"),
  ...
)
```

## Arguments

- output_format:

  output format in
  [`rmarkdown::render()`](https://pkgs.rstudio.com/rmarkdown/reference/render.html).
  Default is
  `rmarkdown::html_document(toc = TRUE, toc_depth = 6, theme = "cosmo")`.

- output_file:

  output file name in
  [`rmarkdown::render()`](https://pkgs.rstudio.com/rmarkdown/reference/render.html).
  Default is `"report.html"`.

- output_dir:

  output directory for report in
  [`rmarkdown::render()`](https://pkgs.rstudio.com/rmarkdown/reference/render.html).
  Default is user's current directory.

- report_title:

  report title. Default is `"Report"`.

- rmd_dir:

  string specifying the path to the directory containing the RMarkdown
  template files.

- ...:

  other arguments to be passed to `params`. For instance, pass `hrvar`
  if the RMarkdown document requires a 'hrvar' parameter.

## Note

The implementation of this function was inspired by the 'DataExplorer'
package by boxuancui, with credits due to the original author.
