# Main theme for 'vivainsights' visualisations

A theme function applied to 'ggplot' visualisations in 'vivainsights'.
Install and load 'extrafont' to use custom fonts for plotting.

## Usage

``` r
theme_wpa(font_size = 12, font_family = "Segoe UI")
```

## Arguments

- font_size:

  Numeric value that prescribes the base font size for the plot. The
  text elements are defined relatively to this base font size. Defaults
  to 12.

- font_family:

  Character value specifying the font family to be used in the plot. The
  default value is `"Segoe UI"`. To ensure you can use this font,
  install and load 'extrafont' prior to plotting. There is an
  initialisation process that is described by:
  <https://stackoverflow.com/questions/34522732/changing-fonts-in-ggplot2>

## Value

Returns a ggplot object with the applied theme.

## See also

Other Themes:
[`theme_wpa_basic()`](https://microsoft.github.io/vivainsights/reference/theme_wpa_basic.md)
