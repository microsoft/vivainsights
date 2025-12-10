# Generate a wordcloud with meeting subject lines

Generate a wordcloud with the meeting query. This is a sub-function that
feeds into
[`meeting_tm_report()`](https://microsoft.github.io/vivainsights/reference/meeting_tm_report.md).

## Usage

``` r
tm_wordcloud(
  data,
  stopwords = NULL,
  seed = 100,
  keep = 100,
  return = "plot",
  ...
)
```

## Arguments

- data:

  A Meeting Query dataset in the form of a data frame.

- stopwords:

  A character vector OR a single-column data frame labelled `'word'`
  containing custom stopwords to remove.

- seed:

  A numeric vector to set seed for random generation.

- keep:

  A numeric vector specifying maximum number of words to keep.

- return:

  String specifying what to return. This must be one of the following
  strings:

  - `"plot"`

  - `"table"`

  See `Value` for more information.

- ...:

  Additional parameters to be passed to
  [`ggwordcloud::geom_text_wordcloud()`](https://lepennec.github.io/ggwordcloud/reference/geom_text_wordcloud.html)

## Value

A different output is returned depending on the value passed to the
`return` argument:

- `"plot"`: 'ggplot' object containing a word cloud.

- `"table"`: data frame returning the data used to generate the word
  cloud.

## Details

Uses the 'ggwordcloud' package for the underlying implementation, thus
returning a 'ggplot' object. Additional layers can be added onto the
plot using a ggplot `+` syntax. The recommendation is not to return over
100 words in a word cloud.

This function uses
[`tm_clean()`](https://microsoft.github.io/vivainsights/reference/tm_clean.md)
as the underlying data wrangling function. There is an option to remove
stopwords by passing a data frame into the `stopwords` argument.

## See also

Other Text-mining:
[`meeting_tm_report()`](https://microsoft.github.io/vivainsights/reference/meeting_tm_report.md),
[`pairwise_count()`](https://microsoft.github.io/vivainsights/reference/pairwise_count.md),
[`tm_clean()`](https://microsoft.github.io/vivainsights/reference/tm_clean.md),
[`tm_cooc()`](https://microsoft.github.io/vivainsights/reference/tm_cooc.md),
[`tm_freq()`](https://microsoft.github.io/vivainsights/reference/tm_freq.md)

## Examples

``` r
tm_wordcloud(mt_data, keep = 30)


# Removing stopwords
tm_wordcloud(mt_data, keep = 30, stopwords = c("weekly", "update"))

```
