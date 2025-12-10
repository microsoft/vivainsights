# Generate HTML report with list inputs

This is a support function using a list-pmap workflow to create a HTML
document, using RMarkdown as the engine.

## Usage

``` r
generate_report(
  title = "My minimal HTML generator",
  filename = "minimal_html",
  outputs = output_list,
  titles,
  subheaders,
  echos,
  levels,
  theme = "united",
  preamble = ""
)
```

## Arguments

- title:

  Character string to specify the title of the chunk.

- filename:

  File name to be used in the exported HTML.

- outputs:

  A list of outputs to be added to the HTML report. Note that `outputs`,
  `titles`, `echos`, and `levels` must have the same length

- titles:

  A list/vector of character strings to specify the title of the chunks.

- subheaders:

  A list/vector of character strings to specify the subheaders for each
  chunk.

- echos:

  A list/vector of logical values to specify whether to display code.

- levels:

  A list/vector of numeric value to specify the header level of the
  chunk.

- theme:

  Character vector to specify theme to be used for the report. E.g.
  `"united"`, `"default"`.

- preamble:

  A preamble to appear at the beginning of the report, passed as a text
  string.

## Value

An HTML report with the same file name as specified in the arguments is
generated in the working directory. No outputs are directly returned by
the function.

## Creating a custom report

Below is an example on how to set up a custom report.

The first step is to define the content that will go into a report and
assign the outputs to a list.

    # Step 1: Define Content
    output_list <-
      list(pq_data %>% workloads_summary(return = "plot"),
           pq_data %>% workloads_summary(return = "table")) %>%
      purrr::map_if(is.data.frame, create_dt)

The next step is to add a list of titles for each of the objects on the
list:

    # Step 2: Add Corresponding Titles
    title_list <- c("Workloads Summary - Plot", "Workloads Summary - Table")
    n_title <- length(title_list)

The final step is to run `generate_report()`. This can all be wrapped
within a function such that the function can be used to generate a HTML
report.

    # Step 3: Generate Report
    generate_report(title = "My First Report",
                    filename = "My First Report",
                    outputs = output_list,
                    titles = title_list,
                    subheaders = rep("", n_title),
                    echos = rep(FALSE, n_title

## See also

Other Reports:
[`IV_report()`](https://microsoft.github.io/vivainsights/reference/IV_report.md),
[`meeting_tm_report()`](https://microsoft.github.io/vivainsights/reference/meeting_tm_report.md),
[`read_preamble()`](https://microsoft.github.io/vivainsights/reference/read_preamble.md),
[`validation_report()`](https://microsoft.github.io/vivainsights/reference/validation_report.md)

## Author

Martin Chan <martin.chan@microsoft.com>
