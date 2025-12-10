# Perform a pairwise count of words by id

This is a 'data.table' implementation that mimics the output of
`pairwise_count()` from 'widyr' to reduce package dependency. This is
used internally within
[`tm_cooc()`](https://microsoft.github.io/vivainsights/reference/tm_cooc.md).

## Usage

``` r
pairwise_count(data, id = "line", word = "word")
```

## Arguments

- data:

  Data frame output from
  [`tm_clean()`](https://microsoft.github.io/vivainsights/reference/tm_clean.md).

- id:

  String to represent the id variable. Defaults to `"line"`.

- word:

  String to represent the word variable. Defaults to `"word"`.

## Value

data frame with the following columns representing a pairwise count:

- `"item1"`

- `"item2"`

- `"n"`

## See also

Other Support:
[`any_idate()`](https://microsoft.github.io/vivainsights/reference/any_idate.md),
[`camel_clean()`](https://microsoft.github.io/vivainsights/reference/camel_clean.md),
[`check_inputs()`](https://microsoft.github.io/vivainsights/reference/check_inputs.md),
[`cut_hour()`](https://microsoft.github.io/vivainsights/reference/cut_hour.md),
[`extract_date_range()`](https://microsoft.github.io/vivainsights/reference/extract_date_range.md),
[`extract_hr()`](https://microsoft.github.io/vivainsights/reference/extract_hr.md),
[`heat_colours()`](https://microsoft.github.io/vivainsights/reference/heat_colours.md),
[`is_date_format()`](https://microsoft.github.io/vivainsights/reference/is_date_format.md),
[`maxmin()`](https://microsoft.github.io/vivainsights/reference/maxmin.md),
[`read_preamble()`](https://microsoft.github.io/vivainsights/reference/read_preamble.md),
[`rgb2hex()`](https://microsoft.github.io/vivainsights/reference/rgb2hex.md),
[`totals_bind()`](https://microsoft.github.io/vivainsights/reference/totals_bind.md),
[`totals_col()`](https://microsoft.github.io/vivainsights/reference/totals_col.md),
[`tstamp()`](https://microsoft.github.io/vivainsights/reference/tstamp.md),
[`us_to_space()`](https://microsoft.github.io/vivainsights/reference/us_to_space.md),
[`wrap()`](https://microsoft.github.io/vivainsights/reference/wrap.md)

Other Text-mining:
[`meeting_tm_report()`](https://microsoft.github.io/vivainsights/reference/meeting_tm_report.md),
[`tm_clean()`](https://microsoft.github.io/vivainsights/reference/tm_clean.md),
[`tm_cooc()`](https://microsoft.github.io/vivainsights/reference/tm_cooc.md),
[`tm_freq()`](https://microsoft.github.io/vivainsights/reference/tm_freq.md),
[`tm_wordcloud()`](https://microsoft.github.io/vivainsights/reference/tm_wordcloud.md)

## Examples

``` r
td <- data.frame(line = c(1, 1, 2, 2),
                 word = c("work", "meeting", "catch", "up"))

pairwise_count(td, id = "line", word = "word")
#> # A tibble: 2 × 3
#>   item1 item2       n
#>   <chr> <chr>   <int>
#> 1 work  meeting     1
#> 2 catch up          1
```
