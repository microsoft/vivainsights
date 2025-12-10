# Add comma separator for thousands

Takes a numeric value and returns a character value which is rounded to
the whole number, and adds a comma separator at the thousands. A
convenient wrapper function around
[`round()`](https://rdrr.io/r/base/Round.html) and
[`format()`](https://rdrr.io/r/base/format.html).

## Usage

``` r
comma(x)
```

## Arguments

- x:

  A numeric value

## Value

Returns a formatted string.
