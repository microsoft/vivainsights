# Clean subject line text prior to analysis

This function processes the `Subject` column in a Meeting Query by
applying tokenisation
using[`tidytext::unnest_tokens()`](https://juliasilge.github.io/tidytext/reference/unnest_tokens.html),
and removing any stopwords supplied in a data frame (using the argument
`stopwords`). This is a sub-function that feeds into
[`tm_freq()`](https://microsoft.github.io/vivainsights/reference/tm_freq.md),
[`tm_cooc()`](https://microsoft.github.io/vivainsights/reference/tm_cooc.md),
and
[`tm_wordcloud()`](https://microsoft.github.io/vivainsights/reference/tm_wordcloud.md).
The default is to return a data frame with tokenised counts of words or
ngrams.

## Usage

``` r
tm_clean(data, token = "words", stopwords = NULL, ...)
```

## Arguments

- data:

  A Meeting Query dataset in the form of a data frame.

- token:

  A character vector accepting either `"words"` or `"ngrams"`,
  determining type of tokenisation to return.

- stopwords:

  A character vector OR a single-column data frame labelled `'word'`
  containing custom stopwords to remove.

- ...:

  Additional parameters to pass to
  [`tidytext::unnest_tokens()`](https://juliasilge.github.io/tidytext/reference/unnest_tokens.html).

## Value

data frame with two columns:

- `line`

- `word`

## See also

Other Text-mining:
[`meeting_tm_report()`](https://microsoft.github.io/vivainsights/reference/meeting_tm_report.md),
[`pairwise_count()`](https://microsoft.github.io/vivainsights/reference/pairwise_count.md),
[`tm_cooc()`](https://microsoft.github.io/vivainsights/reference/tm_cooc.md),
[`tm_freq()`](https://microsoft.github.io/vivainsights/reference/tm_freq.md),
[`tm_wordcloud()`](https://microsoft.github.io/vivainsights/reference/tm_wordcloud.md)

## Examples

``` r
# words
tm_clean(mt_data)
#> # A tibble: 1,039 × 2
#>     line word 
#>    <int> <chr>
#>  1     1 focus
#>  2     1 time 
#>  3     2 focus
#>  4     2 time 
#>  5     3 focus
#>  6     3 time 
#>  7     4 focus
#>  8     4 time 
#>  9     5 focus
#> 10     5 time 
#> # ℹ 1,029 more rows

# ngrams
tm_clean(mt_data, token = "ngrams")
#> # A tibble: 692 × 2
#>     line word 
#>    <int> <chr>
#>  1     1 NA   
#>  2     2 NA   
#>  3     3 NA   
#>  4     4 NA   
#>  5     5 NA   
#>  6     6 NA   
#>  7     7 NA   
#>  8     8 NA   
#>  9     9 NA   
#> 10    10 NA   
#> # ℹ 682 more rows
```
