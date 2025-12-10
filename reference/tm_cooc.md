# Analyse word co-occurrence in subject lines and return a network plot

This function generates a word co-occurrence network plot, with options
to return a table. This function is used within
[`meeting_tm_report()`](https://microsoft.github.io/vivainsights/reference/meeting_tm_report.md).

## Usage

``` r
tm_cooc(data, stopwords = NULL, seed = 100, return = "plot", lmult = 0.05)
```

## Arguments

- data:

  A Meeting Query dataset in the form of a data frame.

- stopwords:

  A character vector OR a single-column data frame labelled `'word'`
  containing custom stopwords to remove.

- seed:

  A numeric vector to set seed for random generation.

- return:

  String specifying what to return. This must be one of the following
  strings:

  - `"plot"`

  - `"table"`

  See `Value` for more information.

- lmult:

  A multiplier to adjust the line width in the output plot. Defaults to
  0.05.

## Value

A different output is returned depending on the value passed to the
`return` argument:

- `"plot"`: 'ggplot' and 'ggraph' object. A network plot.

- `"table"`: data frame. A summary table.

## Details

This function uses
[`tm_clean()`](https://microsoft.github.io/vivainsights/reference/tm_clean.md)
as the underlying data wrangling function. There is an option to remove
stopwords by passing a data frame into the `stopwords` argument.

## Example

The function can be run with subject lines from `mt_data`, as per below.

    mt_data %>%
      tm_cooc(lmult = 0.01)

## See also

Other Text-mining:
[`meeting_tm_report()`](https://microsoft.github.io/vivainsights/reference/meeting_tm_report.md),
[`pairwise_count()`](https://microsoft.github.io/vivainsights/reference/pairwise_count.md),
[`tm_clean()`](https://microsoft.github.io/vivainsights/reference/tm_clean.md),
[`tm_freq()`](https://microsoft.github.io/vivainsights/reference/tm_freq.md),
[`tm_wordcloud()`](https://microsoft.github.io/vivainsights/reference/tm_wordcloud.md)

## Author

Carlos Morales <carlos.morales@microsoft.com>

## Examples

``` r
# Demo using a subset of `mt_data`
```
