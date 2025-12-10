# Wrap text based on character threshold

Wrap text in visualizations according to a preset character threshold.
The next space in the string is replaced with `\n`, which will render as
next line in plots and messages.

## Usage

``` r
wrap_text(x, threshold = 15)
```

## Arguments

- x:

  String to wrap text

- threshold:

  Numeric, defaults to 15. Number of character units by which the next
  space would be replaced with `\n` to move text to next line.

## Value

String output representing a processed version of `x`, with spaces
replaced by `\n.`

## Examples

``` r
wrapped <- wrap_text(
  "The total entropy of an isolated system can never decrease."
  )
message(wrapped)
#> The total
#> entropy of an
#> isolated system
#> can never
#> decrease.
```
