# Generate a Meeting Text Mining report in HTML

Create a text mining report in HTML based on Meeting Subject Lines

## Usage

``` r
meeting_tm_report(
  data,
  path = "meeting text mining report",
  stopwords = NULL,
  timestamp = TRUE,
  keep = 100,
  seed = 100
)
```

## Arguments

- data:

  A Meeting Query dataset in the form of a data frame.

- path:

  Pass the file path and the desired file name, *excluding the file
  extension*. For example, `"meeting text mining report"`.

- stopwords:

  A character vector OR a single-column data frame labelled `'word'`
  containing custom stopwords to remove.

- timestamp:

  Logical vector specifying whether to include a timestamp in the file
  name. Defaults to TRUE.

- keep:

  A numeric vector specifying maximum number of words to keep.

- seed:

  A numeric vector to set seed for random generation.

## Value

An HTML report with the same file name as specified in the arguments is
generated in the working directory. No outputs are directly returned by
the function.

## Details

Note that the column `Subject` must be available within the input data
frame in order to run.d

## How to run

    meeting_tm_report(mt_data)

This will generate a HTML report as specified in `path`.

## See also

Other Reports:
[`IV_report()`](https://microsoft.github.io/vivainsights/reference/IV_report.md),
[`generate_report()`](https://microsoft.github.io/vivainsights/reference/generate_report.md),
[`read_preamble()`](https://microsoft.github.io/vivainsights/reference/read_preamble.md),
[`validation_report()`](https://microsoft.github.io/vivainsights/reference/validation_report.md)

Other Meetings:
[`meeting_dist()`](https://microsoft.github.io/vivainsights/reference/meeting_dist.md),
[`meeting_fizz()`](https://microsoft.github.io/vivainsights/reference/meeting_fizz.md),
[`meeting_line()`](https://microsoft.github.io/vivainsights/reference/meeting_line.md),
[`meeting_rank()`](https://microsoft.github.io/vivainsights/reference/meeting_rank.md),
[`meeting_summary()`](https://microsoft.github.io/vivainsights/reference/meeting_summary.md),
[`meeting_trend()`](https://microsoft.github.io/vivainsights/reference/meeting_trend.md)

Other Text-mining:
[`pairwise_count()`](https://microsoft.github.io/vivainsights/reference/pairwise_count.md),
[`tm_clean()`](https://microsoft.github.io/vivainsights/reference/tm_clean.md),
[`tm_cooc()`](https://microsoft.github.io/vivainsights/reference/tm_cooc.md),
[`tm_freq()`](https://microsoft.github.io/vivainsights/reference/tm_freq.md),
[`tm_wordcloud()`](https://microsoft.github.io/vivainsights/reference/tm_wordcloud.md)
