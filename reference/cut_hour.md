# Convert a numeric variable for hours into categorical

Supply a numeric variable, e.g. `Collaboration_hours`, and return a
character vector.

## Usage

``` r
cut_hour(metric, cuts, unit = "hours", lbound = 0, ubound = 100)
```

## Arguments

- metric:

  A numeric variable representing hours.

- cuts:

  A numeric vector of minimum length 3 to represent the cut points
  required. The minimum and maximum values provided in the vector are
  inclusive.

- unit:

  String to specify the unit of the labels. Defaults to "hours".

- lbound:

  Numeric. Specifies the lower bound (inclusive) value for the minimum
  label. Defaults to 0.

- ubound:

  Numeric. Specifies the upper bound (inclusive) value for the maximum
  label. Defaults to 100.

## Value

Character vector representing a converted categorical variable, appended
with the label of the unit. See `examples` for more information.

## Details

This is used within
[`create_dist()`](https://microsoft.github.io/vivainsights/reference/create_dist.md)
for numeric to categorical conversion.

## See also

Other Support:
[`any_idate()`](https://microsoft.github.io/vivainsights/reference/any_idate.md),
[`camel_clean()`](https://microsoft.github.io/vivainsights/reference/camel_clean.md),
[`check_inputs()`](https://microsoft.github.io/vivainsights/reference/check_inputs.md),
[`extract_date_range()`](https://microsoft.github.io/vivainsights/reference/extract_date_range.md),
[`extract_hr()`](https://microsoft.github.io/vivainsights/reference/extract_hr.md),
[`heat_colours()`](https://microsoft.github.io/vivainsights/reference/heat_colours.md),
[`is_date_format()`](https://microsoft.github.io/vivainsights/reference/is_date_format.md),
[`maxmin()`](https://microsoft.github.io/vivainsights/reference/maxmin.md),
[`pairwise_count()`](https://microsoft.github.io/vivainsights/reference/pairwise_count.md),
[`read_preamble()`](https://microsoft.github.io/vivainsights/reference/read_preamble.md),
[`rgb2hex()`](https://microsoft.github.io/vivainsights/reference/rgb2hex.md),
[`totals_bind()`](https://microsoft.github.io/vivainsights/reference/totals_bind.md),
[`totals_col()`](https://microsoft.github.io/vivainsights/reference/totals_col.md),
[`tstamp()`](https://microsoft.github.io/vivainsights/reference/tstamp.md),
[`us_to_space()`](https://microsoft.github.io/vivainsights/reference/us_to_space.md),
[`wrap()`](https://microsoft.github.io/vivainsights/reference/wrap.md)

## Examples

``` r
# Direct use
cut_hour(1:30, cuts = c(15, 20, 25))
#>  [1] < 15 hours    < 15 hours    < 15 hours    < 15 hours    < 15 hours   
#>  [6] < 15 hours    < 15 hours    < 15 hours    < 15 hours    < 15 hours   
#> [11] < 15 hours    < 15 hours    < 15 hours    < 15 hours    < 15 hours   
#> [16] 15 - 20 hours 15 - 20 hours 15 - 20 hours 15 - 20 hours 15 - 20 hours
#> [21] 20 - 25 hours 20 - 25 hours 20 - 25 hours 20 - 25 hours 20 - 25 hours
#> [26] 25+ hours     25+ hours     25+ hours     25+ hours     25+ hours    
#> Levels: < 15 hours 15 - 20 hours 20 - 25 hours 25+ hours

# Use on a query
cut_hour(pq_data$Collaboration_hours, cuts = c(10, 15, 20), ubound = 150)
#>    [1] 10 - 15 hours 20+ hours     20+ hours     10 - 15 hours 15 - 20 hours
#>    [6] 20+ hours     10 - 15 hours 20+ hours     15 - 20 hours 15 - 20 hours
#>   [11] 20+ hours     20+ hours     20+ hours     15 - 20 hours 20+ hours    
#>   [16] 10 - 15 hours 20+ hours     20+ hours     20+ hours     15 - 20 hours
#>   [21] 20+ hours     15 - 20 hours 15 - 20 hours 20+ hours     20+ hours    
#>   [26] 20+ hours     20+ hours     20+ hours     20+ hours     15 - 20 hours
#>   [31] 15 - 20 hours 20+ hours     10 - 15 hours 10 - 15 hours 20+ hours    
#>   [36] 20+ hours     20+ hours     15 - 20 hours 20+ hours     20+ hours    
#>   [41] 20+ hours     20+ hours     20+ hours     20+ hours     < 10 hours   
#>   [46] 20+ hours     20+ hours     20+ hours     10 - 15 hours 20+ hours    
#>   [51] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#>   [56] 20+ hours     15 - 20 hours 20+ hours     20+ hours     20+ hours    
#>   [61] 20+ hours     10 - 15 hours 20+ hours     15 - 20 hours 20+ hours    
#>   [66] 20+ hours     20+ hours     20+ hours     20+ hours     15 - 20 hours
#>   [71] 15 - 20 hours 20+ hours     20+ hours     15 - 20 hours 20+ hours    
#>   [76] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#>   [81] 15 - 20 hours 10 - 15 hours 15 - 20 hours 20+ hours     20+ hours    
#>   [86] 15 - 20 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#>   [91] 20+ hours     15 - 20 hours 20+ hours     20+ hours     15 - 20 hours
#>   [96] 20+ hours     20+ hours     20+ hours     20+ hours     15 - 20 hours
#>  [101] 10 - 15 hours 20+ hours     20+ hours     10 - 15 hours 15 - 20 hours
#>  [106] 20+ hours     15 - 20 hours 20+ hours     15 - 20 hours 20+ hours    
#>  [111] 20+ hours     20+ hours     20+ hours     20+ hours     15 - 20 hours
#>  [116] 10 - 15 hours 15 - 20 hours 10 - 15 hours 10 - 15 hours 20+ hours    
#>  [121] 20+ hours     15 - 20 hours 20+ hours     20+ hours     20+ hours    
#>  [126] 20+ hours     20+ hours     20+ hours     10 - 15 hours 20+ hours    
#>  [131] 15 - 20 hours 15 - 20 hours 20+ hours     20+ hours     20+ hours    
#>  [136] 15 - 20 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#>  [141] 20+ hours     10 - 15 hours 20+ hours     20+ hours     20+ hours    
#>  [146] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#>  [151] 20+ hours     15 - 20 hours 20+ hours     20+ hours     20+ hours    
#>  [156] 15 - 20 hours 20+ hours     < 10 hours    20+ hours     20+ hours    
#>  [161] 10 - 15 hours 20+ hours     10 - 15 hours 20+ hours     20+ hours    
#>  [166] 15 - 20 hours 20+ hours     15 - 20 hours 10 - 15 hours 15 - 20 hours
#>  [171] 20+ hours     15 - 20 hours 20+ hours     20+ hours     20+ hours    
#>  [176] 20+ hours     20+ hours     15 - 20 hours 20+ hours     20+ hours    
#>  [181] 15 - 20 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#>  [186] 20+ hours     20+ hours     20+ hours     20+ hours     15 - 20 hours
#>  [191] 20+ hours     20+ hours     20+ hours     15 - 20 hours 15 - 20 hours
#>  [196] 20+ hours     20+ hours     20+ hours     10 - 15 hours 20+ hours    
#>  [201] 20+ hours     20+ hours     15 - 20 hours 20+ hours     20+ hours    
#>  [206] 20+ hours     10 - 15 hours 20+ hours     20+ hours     15 - 20 hours
#>  [211] 20+ hours     20+ hours     15 - 20 hours 20+ hours     10 - 15 hours
#>  [216] 20+ hours     10 - 15 hours 20+ hours     20+ hours     20+ hours    
#>  [221] 20+ hours     15 - 20 hours 20+ hours     15 - 20 hours 20+ hours    
#>  [226] 20+ hours     15 - 20 hours 20+ hours     15 - 20 hours 20+ hours    
#>  [231] 20+ hours     20+ hours     15 - 20 hours 20+ hours     20+ hours    
#>  [236] 20+ hours     20+ hours     15 - 20 hours 20+ hours     20+ hours    
#>  [241] 10 - 15 hours 15 - 20 hours 20+ hours     20+ hours     20+ hours    
#>  [246] 20+ hours     10 - 15 hours 20+ hours     20+ hours     20+ hours    
#>  [251] 20+ hours     < 10 hours    20+ hours     20+ hours     20+ hours    
#>  [256] 15 - 20 hours 20+ hours     20+ hours     10 - 15 hours 20+ hours    
#>  [261] 20+ hours     15 - 20 hours 10 - 15 hours 20+ hours     20+ hours    
#>  [266] 15 - 20 hours 20+ hours     15 - 20 hours < 10 hours    20+ hours    
#>  [271] 20+ hours     20+ hours     20+ hours     15 - 20 hours 20+ hours    
#>  [276] 15 - 20 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#>  [281] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#>  [286] 20+ hours     10 - 15 hours 20+ hours     20+ hours     15 - 20 hours
#>  [291] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#>  [296] 20+ hours     20+ hours     10 - 15 hours 20+ hours     15 - 20 hours
#>  [301] 15 - 20 hours 15 - 20 hours 15 - 20 hours 10 - 15 hours < 10 hours   
#>  [306] 20+ hours     20+ hours     15 - 20 hours 20+ hours     15 - 20 hours
#>  [311] 20+ hours     20+ hours     10 - 15 hours 20+ hours     15 - 20 hours
#>  [316] 20+ hours     20+ hours     15 - 20 hours 20+ hours     15 - 20 hours
#>  [321] 20+ hours     20+ hours     15 - 20 hours 20+ hours     15 - 20 hours
#>  [326] 20+ hours     15 - 20 hours 20+ hours     15 - 20 hours 10 - 15 hours
#>  [331] 15 - 20 hours 20+ hours     10 - 15 hours 20+ hours     20+ hours    
#>  [336] 20+ hours     20+ hours     20+ hours     20+ hours     10 - 15 hours
#>  [341] 20+ hours     20+ hours     10 - 15 hours 15 - 20 hours 15 - 20 hours
#>  [346] 20+ hours     20+ hours     20+ hours     15 - 20 hours 15 - 20 hours
#>  [351] 20+ hours     15 - 20 hours < 10 hours    15 - 20 hours 20+ hours    
#>  [356] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#>  [361] 20+ hours     20+ hours     20+ hours     20+ hours     15 - 20 hours
#>  [366] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#>  [371] 20+ hours     20+ hours     15 - 20 hours 15 - 20 hours 20+ hours    
#>  [376] 15 - 20 hours 20+ hours     20+ hours     15 - 20 hours 20+ hours    
#>  [381] 15 - 20 hours 20+ hours     20+ hours     20+ hours     15 - 20 hours
#>  [386] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#>  [391] 20+ hours     15 - 20 hours 10 - 15 hours 20+ hours     20+ hours    
#>  [396] 20+ hours     20+ hours     10 - 15 hours 10 - 15 hours 20+ hours    
#>  [401] 10 - 15 hours 20+ hours     20+ hours     15 - 20 hours 20+ hours    
#>  [406] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#>  [411] 20+ hours     15 - 20 hours 15 - 20 hours 20+ hours     20+ hours    
#>  [416] 15 - 20 hours 20+ hours     20+ hours     15 - 20 hours 15 - 20 hours
#>  [421] 15 - 20 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#>  [426] 20+ hours     15 - 20 hours 20+ hours     15 - 20 hours 20+ hours    
#>  [431] 15 - 20 hours 15 - 20 hours 20+ hours     15 - 20 hours 20+ hours    
#>  [436] 20+ hours     15 - 20 hours 20+ hours     20+ hours     20+ hours    
#>  [441] 20+ hours     20+ hours     20+ hours     15 - 20 hours 15 - 20 hours
#>  [446] 20+ hours     15 - 20 hours 20+ hours     20+ hours     20+ hours    
#>  [451] 20+ hours     10 - 15 hours 20+ hours     15 - 20 hours 20+ hours    
#>  [456] 20+ hours     15 - 20 hours 20+ hours     20+ hours     20+ hours    
#>  [461] 15 - 20 hours 15 - 20 hours 20+ hours     20+ hours     10 - 15 hours
#>  [466] 20+ hours     10 - 15 hours 15 - 20 hours 20+ hours     20+ hours    
#>  [471] 15 - 20 hours 15 - 20 hours 15 - 20 hours 15 - 20 hours 20+ hours    
#>  [476] 20+ hours     20+ hours     20+ hours     20+ hours     15 - 20 hours
#>  [481] 20+ hours     15 - 20 hours 20+ hours     15 - 20 hours 15 - 20 hours
#>  [486] 20+ hours     15 - 20 hours 15 - 20 hours 15 - 20 hours 20+ hours    
#>  [491] 15 - 20 hours 20+ hours     15 - 20 hours 20+ hours     15 - 20 hours
#>  [496] 10 - 15 hours 20+ hours     10 - 15 hours 20+ hours     15 - 20 hours
#>  [501] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#>  [506] 20+ hours     20+ hours     20+ hours     20+ hours     15 - 20 hours
#>  [511] 15 - 20 hours 20+ hours     20+ hours     20+ hours     15 - 20 hours
#>  [516] < 10 hours    20+ hours     20+ hours     20+ hours     20+ hours    
#>  [521] 15 - 20 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#>  [526] 20+ hours     20+ hours     20+ hours     20+ hours     15 - 20 hours
#>  [531] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#>  [536] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#>  [541] 20+ hours     20+ hours     15 - 20 hours 20+ hours     20+ hours    
#>  [546] 15 - 20 hours 10 - 15 hours 20+ hours     20+ hours     20+ hours    
#>  [551] 20+ hours     10 - 15 hours 20+ hours     15 - 20 hours 20+ hours    
#>  [556] 20+ hours     20+ hours     15 - 20 hours 20+ hours     20+ hours    
#>  [561] 20+ hours     10 - 15 hours 15 - 20 hours 20+ hours     10 - 15 hours
#>  [566] 20+ hours     15 - 20 hours 20+ hours     20+ hours     20+ hours    
#>  [571] 10 - 15 hours 15 - 20 hours 20+ hours     20+ hours     20+ hours    
#>  [576] 10 - 15 hours 15 - 20 hours 15 - 20 hours 10 - 15 hours 15 - 20 hours
#>  [581] 15 - 20 hours 20+ hours     20+ hours     20+ hours     15 - 20 hours
#>  [586] 20+ hours     15 - 20 hours 20+ hours     20+ hours     10 - 15 hours
#>  [591] 20+ hours     20+ hours     20+ hours     15 - 20 hours 15 - 20 hours
#>  [596] 20+ hours     20+ hours     20+ hours     15 - 20 hours 20+ hours    
#>  [601] 20+ hours     20+ hours     15 - 20 hours 20+ hours     20+ hours    
#>  [606] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#>  [611] 20+ hours     10 - 15 hours 20+ hours     20+ hours     15 - 20 hours
#>  [616] 20+ hours     20+ hours     20+ hours     10 - 15 hours 15 - 20 hours
#>  [621] 20+ hours     20+ hours     < 10 hours    20+ hours     15 - 20 hours
#>  [626] 15 - 20 hours 20+ hours     15 - 20 hours 20+ hours     15 - 20 hours
#>  [631] 15 - 20 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#>  [636] 10 - 15 hours 20+ hours     15 - 20 hours 15 - 20 hours 20+ hours    
#>  [641] 20+ hours     15 - 20 hours 20+ hours     20+ hours     20+ hours    
#>  [646] 20+ hours     15 - 20 hours 20+ hours     20+ hours     15 - 20 hours
#>  [651] 20+ hours     20+ hours     10 - 15 hours 20+ hours     15 - 20 hours
#>  [656] 15 - 20 hours 10 - 15 hours 20+ hours     20+ hours     20+ hours    
#>  [661] 20+ hours     15 - 20 hours 20+ hours     15 - 20 hours 20+ hours    
#>  [666] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#>  [671] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#>  [676] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#>  [681] 20+ hours     20+ hours     15 - 20 hours 20+ hours     20+ hours    
#>  [686] 20+ hours     20+ hours     15 - 20 hours 20+ hours     15 - 20 hours
#>  [691] 20+ hours     15 - 20 hours 20+ hours     20+ hours     20+ hours    
#>  [696] 15 - 20 hours 20+ hours     20+ hours     20+ hours     < 10 hours   
#>  [701] 10 - 15 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#>  [706] 20+ hours     20+ hours     15 - 20 hours 15 - 20 hours 20+ hours    
#>  [711] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#>  [716] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#>  [721] 20+ hours     20+ hours     15 - 20 hours 10 - 15 hours 20+ hours    
#>  [726] 20+ hours     15 - 20 hours < 10 hours    20+ hours     20+ hours    
#>  [731] 20+ hours     15 - 20 hours 20+ hours     20+ hours     15 - 20 hours
#>  [736] 15 - 20 hours 20+ hours     20+ hours     20+ hours     10 - 15 hours
#>  [741] 15 - 20 hours 15 - 20 hours 15 - 20 hours 20+ hours     15 - 20 hours
#>  [746] 10 - 15 hours 20+ hours     20+ hours     20+ hours     10 - 15 hours
#>  [751] 20+ hours     10 - 15 hours 20+ hours     20+ hours     20+ hours    
#>  [756] 15 - 20 hours 20+ hours     15 - 20 hours 15 - 20 hours 20+ hours    
#>  [761] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#>  [766] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#>  [771] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#>  [776] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#>  [781] 20+ hours     20+ hours     15 - 20 hours 20+ hours     20+ hours    
#>  [786] 15 - 20 hours 20+ hours     20+ hours     20+ hours     15 - 20 hours
#>  [791] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#>  [796] 20+ hours     20+ hours     20+ hours     15 - 20 hours 15 - 20 hours
#>  [801] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#>  [806] 10 - 15 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#>  [811] 15 - 20 hours 10 - 15 hours 20+ hours     20+ hours     20+ hours    
#>  [816] 20+ hours     15 - 20 hours 20+ hours     20+ hours     20+ hours    
#>  [821] 15 - 20 hours 20+ hours     15 - 20 hours 20+ hours     15 - 20 hours
#>  [826] 10 - 15 hours 10 - 15 hours 15 - 20 hours 20+ hours     20+ hours    
#>  [831] < 10 hours    20+ hours     15 - 20 hours 20+ hours     15 - 20 hours
#>  [836] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#>  [841] 20+ hours     15 - 20 hours 15 - 20 hours 20+ hours     20+ hours    
#>  [846] 20+ hours     15 - 20 hours 20+ hours     20+ hours     20+ hours    
#>  [851] 20+ hours     20+ hours     10 - 15 hours 20+ hours     15 - 20 hours
#>  [856] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#>  [861] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#>  [866] 20+ hours     20+ hours     15 - 20 hours 15 - 20 hours 20+ hours    
#>  [871] 20+ hours     15 - 20 hours 10 - 15 hours 20+ hours     15 - 20 hours
#>  [876] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#>  [881] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#>  [886] 20+ hours     15 - 20 hours 20+ hours     20+ hours     20+ hours    
#>  [891] 20+ hours     15 - 20 hours 20+ hours     15 - 20 hours 20+ hours    
#>  [896] 20+ hours     15 - 20 hours 20+ hours     15 - 20 hours 20+ hours    
#>  [901] 15 - 20 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#>  [906] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#>  [911] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#>  [916] 20+ hours     15 - 20 hours 20+ hours     20+ hours     20+ hours    
#>  [921] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#>  [926] 15 - 20 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#>  [931] 20+ hours     15 - 20 hours 20+ hours     20+ hours     20+ hours    
#>  [936] 20+ hours     20+ hours     20+ hours     20+ hours     15 - 20 hours
#>  [941] 15 - 20 hours 15 - 20 hours 15 - 20 hours 20+ hours     15 - 20 hours
#>  [946] 20+ hours     15 - 20 hours 20+ hours     20+ hours     < 10 hours   
#>  [951] 20+ hours     10 - 15 hours 20+ hours     20+ hours     20+ hours    
#>  [956] 15 - 20 hours 20+ hours     15 - 20 hours 20+ hours     10 - 15 hours
#>  [961] 15 - 20 hours 20+ hours     20+ hours     20+ hours     10 - 15 hours
#>  [966] 20+ hours     15 - 20 hours 15 - 20 hours 20+ hours     20+ hours    
#>  [971] 20+ hours     20+ hours     15 - 20 hours 20+ hours     15 - 20 hours
#>  [976] 20+ hours     20+ hours     10 - 15 hours 15 - 20 hours 10 - 15 hours
#>  [981] 20+ hours     15 - 20 hours 20+ hours     20+ hours     20+ hours    
#>  [986] 10 - 15 hours 20+ hours     20+ hours     10 - 15 hours 20+ hours    
#>  [991] 20+ hours     15 - 20 hours 15 - 20 hours 20+ hours     20+ hours    
#>  [996] 10 - 15 hours 20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [1001] 20+ hours     20+ hours     < 10 hours    20+ hours     20+ hours    
#> [1006] 15 - 20 hours 20+ hours     10 - 15 hours 10 - 15 hours 20+ hours    
#> [1011] 20+ hours     15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [1016] 20+ hours     20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [1021] 15 - 20 hours 20+ hours     < 10 hours    15 - 20 hours 20+ hours    
#> [1026] 15 - 20 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [1031] 15 - 20 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [1036] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [1041] 20+ hours     15 - 20 hours 20+ hours     10 - 15 hours 15 - 20 hours
#> [1046] 15 - 20 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [1051] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [1056] 20+ hours     20+ hours     15 - 20 hours 15 - 20 hours 20+ hours    
#> [1061] 20+ hours     15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [1066] 15 - 20 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [1071] 15 - 20 hours 20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [1076] 15 - 20 hours 20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [1081] 20+ hours     10 - 15 hours 20+ hours     20+ hours     20+ hours    
#> [1086] 20+ hours     20+ hours     10 - 15 hours 20+ hours     20+ hours    
#> [1091] 15 - 20 hours 20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [1096] 15 - 20 hours 15 - 20 hours 20+ hours     15 - 20 hours 20+ hours    
#> [1101] 20+ hours     15 - 20 hours 20+ hours     20+ hours     15 - 20 hours
#> [1106] 20+ hours     20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [1111] 20+ hours     15 - 20 hours 20+ hours     15 - 20 hours 15 - 20 hours
#> [1116] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [1121] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [1126] 15 - 20 hours 15 - 20 hours 15 - 20 hours 10 - 15 hours 15 - 20 hours
#> [1131] 20+ hours     20+ hours     20+ hours     < 10 hours    20+ hours    
#> [1136] 20+ hours     15 - 20 hours 15 - 20 hours 15 - 20 hours 20+ hours    
#> [1141] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [1146] 20+ hours     15 - 20 hours 20+ hours     15 - 20 hours 15 - 20 hours
#> [1151] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [1156] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [1161] 15 - 20 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [1166] 15 - 20 hours 20+ hours     10 - 15 hours 20+ hours     20+ hours    
#> [1171] 15 - 20 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [1176] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [1181] 20+ hours     20+ hours     10 - 15 hours 10 - 15 hours 20+ hours    
#> [1186] 20+ hours     20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [1191] 20+ hours     20+ hours     15 - 20 hours 20+ hours     15 - 20 hours
#> [1196] 15 - 20 hours < 10 hours    15 - 20 hours 15 - 20 hours < 10 hours   
#> [1201] 20+ hours     20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [1206] 20+ hours     20+ hours     20+ hours     10 - 15 hours 20+ hours    
#> [1211] 20+ hours     20+ hours     20+ hours     20+ hours     10 - 15 hours
#> [1216] 20+ hours     20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [1221] 20+ hours     20+ hours     10 - 15 hours 20+ hours     15 - 20 hours
#> [1226] 20+ hours     20+ hours     15 - 20 hours 20+ hours     15 - 20 hours
#> [1231] 20+ hours     15 - 20 hours 20+ hours     20+ hours     15 - 20 hours
#> [1236] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [1241] 15 - 20 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [1246] 20+ hours     20+ hours     10 - 15 hours 15 - 20 hours 15 - 20 hours
#> [1251] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [1256] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [1261] 20+ hours     20+ hours     15 - 20 hours 10 - 15 hours 20+ hours    
#> [1266] 15 - 20 hours 15 - 20 hours 20+ hours     20+ hours     15 - 20 hours
#> [1271] 15 - 20 hours 15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [1276] 20+ hours     20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [1281] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [1286] 15 - 20 hours 20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [1291] 15 - 20 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [1296] 20+ hours     20+ hours     10 - 15 hours 20+ hours     20+ hours    
#> [1301] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [1306] 20+ hours     15 - 20 hours 20+ hours     20+ hours     15 - 20 hours
#> [1311] 15 - 20 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [1316] 20+ hours     15 - 20 hours 20+ hours     20+ hours     10 - 15 hours
#> [1321] 15 - 20 hours 20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [1326] < 10 hours    20+ hours     20+ hours     20+ hours     20+ hours    
#> [1331] 20+ hours     15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [1336] 20+ hours     10 - 15 hours 20+ hours     20+ hours     15 - 20 hours
#> [1341] 15 - 20 hours 20+ hours     10 - 15 hours 20+ hours     20+ hours    
#> [1346] 15 - 20 hours 15 - 20 hours 20+ hours     15 - 20 hours 20+ hours    
#> [1351] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [1356] 15 - 20 hours 20+ hours     15 - 20 hours 10 - 15 hours 20+ hours    
#> [1361] 20+ hours     20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [1366] 15 - 20 hours 20+ hours     20+ hours     10 - 15 hours 20+ hours    
#> [1371] 15 - 20 hours 20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [1376] 15 - 20 hours 15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [1381] 20+ hours     15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [1386] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [1391] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [1396] 20+ hours     20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [1401] 20+ hours     20+ hours     10 - 15 hours 15 - 20 hours 15 - 20 hours
#> [1406] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [1411] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [1416] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [1421] 20+ hours     20+ hours     15 - 20 hours 15 - 20 hours 15 - 20 hours
#> [1426] 20+ hours     10 - 15 hours 20+ hours     10 - 15 hours 15 - 20 hours
#> [1431] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [1436] 20+ hours     20+ hours     15 - 20 hours 20+ hours     15 - 20 hours
#> [1441] 15 - 20 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [1446] 20+ hours     20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [1451] 20+ hours     20+ hours     15 - 20 hours 20+ hours     10 - 15 hours
#> [1456] 20+ hours     20+ hours     10 - 15 hours 20+ hours     20+ hours    
#> [1461] 15 - 20 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [1466] 15 - 20 hours 15 - 20 hours 15 - 20 hours 20+ hours     15 - 20 hours
#> [1471] 20+ hours     20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [1476] 20+ hours     20+ hours     20+ hours     10 - 15 hours 20+ hours    
#> [1481] 15 - 20 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [1486] 20+ hours     20+ hours     20+ hours     10 - 15 hours 20+ hours    
#> [1491] 20+ hours     15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [1496] 15 - 20 hours 15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [1501] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [1506] 20+ hours     15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [1511] 20+ hours     20+ hours     10 - 15 hours 15 - 20 hours 20+ hours    
#> [1516] 15 - 20 hours 20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [1521] 20+ hours     20+ hours     15 - 20 hours 20+ hours     < 10 hours   
#> [1526] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [1531] 20+ hours     15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [1536] 20+ hours     20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [1541] 20+ hours     15 - 20 hours 15 - 20 hours 15 - 20 hours 20+ hours    
#> [1546] 20+ hours     20+ hours     20+ hours     20+ hours     10 - 15 hours
#> [1551] 20+ hours     15 - 20 hours 20+ hours     20+ hours     15 - 20 hours
#> [1556] 20+ hours     20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [1561] 15 - 20 hours 20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [1566] 20+ hours     20+ hours     20+ hours     10 - 15 hours 20+ hours    
#> [1571] 20+ hours     20+ hours     15 - 20 hours 20+ hours     10 - 15 hours
#> [1576] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [1581] 20+ hours     20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [1586] 15 - 20 hours 20+ hours     15 - 20 hours 20+ hours     15 - 20 hours
#> [1591] 15 - 20 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [1596] 20+ hours     20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [1601] 15 - 20 hours 20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [1606] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [1611] 15 - 20 hours 20+ hours     20+ hours     10 - 15 hours 10 - 15 hours
#> [1616] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [1621] 15 - 20 hours 20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [1626] 20+ hours     20+ hours     10 - 15 hours 20+ hours     20+ hours    
#> [1631] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [1636] 20+ hours     20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [1641] 20+ hours     10 - 15 hours 20+ hours     15 - 20 hours 20+ hours    
#> [1646] 20+ hours     20+ hours     10 - 15 hours 20+ hours     20+ hours    
#> [1651] 10 - 15 hours 15 - 20 hours 20+ hours     10 - 15 hours 20+ hours    
#> [1656] 10 - 15 hours 20+ hours     15 - 20 hours < 10 hours    20+ hours    
#> [1661] 10 - 15 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [1666] 15 - 20 hours 15 - 20 hours 20+ hours     20+ hours     10 - 15 hours
#> [1671] 20+ hours     15 - 20 hours 15 - 20 hours 10 - 15 hours 15 - 20 hours
#> [1676] 20+ hours     20+ hours     15 - 20 hours 20+ hours     15 - 20 hours
#> [1681] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [1686] 20+ hours     15 - 20 hours 20+ hours     20+ hours     10 - 15 hours
#> [1691] 20+ hours     20+ hours     10 - 15 hours 20+ hours     15 - 20 hours
#> [1696] 15 - 20 hours 15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [1701] 15 - 20 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [1706] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [1711] 20+ hours     20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [1716] 15 - 20 hours 20+ hours     20+ hours     20+ hours     10 - 15 hours
#> [1721] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [1726] 20+ hours     20+ hours     < 10 hours    20+ hours     20+ hours    
#> [1731] 20+ hours     10 - 15 hours 10 - 15 hours 20+ hours     15 - 20 hours
#> [1736] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [1741] 20+ hours     20+ hours     20+ hours     20+ hours     < 10 hours   
#> [1746] 15 - 20 hours 20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [1751] 20+ hours     15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [1756] 20+ hours     20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [1761] 20+ hours     20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [1766] 15 - 20 hours 20+ hours     15 - 20 hours 15 - 20 hours 20+ hours    
#> [1771] 20+ hours     20+ hours     20+ hours     15 - 20 hours < 10 hours   
#> [1776] 15 - 20 hours 20+ hours     20+ hours     15 - 20 hours 10 - 15 hours
#> [1781] 20+ hours     15 - 20 hours 15 - 20 hours 10 - 15 hours 20+ hours    
#> [1786] 20+ hours     15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [1791] 20+ hours     20+ hours     10 - 15 hours 20+ hours     20+ hours    
#> [1796] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [1801] 15 - 20 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [1806] 20+ hours     10 - 15 hours 15 - 20 hours 20+ hours     20+ hours    
#> [1811] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [1816] 15 - 20 hours 15 - 20 hours 15 - 20 hours 15 - 20 hours 10 - 15 hours
#> [1821] 15 - 20 hours 20+ hours     10 - 15 hours 20+ hours     20+ hours    
#> [1826] 20+ hours     20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [1831] 20+ hours     20+ hours     15 - 20 hours 20+ hours     10 - 15 hours
#> [1836] 15 - 20 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [1841] 20+ hours     20+ hours     20+ hours     10 - 15 hours 20+ hours    
#> [1846] 15 - 20 hours 15 - 20 hours 20+ hours     20+ hours     15 - 20 hours
#> [1851] 20+ hours     20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [1856] 20+ hours     20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [1861] 10 - 15 hours 20+ hours     10 - 15 hours 20+ hours     20+ hours    
#> [1866] 20+ hours     10 - 15 hours 10 - 15 hours 15 - 20 hours 20+ hours    
#> [1871] 20+ hours     20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [1876] 15 - 20 hours 20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [1881] 20+ hours     15 - 20 hours 15 - 20 hours 15 - 20 hours 15 - 20 hours
#> [1886] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [1891] 20+ hours     15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [1896] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [1901] 15 - 20 hours 15 - 20 hours 15 - 20 hours 20+ hours     10 - 15 hours
#> [1906] 20+ hours     20+ hours     15 - 20 hours 15 - 20 hours 20+ hours    
#> [1911] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [1916] 20+ hours     15 - 20 hours 15 - 20 hours 20+ hours     20+ hours    
#> [1921] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [1926] 20+ hours     20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [1931] 20+ hours     15 - 20 hours 20+ hours     < 10 hours    15 - 20 hours
#> [1936] 15 - 20 hours 20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [1941] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [1946] 20+ hours     15 - 20 hours 20+ hours     20+ hours     15 - 20 hours
#> [1951] 20+ hours     20+ hours     15 - 20 hours 20+ hours     15 - 20 hours
#> [1956] 15 - 20 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [1961] 10 - 15 hours 20+ hours     10 - 15 hours 10 - 15 hours 15 - 20 hours
#> [1966] 20+ hours     20+ hours     20+ hours     15 - 20 hours 10 - 15 hours
#> [1971] 20+ hours     15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [1976] 10 - 15 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [1981] 20+ hours     20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [1986] 20+ hours     15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [1991] 20+ hours     20+ hours     10 - 15 hours 15 - 20 hours 10 - 15 hours
#> [1996] 20+ hours     15 - 20 hours 15 - 20 hours 20+ hours     20+ hours    
#> [2001] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [2006] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [2011] 20+ hours     20+ hours     20+ hours     20+ hours     10 - 15 hours
#> [2016] 20+ hours     20+ hours     20+ hours     10 - 15 hours 20+ hours    
#> [2021] 20+ hours     20+ hours     15 - 20 hours 20+ hours     15 - 20 hours
#> [2026] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [2031] 15 - 20 hours 20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [2036] 20+ hours     15 - 20 hours 15 - 20 hours 10 - 15 hours 20+ hours    
#> [2041] 15 - 20 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [2046] 15 - 20 hours 20+ hours     15 - 20 hours 20+ hours     15 - 20 hours
#> [2051] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [2056] 15 - 20 hours 20+ hours     15 - 20 hours 10 - 15 hours 20+ hours    
#> [2061] 20+ hours     10 - 15 hours 20+ hours     < 10 hours    20+ hours    
#> [2066] 20+ hours     20+ hours     15 - 20 hours < 10 hours    20+ hours    
#> [2071] 20+ hours     10 - 15 hours 20+ hours     20+ hours     20+ hours    
#> [2076] 20+ hours     20+ hours     15 - 20 hours 10 - 15 hours 15 - 20 hours
#> [2081] 15 - 20 hours 20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [2086] 20+ hours     20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [2091] 20+ hours     20+ hours     15 - 20 hours 15 - 20 hours 20+ hours    
#> [2096] 20+ hours     20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [2101] 20+ hours     20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [2106] 20+ hours     20+ hours     15 - 20 hours 20+ hours     10 - 15 hours
#> [2111] 20+ hours     15 - 20 hours 20+ hours     15 - 20 hours 15 - 20 hours
#> [2116] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [2121] 10 - 15 hours 15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [2126] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [2131] 20+ hours     20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [2136] 20+ hours     15 - 20 hours 20+ hours     15 - 20 hours 20+ hours    
#> [2141] 20+ hours     20+ hours     15 - 20 hours 15 - 20 hours < 10 hours   
#> [2146] 15 - 20 hours 10 - 15 hours 20+ hours     15 - 20 hours 20+ hours    
#> [2151] 20+ hours     20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [2156] 15 - 20 hours 20+ hours     15 - 20 hours 15 - 20 hours 20+ hours    
#> [2161] 20+ hours     20+ hours     10 - 15 hours 20+ hours     15 - 20 hours
#> [2166] 15 - 20 hours 10 - 15 hours 20+ hours     20+ hours     20+ hours    
#> [2171] 15 - 20 hours 20+ hours     20+ hours     15 - 20 hours 15 - 20 hours
#> [2176] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [2181] 20+ hours     15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [2186] 20+ hours     15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [2191] 20+ hours     20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [2196] 20+ hours     15 - 20 hours 20+ hours     10 - 15 hours 15 - 20 hours
#> [2201] 20+ hours     20+ hours     10 - 15 hours 20+ hours     20+ hours    
#> [2206] 20+ hours     15 - 20 hours 10 - 15 hours 10 - 15 hours 20+ hours    
#> [2211] 20+ hours     15 - 20 hours 20+ hours     15 - 20 hours 15 - 20 hours
#> [2216] 10 - 15 hours 20+ hours     15 - 20 hours 20+ hours     15 - 20 hours
#> [2221] 20+ hours     20+ hours     10 - 15 hours 10 - 15 hours 20+ hours    
#> [2226] 10 - 15 hours 20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [2231] 10 - 15 hours 10 - 15 hours 20+ hours     20+ hours     20+ hours    
#> [2236] 15 - 20 hours 20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [2241] 20+ hours     20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [2246] 20+ hours     15 - 20 hours 20+ hours     20+ hours     15 - 20 hours
#> [2251] 20+ hours     10 - 15 hours 20+ hours     20+ hours     20+ hours    
#> [2256] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [2261] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [2266] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [2271] 20+ hours     20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [2276] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [2281] 15 - 20 hours 20+ hours     10 - 15 hours 20+ hours     20+ hours    
#> [2286] 15 - 20 hours 15 - 20 hours 20+ hours     15 - 20 hours 20+ hours    
#> [2291] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [2296] 20+ hours     20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [2301] 10 - 15 hours 20+ hours     20+ hours     20+ hours     10 - 15 hours
#> [2306] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [2311] 20+ hours     15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [2316] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [2321] 20+ hours     10 - 15 hours 20+ hours     20+ hours     15 - 20 hours
#> [2326] 20+ hours     20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [2331] 20+ hours     20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [2336] 20+ hours     20+ hours     20+ hours     20+ hours     10 - 15 hours
#> [2341] 20+ hours     20+ hours     20+ hours     20+ hours     10 - 15 hours
#> [2346] 20+ hours     20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [2351] 15 - 20 hours 15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [2356] 20+ hours     10 - 15 hours 20+ hours     20+ hours     15 - 20 hours
#> [2361] 15 - 20 hours 20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [2366] 20+ hours     20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [2371] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [2376] 20+ hours     20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [2381] 15 - 20 hours 15 - 20 hours 20+ hours     15 - 20 hours 20+ hours    
#> [2386] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [2391] 20+ hours     10 - 15 hours 15 - 20 hours 20+ hours     20+ hours    
#> [2396] 20+ hours     15 - 20 hours 20+ hours     20+ hours     15 - 20 hours
#> [2401] 15 - 20 hours 20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [2406] 20+ hours     < 10 hours    20+ hours     15 - 20 hours 20+ hours    
#> [2411] 20+ hours     20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [2416] 20+ hours     20+ hours     20+ hours     20+ hours     10 - 15 hours
#> [2421] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [2426] 20+ hours     20+ hours     15 - 20 hours 20+ hours     10 - 15 hours
#> [2431] 10 - 15 hours 20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [2436] 15 - 20 hours 20+ hours     15 - 20 hours 20+ hours     15 - 20 hours
#> [2441] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [2446] 20+ hours     20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [2451] 20+ hours     20+ hours     20+ hours     10 - 15 hours 20+ hours    
#> [2456] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [2461] 20+ hours     20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [2466] 20+ hours     15 - 20 hours 20+ hours     15 - 20 hours 20+ hours    
#> [2471] 20+ hours     20+ hours     20+ hours     10 - 15 hours 15 - 20 hours
#> [2476] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [2481] 20+ hours     10 - 15 hours 20+ hours     20+ hours     20+ hours    
#> [2486] 20+ hours     20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [2491] 15 - 20 hours 15 - 20 hours 15 - 20 hours 20+ hours     20+ hours    
#> [2496] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [2501] 15 - 20 hours 20+ hours     15 - 20 hours 20+ hours     10 - 15 hours
#> [2506] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [2511] 20+ hours     20+ hours     10 - 15 hours 15 - 20 hours 20+ hours    
#> [2516] < 10 hours    20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [2521] 20+ hours     20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [2526] 20+ hours     15 - 20 hours 15 - 20 hours 20+ hours     20+ hours    
#> [2531] 20+ hours     15 - 20 hours 20+ hours     20+ hours     15 - 20 hours
#> [2536] 15 - 20 hours 20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [2541] 15 - 20 hours 15 - 20 hours 20+ hours     < 10 hours    20+ hours    
#> [2546] 20+ hours     20+ hours     15 - 20 hours 15 - 20 hours 15 - 20 hours
#> [2551] 20+ hours     20+ hours     10 - 15 hours < 10 hours    20+ hours    
#> [2556] 15 - 20 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [2561] 15 - 20 hours 20+ hours     15 - 20 hours 15 - 20 hours 15 - 20 hours
#> [2566] 15 - 20 hours 20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [2571] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [2576] 20+ hours     15 - 20 hours 20+ hours     20+ hours     < 10 hours   
#> [2581] 15 - 20 hours 15 - 20 hours 15 - 20 hours 20+ hours     20+ hours    
#> [2586] 20+ hours     20+ hours     10 - 15 hours 20+ hours     20+ hours    
#> [2591] 15 - 20 hours 20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [2596] 20+ hours     20+ hours     15 - 20 hours 15 - 20 hours 10 - 15 hours
#> [2601] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [2606] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [2611] 20+ hours     20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [2616] 20+ hours     20+ hours     20+ hours     15 - 20 hours 15 - 20 hours
#> [2621] 15 - 20 hours 10 - 15 hours 20+ hours     20+ hours     20+ hours    
#> [2626] 20+ hours     20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [2631] 20+ hours     20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [2636] 20+ hours     20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [2641] 20+ hours     15 - 20 hours 20+ hours     20+ hours     10 - 15 hours
#> [2646] 15 - 20 hours 15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [2651] 10 - 15 hours 10 - 15 hours 20+ hours     20+ hours     20+ hours    
#> [2656] 20+ hours     10 - 15 hours 20+ hours     15 - 20 hours 20+ hours    
#> [2661] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [2666] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [2671] 20+ hours     20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [2676] 10 - 15 hours 15 - 20 hours 20+ hours     20+ hours     10 - 15 hours
#> [2681] 10 - 15 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [2686] 15 - 20 hours 20+ hours     10 - 15 hours 10 - 15 hours 10 - 15 hours
#> [2691] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [2696] 15 - 20 hours 15 - 20 hours 20+ hours     15 - 20 hours 20+ hours    
#> [2701] 20+ hours     15 - 20 hours 10 - 15 hours 20+ hours     20+ hours    
#> [2706] 20+ hours     20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [2711] 20+ hours     20+ hours     15 - 20 hours 10 - 15 hours 15 - 20 hours
#> [2716] 20+ hours     20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [2721] 15 - 20 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [2726] 20+ hours     20+ hours     20+ hours     20+ hours     10 - 15 hours
#> [2731] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [2736] 20+ hours     20+ hours     15 - 20 hours 20+ hours     15 - 20 hours
#> [2741] 20+ hours     20+ hours     15 - 20 hours 20+ hours     15 - 20 hours
#> [2746] 20+ hours     15 - 20 hours 15 - 20 hours 20+ hours     10 - 15 hours
#> [2751] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [2756] 20+ hours     20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [2761] 20+ hours     15 - 20 hours 20+ hours     15 - 20 hours 20+ hours    
#> [2766] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [2771] 15 - 20 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [2776] 20+ hours     20+ hours     15 - 20 hours 15 - 20 hours < 10 hours   
#> [2781] 20+ hours     20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [2786] 20+ hours     20+ hours     15 - 20 hours 10 - 15 hours 20+ hours    
#> [2791] 20+ hours     20+ hours     20+ hours     < 10 hours    20+ hours    
#> [2796] 20+ hours     15 - 20 hours 15 - 20 hours 20+ hours     20+ hours    
#> [2801] 10 - 15 hours 10 - 15 hours 15 - 20 hours 20+ hours     20+ hours    
#> [2806] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [2811] 20+ hours     15 - 20 hours 20+ hours     10 - 15 hours 15 - 20 hours
#> [2816] 15 - 20 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [2821] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [2826] 20+ hours     15 - 20 hours 15 - 20 hours 20+ hours     20+ hours    
#> [2831] 20+ hours     10 - 15 hours 20+ hours     20+ hours     20+ hours    
#> [2836] 15 - 20 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [2841] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [2846] 20+ hours     15 - 20 hours 15 - 20 hours 20+ hours     15 - 20 hours
#> [2851] 15 - 20 hours 10 - 15 hours 20+ hours     20+ hours     20+ hours    
#> [2856] 20+ hours     20+ hours     10 - 15 hours 20+ hours     20+ hours    
#> [2861] 20+ hours     20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [2866] 15 - 20 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [2871] 10 - 15 hours 15 - 20 hours 15 - 20 hours 20+ hours     20+ hours    
#> [2876] 20+ hours     10 - 15 hours 10 - 15 hours 15 - 20 hours 15 - 20 hours
#> [2881] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [2886] 10 - 15 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [2891] 20+ hours     15 - 20 hours 15 - 20 hours 20+ hours     20+ hours    
#> [2896] 15 - 20 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [2901] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [2906] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [2911] 15 - 20 hours 20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [2916] 20+ hours     20+ hours     20+ hours     15 - 20 hours 15 - 20 hours
#> [2921] 20+ hours     20+ hours     20+ hours     20+ hours     10 - 15 hours
#> [2926] 20+ hours     20+ hours     10 - 15 hours 20+ hours     15 - 20 hours
#> [2931] 15 - 20 hours 10 - 15 hours 20+ hours     15 - 20 hours 20+ hours    
#> [2936] 20+ hours     20+ hours     20+ hours     20+ hours     10 - 15 hours
#> [2941] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [2946] 20+ hours     20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [2951] 20+ hours     20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [2956] 20+ hours     20+ hours     < 10 hours    15 - 20 hours 20+ hours    
#> [2961] 15 - 20 hours 10 - 15 hours 20+ hours     20+ hours     15 - 20 hours
#> [2966] 15 - 20 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [2971] 20+ hours     20+ hours     20+ hours     15 - 20 hours 10 - 15 hours
#> [2976] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [2981] 20+ hours     20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [2986] 10 - 15 hours 20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [2991] 20+ hours     15 - 20 hours 15 - 20 hours 20+ hours     10 - 15 hours
#> [2996] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [3001] 10 - 15 hours 15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [3006] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [3011] 20+ hours     15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [3016] 20+ hours     10 - 15 hours 10 - 15 hours 20+ hours     20+ hours    
#> [3021] 15 - 20 hours 20+ hours     15 - 20 hours 15 - 20 hours 15 - 20 hours
#> [3026] 15 - 20 hours 20+ hours     20+ hours     10 - 15 hours 20+ hours    
#> [3031] 20+ hours     20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [3036] 20+ hours     20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [3041] 20+ hours     20+ hours     15 - 20 hours 10 - 15 hours 15 - 20 hours
#> [3046] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [3051] 20+ hours     20+ hours     20+ hours     15 - 20 hours 15 - 20 hours
#> [3056] 15 - 20 hours 15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [3061] 15 - 20 hours 20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [3066] 10 - 15 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [3071] 20+ hours     20+ hours     < 10 hours    15 - 20 hours 15 - 20 hours
#> [3076] 20+ hours     15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [3081] 20+ hours     20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [3086] 15 - 20 hours 20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [3091] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [3096] 15 - 20 hours 15 - 20 hours 15 - 20 hours 10 - 15 hours 20+ hours    
#> [3101] 15 - 20 hours 15 - 20 hours 10 - 15 hours 15 - 20 hours 20+ hours    
#> [3106] 20+ hours     20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [3111] 20+ hours     20+ hours     20+ hours     10 - 15 hours 20+ hours    
#> [3116] 20+ hours     20+ hours     20+ hours     < 10 hours    20+ hours    
#> [3121] 20+ hours     20+ hours     15 - 20 hours 10 - 15 hours 15 - 20 hours
#> [3126] 20+ hours     20+ hours     20+ hours     20+ hours     < 10 hours   
#> [3131] 20+ hours     20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [3136] 20+ hours     20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [3141] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [3146] 15 - 20 hours 20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [3151] 20+ hours     20+ hours     20+ hours     10 - 15 hours 20+ hours    
#> [3156] 15 - 20 hours 15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [3161] 20+ hours     15 - 20 hours 10 - 15 hours 20+ hours     20+ hours    
#> [3166] 20+ hours     20+ hours     20+ hours     20+ hours     10 - 15 hours
#> [3171] 10 - 15 hours 20+ hours     15 - 20 hours 20+ hours     15 - 20 hours
#> [3176] 20+ hours     15 - 20 hours 15 - 20 hours 20+ hours     20+ hours    
#> [3181] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [3186] 15 - 20 hours 15 - 20 hours 20+ hours     20+ hours     15 - 20 hours
#> [3191] 20+ hours     15 - 20 hours 20+ hours     15 - 20 hours 15 - 20 hours
#> [3196] 20+ hours     20+ hours     20+ hours     20+ hours     10 - 15 hours
#> [3201] 20+ hours     20+ hours     15 - 20 hours 15 - 20 hours 15 - 20 hours
#> [3206] 20+ hours     20+ hours     15 - 20 hours 15 - 20 hours 10 - 15 hours
#> [3211] 20+ hours     15 - 20 hours 20+ hours     20+ hours     10 - 15 hours
#> [3216] 20+ hours     15 - 20 hours 20+ hours     15 - 20 hours 15 - 20 hours
#> [3221] 20+ hours     20+ hours     10 - 15 hours 20+ hours     20+ hours    
#> [3226] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [3231] 20+ hours     15 - 20 hours 15 - 20 hours 20+ hours     20+ hours    
#> [3236] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [3241] 20+ hours     15 - 20 hours 20+ hours     15 - 20 hours 20+ hours    
#> [3246] 20+ hours     15 - 20 hours 15 - 20 hours 20+ hours     20+ hours    
#> [3251] 10 - 15 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [3256] 10 - 15 hours 15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [3261] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [3266] 15 - 20 hours 20+ hours     15 - 20 hours 20+ hours     15 - 20 hours
#> [3271] < 10 hours    15 - 20 hours 15 - 20 hours 20+ hours     20+ hours    
#> [3276] 20+ hours     20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [3281] 15 - 20 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [3286] 20+ hours     20+ hours     15 - 20 hours 15 - 20 hours 20+ hours    
#> [3291] 15 - 20 hours 20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [3296] 10 - 15 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [3301] 15 - 20 hours 20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [3306] 20+ hours     20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [3311] 20+ hours     20+ hours     10 - 15 hours 15 - 20 hours 20+ hours    
#> [3316] 20+ hours     20+ hours     20+ hours     < 10 hours    20+ hours    
#> [3321] 20+ hours     20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [3326] 20+ hours     20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [3331] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [3336] 20+ hours     15 - 20 hours 20+ hours     15 - 20 hours 20+ hours    
#> [3341] 20+ hours     20+ hours     10 - 15 hours 20+ hours     20+ hours    
#> [3346] 20+ hours     20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [3351] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [3356] 15 - 20 hours 20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [3361] 20+ hours     15 - 20 hours 20+ hours     20+ hours     15 - 20 hours
#> [3366] 10 - 15 hours 20+ hours     10 - 15 hours 20+ hours     20+ hours    
#> [3371] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [3376] 20+ hours     20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [3381] 20+ hours     20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [3386] 20+ hours     20+ hours     20+ hours     15 - 20 hours 15 - 20 hours
#> [3391] 20+ hours     20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [3396] 15 - 20 hours 20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [3401] 20+ hours     20+ hours     15 - 20 hours 20+ hours     15 - 20 hours
#> [3406] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [3411] 20+ hours     20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [3416] 20+ hours     15 - 20 hours 20+ hours     15 - 20 hours 20+ hours    
#> [3421] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [3426] 20+ hours     15 - 20 hours 15 - 20 hours 20+ hours     20+ hours    
#> [3431] 20+ hours     15 - 20 hours 20+ hours     15 - 20 hours < 10 hours   
#> [3436] 20+ hours     15 - 20 hours 15 - 20 hours 20+ hours     20+ hours    
#> [3441] 20+ hours     < 10 hours    15 - 20 hours 15 - 20 hours 20+ hours    
#> [3446] 20+ hours     20+ hours     20+ hours     20+ hours     10 - 15 hours
#> [3451] < 10 hours    20+ hours     20+ hours     20+ hours     20+ hours    
#> [3456] 15 - 20 hours < 10 hours    20+ hours     20+ hours     20+ hours    
#> [3461] 10 - 15 hours 20+ hours     10 - 15 hours 20+ hours     20+ hours    
#> [3466] 10 - 15 hours 20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [3471] 20+ hours     20+ hours     15 - 20 hours 20+ hours     10 - 15 hours
#> [3476] 20+ hours     15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [3481] 15 - 20 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [3486] 20+ hours     15 - 20 hours 15 - 20 hours 20+ hours     10 - 15 hours
#> [3491] 15 - 20 hours < 10 hours    20+ hours     20+ hours     < 10 hours   
#> [3496] 20+ hours     10 - 15 hours 20+ hours     20+ hours     20+ hours    
#> [3501] 20+ hours     15 - 20 hours 20+ hours     20+ hours     15 - 20 hours
#> [3506] 20+ hours     15 - 20 hours 20+ hours     20+ hours     15 - 20 hours
#> [3511] 20+ hours     20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [3516] 15 - 20 hours 20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [3521] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [3526] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [3531] 15 - 20 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [3536] 20+ hours     < 10 hours    20+ hours     20+ hours     20+ hours    
#> [3541] 20+ hours     15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [3546] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [3551] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [3556] 20+ hours     20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [3561] 20+ hours     20+ hours     20+ hours     15 - 20 hours 10 - 15 hours
#> [3566] 20+ hours     20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [3571] 15 - 20 hours 15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [3576] 20+ hours     10 - 15 hours 15 - 20 hours 20+ hours     20+ hours    
#> [3581] 20+ hours     20+ hours     15 - 20 hours 20+ hours     15 - 20 hours
#> [3586] 20+ hours     20+ hours     20+ hours     20+ hours     10 - 15 hours
#> [3591] 20+ hours     10 - 15 hours 15 - 20 hours 20+ hours     20+ hours    
#> [3596] 20+ hours     15 - 20 hours 10 - 15 hours 15 - 20 hours 15 - 20 hours
#> [3601] 15 - 20 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [3606] 20+ hours     20+ hours     15 - 20 hours 20+ hours     < 10 hours   
#> [3611] 20+ hours     15 - 20 hours 15 - 20 hours 20+ hours     15 - 20 hours
#> [3616] 20+ hours     10 - 15 hours 15 - 20 hours 10 - 15 hours 15 - 20 hours
#> [3621] 20+ hours     15 - 20 hours 15 - 20 hours 20+ hours     15 - 20 hours
#> [3626] 20+ hours     20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [3631] 10 - 15 hours 15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [3636] 20+ hours     20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [3641] 20+ hours     15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [3646] < 10 hours    15 - 20 hours 20+ hours     15 - 20 hours 15 - 20 hours
#> [3651] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [3656] 20+ hours     20+ hours     20+ hours     20+ hours     10 - 15 hours
#> [3661] 20+ hours     20+ hours     10 - 15 hours 15 - 20 hours 20+ hours    
#> [3666] 20+ hours     < 10 hours    < 10 hours    20+ hours     20+ hours    
#> [3671] 20+ hours     20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [3676] 20+ hours     20+ hours     20+ hours     20+ hours     10 - 15 hours
#> [3681] 10 - 15 hours 15 - 20 hours 20+ hours     15 - 20 hours 20+ hours    
#> [3686] 20+ hours     15 - 20 hours 20+ hours     15 - 20 hours 20+ hours    
#> [3691] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [3696] 20+ hours     15 - 20 hours 20+ hours     10 - 15 hours 20+ hours    
#> [3701] 20+ hours     10 - 15 hours 15 - 20 hours 20+ hours     20+ hours    
#> [3706] 20+ hours     15 - 20 hours 20+ hours     < 10 hours    20+ hours    
#> [3711] 20+ hours     15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [3716] 20+ hours     10 - 15 hours 20+ hours     10 - 15 hours 20+ hours    
#> [3721] 20+ hours     20+ hours     10 - 15 hours 20+ hours     20+ hours    
#> [3726] 10 - 15 hours 20+ hours     20+ hours     20+ hours     10 - 15 hours
#> [3731] 15 - 20 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [3736] 20+ hours     20+ hours     20+ hours     10 - 15 hours 20+ hours    
#> [3741] 15 - 20 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [3746] 20+ hours     20+ hours     15 - 20 hours 10 - 15 hours 20+ hours    
#> [3751] 20+ hours     10 - 15 hours 20+ hours     20+ hours     20+ hours    
#> [3756] 15 - 20 hours 10 - 15 hours 20+ hours     20+ hours     15 - 20 hours
#> [3761] 15 - 20 hours 15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [3766] 20+ hours     20+ hours     15 - 20 hours 10 - 15 hours 20+ hours    
#> [3771] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [3776] 20+ hours     20+ hours     20+ hours     15 - 20 hours 15 - 20 hours
#> [3781] 20+ hours     20+ hours     20+ hours     10 - 15 hours 20+ hours    
#> [3786] 15 - 20 hours 20+ hours     10 - 15 hours 20+ hours     10 - 15 hours
#> [3791] 10 - 15 hours 20+ hours     20+ hours     10 - 15 hours < 10 hours   
#> [3796] 20+ hours     20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [3801] 20+ hours     20+ hours     15 - 20 hours 15 - 20 hours 15 - 20 hours
#> [3806] 15 - 20 hours 20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [3811] 15 - 20 hours 15 - 20 hours 20+ hours     20+ hours     < 10 hours   
#> [3816] 20+ hours     20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [3821] 15 - 20 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [3826] < 10 hours    20+ hours     20+ hours     20+ hours     20+ hours    
#> [3831] 20+ hours     20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [3836] 15 - 20 hours 20+ hours     20+ hours     20+ hours     < 10 hours   
#> [3841] 20+ hours     15 - 20 hours 15 - 20 hours 20+ hours     20+ hours    
#> [3846] 15 - 20 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [3851] 15 - 20 hours 20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [3856] 20+ hours     15 - 20 hours 20+ hours     20+ hours     15 - 20 hours
#> [3861] 20+ hours     20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [3866] 15 - 20 hours 15 - 20 hours 20+ hours     20+ hours     15 - 20 hours
#> [3871] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [3876] 15 - 20 hours 20+ hours     20+ hours     15 - 20 hours 15 - 20 hours
#> [3881] 15 - 20 hours 15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [3886] 20+ hours     20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [3891] 20+ hours     10 - 15 hours 15 - 20 hours 20+ hours     20+ hours    
#> [3896] 20+ hours     20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [3901] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [3906] 20+ hours     15 - 20 hours 20+ hours     15 - 20 hours 20+ hours    
#> [3911] 15 - 20 hours 15 - 20 hours 20+ hours     15 - 20 hours 15 - 20 hours
#> [3916] 20+ hours     20+ hours     20+ hours     < 10 hours    15 - 20 hours
#> [3921] 15 - 20 hours 15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [3926] 15 - 20 hours 20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [3931] 20+ hours     15 - 20 hours 15 - 20 hours 20+ hours     20+ hours    
#> [3936] 20+ hours     20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [3941] 20+ hours     20+ hours     20+ hours     15 - 20 hours 15 - 20 hours
#> [3946] 10 - 15 hours 20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [3951] < 10 hours    20+ hours     20+ hours     20+ hours     10 - 15 hours
#> [3956] 20+ hours     15 - 20 hours 20+ hours     15 - 20 hours 15 - 20 hours
#> [3961] 20+ hours     15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [3966] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [3971] 20+ hours     20+ hours     < 10 hours    20+ hours     15 - 20 hours
#> [3976] 15 - 20 hours 15 - 20 hours < 10 hours    15 - 20 hours 20+ hours    
#> [3981] 10 - 15 hours 15 - 20 hours 15 - 20 hours 20+ hours     20+ hours    
#> [3986] 20+ hours     20+ hours     20+ hours     10 - 15 hours 20+ hours    
#> [3991] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [3996] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [4001] 20+ hours     10 - 15 hours 20+ hours     15 - 20 hours 20+ hours    
#> [4006] 10 - 15 hours 20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [4011] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [4016] 15 - 20 hours 15 - 20 hours 15 - 20 hours 10 - 15 hours 20+ hours    
#> [4021] 15 - 20 hours 15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [4026] 20+ hours     15 - 20 hours 15 - 20 hours 20+ hours     20+ hours    
#> [4031] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [4036] 20+ hours     20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [4041] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [4046] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [4051] 20+ hours     20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [4056] 20+ hours     15 - 20 hours 20+ hours     20+ hours     10 - 15 hours
#> [4061] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [4066] 15 - 20 hours 10 - 15 hours 10 - 15 hours 10 - 15 hours 20+ hours    
#> [4071] 20+ hours     15 - 20 hours 15 - 20 hours 15 - 20 hours 15 - 20 hours
#> [4076] 20+ hours     20+ hours     20+ hours     15 - 20 hours 15 - 20 hours
#> [4081] 20+ hours     15 - 20 hours 20+ hours     10 - 15 hours 15 - 20 hours
#> [4086] 20+ hours     20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [4091] 15 - 20 hours 20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [4096] < 10 hours    20+ hours     20+ hours     20+ hours     20+ hours    
#> [4101] 15 - 20 hours 20+ hours     20+ hours     15 - 20 hours 15 - 20 hours
#> [4106] 15 - 20 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [4111] 10 - 15 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [4116] 20+ hours     15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [4121] 15 - 20 hours 20+ hours     20+ hours     20+ hours     10 - 15 hours
#> [4126] 20+ hours     20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [4131] 20+ hours     10 - 15 hours 20+ hours     15 - 20 hours 20+ hours    
#> [4136] 20+ hours     20+ hours     15 - 20 hours < 10 hours    20+ hours    
#> [4141] 10 - 15 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [4146] 20+ hours     15 - 20 hours 20+ hours     20+ hours     15 - 20 hours
#> [4151] 20+ hours     15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [4156] 10 - 15 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [4161] 20+ hours     20+ hours     20+ hours     15 - 20 hours 15 - 20 hours
#> [4166] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [4171] 20+ hours     20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [4176] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [4181] 20+ hours     < 10 hours    20+ hours     15 - 20 hours 15 - 20 hours
#> [4186] 20+ hours     15 - 20 hours 20+ hours     15 - 20 hours 20+ hours    
#> [4191] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [4196] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [4201] 15 - 20 hours 20+ hours     10 - 15 hours 20+ hours     15 - 20 hours
#> [4206] 15 - 20 hours 15 - 20 hours 20+ hours     15 - 20 hours 20+ hours    
#> [4211] 10 - 15 hours 20+ hours     10 - 15 hours 15 - 20 hours 20+ hours    
#> [4216] 15 - 20 hours 20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [4221] 20+ hours     10 - 15 hours 20+ hours     20+ hours     20+ hours    
#> [4226] 20+ hours     15 - 20 hours 20+ hours     10 - 15 hours 20+ hours    
#> [4231] 20+ hours     20+ hours     15 - 20 hours 15 - 20 hours 20+ hours    
#> [4236] 20+ hours     20+ hours     10 - 15 hours 20+ hours     15 - 20 hours
#> [4241] 10 - 15 hours 10 - 15 hours 20+ hours     20+ hours     15 - 20 hours
#> [4246] 20+ hours     15 - 20 hours 20+ hours     15 - 20 hours 20+ hours    
#> [4251] 20+ hours     20+ hours     20+ hours     20+ hours     < 10 hours   
#> [4256] 20+ hours     20+ hours     20+ hours     15 - 20 hours 10 - 15 hours
#> [4261] 15 - 20 hours 20+ hours     20+ hours     < 10 hours    20+ hours    
#> [4266] 20+ hours     15 - 20 hours 20+ hours     10 - 15 hours 20+ hours    
#> [4271] 10 - 15 hours 20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [4276] < 10 hours    10 - 15 hours 10 - 15 hours 20+ hours     10 - 15 hours
#> [4281] 10 - 15 hours 20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [4286] 20+ hours     20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [4291] 20+ hours     15 - 20 hours 20+ hours     15 - 20 hours 20+ hours    
#> [4296] 10 - 15 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [4301] 20+ hours     20+ hours     10 - 15 hours 15 - 20 hours 20+ hours    
#> [4306] 20+ hours     20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [4311] 10 - 15 hours 20+ hours     20+ hours     15 - 20 hours 15 - 20 hours
#> [4316] 20+ hours     10 - 15 hours 20+ hours     20+ hours     15 - 20 hours
#> [4321] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [4326] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [4331] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [4336] 20+ hours     20+ hours     20+ hours     10 - 15 hours 20+ hours    
#> [4341] 20+ hours     20+ hours     15 - 20 hours 15 - 20 hours 20+ hours    
#> [4346] 10 - 15 hours 20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [4351] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [4356] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [4361] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [4366] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [4371] 20+ hours     20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [4376] 20+ hours     15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [4381] 15 - 20 hours 15 - 20 hours 10 - 15 hours 15 - 20 hours 20+ hours    
#> [4386] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [4391] 15 - 20 hours < 10 hours    20+ hours     20+ hours     15 - 20 hours
#> [4396] 20+ hours     15 - 20 hours 20+ hours     20+ hours     15 - 20 hours
#> [4401] 20+ hours     15 - 20 hours 15 - 20 hours 20+ hours     10 - 15 hours
#> [4406] 15 - 20 hours 20+ hours     20+ hours     15 - 20 hours 15 - 20 hours
#> [4411] 10 - 15 hours 20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [4416] 20+ hours     20+ hours     10 - 15 hours 20+ hours     10 - 15 hours
#> [4421] 20+ hours     20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [4426] 20+ hours     15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [4431] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [4436] 20+ hours     20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [4441] 20+ hours     20+ hours     20+ hours     10 - 15 hours < 10 hours   
#> [4446] 20+ hours     20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [4451] 20+ hours     20+ hours     15 - 20 hours 15 - 20 hours 20+ hours    
#> [4456] 20+ hours     15 - 20 hours 20+ hours     20+ hours     10 - 15 hours
#> [4461] 10 - 15 hours 20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [4466] 20+ hours     15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [4471] 20+ hours     20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [4476] 15 - 20 hours 20+ hours     20+ hours     15 - 20 hours 10 - 15 hours
#> [4481] 15 - 20 hours 20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [4486] 10 - 15 hours 20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [4491] 15 - 20 hours 20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [4496] 20+ hours     15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [4501] 15 - 20 hours 15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [4506] 20+ hours     15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [4511] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [4516] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [4521] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [4526] 20+ hours     15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [4531] 20+ hours     15 - 20 hours 20+ hours     20+ hours     15 - 20 hours
#> [4536] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [4541] 10 - 15 hours < 10 hours    20+ hours     20+ hours     10 - 15 hours
#> [4546] 20+ hours     20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [4551] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [4556] 20+ hours     20+ hours     10 - 15 hours 15 - 20 hours 20+ hours    
#> [4561] 15 - 20 hours 15 - 20 hours 15 - 20 hours 20+ hours     20+ hours    
#> [4566] 15 - 20 hours 15 - 20 hours 20+ hours     10 - 15 hours 20+ hours    
#> [4571] 20+ hours     20+ hours     15 - 20 hours 15 - 20 hours 20+ hours    
#> [4576] 20+ hours     20+ hours     10 - 15 hours 15 - 20 hours 20+ hours    
#> [4581] 20+ hours     20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [4586] 20+ hours     15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [4591] 15 - 20 hours 15 - 20 hours 15 - 20 hours < 10 hours    15 - 20 hours
#> [4596] 20+ hours     20+ hours     15 - 20 hours 20+ hours     15 - 20 hours
#> [4601] 20+ hours     < 10 hours    20+ hours     15 - 20 hours 20+ hours    
#> [4606] 15 - 20 hours 10 - 15 hours 20+ hours     20+ hours     15 - 20 hours
#> [4611] 20+ hours     20+ hours     20+ hours     10 - 15 hours 15 - 20 hours
#> [4616] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [4621] 20+ hours     10 - 15 hours 15 - 20 hours 20+ hours     20+ hours    
#> [4626] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [4631] 20+ hours     15 - 20 hours 10 - 15 hours 20+ hours     20+ hours    
#> [4636] < 10 hours    10 - 15 hours 20+ hours     20+ hours     15 - 20 hours
#> [4641] 15 - 20 hours 10 - 15 hours 20+ hours     20+ hours     20+ hours    
#> [4646] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [4651] 20+ hours     20+ hours     15 - 20 hours 15 - 20 hours 20+ hours    
#> [4656] < 10 hours    20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [4661] 15 - 20 hours 15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [4666] 10 - 15 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [4671] 20+ hours     15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [4676] 20+ hours     20+ hours     15 - 20 hours 20+ hours     15 - 20 hours
#> [4681] 15 - 20 hours 15 - 20 hours 20+ hours     20+ hours     15 - 20 hours
#> [4686] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [4691] 15 - 20 hours 20+ hours     15 - 20 hours 20+ hours     15 - 20 hours
#> [4696] 20+ hours     15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [4701] 20+ hours     20+ hours     15 - 20 hours 15 - 20 hours 10 - 15 hours
#> [4706] 20+ hours     20+ hours     20+ hours     20+ hours     10 - 15 hours
#> [4711] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [4716] 20+ hours     20+ hours     15 - 20 hours 20+ hours     15 - 20 hours
#> [4721] 20+ hours     15 - 20 hours 20+ hours     15 - 20 hours 15 - 20 hours
#> [4726] 20+ hours     15 - 20 hours 20+ hours     15 - 20 hours 20+ hours    
#> [4731] 10 - 15 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [4736] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [4741] 20+ hours     20+ hours     10 - 15 hours 20+ hours     15 - 20 hours
#> [4746] 20+ hours     20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [4751] 15 - 20 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [4756] 15 - 20 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [4761] 20+ hours     20+ hours     15 - 20 hours 15 - 20 hours 20+ hours    
#> [4766] 20+ hours     20+ hours     20+ hours     10 - 15 hours 20+ hours    
#> [4771] 20+ hours     15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [4776] < 10 hours    15 - 20 hours 20+ hours     20+ hours     15 - 20 hours
#> [4781] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [4786] 15 - 20 hours 15 - 20 hours 20+ hours     20+ hours     15 - 20 hours
#> [4791] 20+ hours     20+ hours     20+ hours     20+ hours     10 - 15 hours
#> [4796] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [4801] 20+ hours     10 - 15 hours 20+ hours     20+ hours     20+ hours    
#> [4806] 15 - 20 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [4811] 20+ hours     20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [4816] 10 - 15 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [4821] 15 - 20 hours 15 - 20 hours 20+ hours     20+ hours     15 - 20 hours
#> [4826] 20+ hours     20+ hours     10 - 15 hours 20+ hours     10 - 15 hours
#> [4831] 20+ hours     20+ hours     15 - 20 hours 10 - 15 hours 15 - 20 hours
#> [4836] 15 - 20 hours 15 - 20 hours 10 - 15 hours 20+ hours     15 - 20 hours
#> [4841] 10 - 15 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [4846] 10 - 15 hours 20+ hours     20+ hours     20+ hours     < 10 hours   
#> [4851] 10 - 15 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [4856] 15 - 20 hours 20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [4861] 20+ hours     15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [4866] < 10 hours    15 - 20 hours 20+ hours     15 - 20 hours 20+ hours    
#> [4871] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [4876] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [4881] 15 - 20 hours 15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [4886] 20+ hours     20+ hours     < 10 hours    20+ hours     20+ hours    
#> [4891] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [4896] 10 - 15 hours 20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [4901] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [4906] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [4911] 20+ hours     15 - 20 hours 10 - 15 hours 20+ hours     20+ hours    
#> [4916] 20+ hours     20+ hours     15 - 20 hours 15 - 20 hours 20+ hours    
#> [4921] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [4926] 20+ hours     20+ hours     15 - 20 hours 15 - 20 hours 20+ hours    
#> [4931] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [4936] 20+ hours     15 - 20 hours 15 - 20 hours 20+ hours     20+ hours    
#> [4941] 20+ hours     10 - 15 hours 10 - 15 hours 15 - 20 hours 20+ hours    
#> [4946] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [4951] 20+ hours     20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [4956] 20+ hours     20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [4961] 20+ hours     20+ hours     15 - 20 hours 15 - 20 hours 10 - 15 hours
#> [4966] 10 - 15 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [4971] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [4976] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [4981] 20+ hours     20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [4986] 20+ hours     15 - 20 hours 20+ hours     10 - 15 hours 15 - 20 hours
#> [4991] 15 - 20 hours 20+ hours     20+ hours     15 - 20 hours 15 - 20 hours
#> [4996] 20+ hours     20+ hours     15 - 20 hours 20+ hours     15 - 20 hours
#> [5001] 20+ hours     20+ hours     10 - 15 hours 20+ hours     15 - 20 hours
#> [5006] 20+ hours     10 - 15 hours 15 - 20 hours 20+ hours     15 - 20 hours
#> [5011] 20+ hours     20+ hours     15 - 20 hours 10 - 15 hours 20+ hours    
#> [5016] 15 - 20 hours 20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [5021] 20+ hours     15 - 20 hours 10 - 15 hours 15 - 20 hours 15 - 20 hours
#> [5026] 20+ hours     20+ hours     15 - 20 hours 15 - 20 hours 20+ hours    
#> [5031] 20+ hours     20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [5036] 15 - 20 hours 20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [5041] 20+ hours     10 - 15 hours 15 - 20 hours 10 - 15 hours 20+ hours    
#> [5046] 20+ hours     15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [5051] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [5056] 20+ hours     20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [5061] 20+ hours     20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [5066] 10 - 15 hours 20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [5071] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [5076] 10 - 15 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [5081] 20+ hours     20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [5086] 20+ hours     20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [5091] 20+ hours     20+ hours     20+ hours     20+ hours     < 10 hours   
#> [5096] 20+ hours     15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [5101] 20+ hours     15 - 20 hours 15 - 20 hours 15 - 20 hours 15 - 20 hours
#> [5106] 20+ hours     20+ hours     10 - 15 hours 20+ hours     20+ hours    
#> [5111] 15 - 20 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [5116] 15 - 20 hours 20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [5121] 20+ hours     15 - 20 hours 15 - 20 hours 15 - 20 hours 20+ hours    
#> [5126] 20+ hours     20+ hours     15 - 20 hours 20+ hours     15 - 20 hours
#> [5131] 20+ hours     20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [5136] 15 - 20 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [5141] 20+ hours     15 - 20 hours 20+ hours     20+ hours     15 - 20 hours
#> [5146] 20+ hours     20+ hours     10 - 15 hours 20+ hours     20+ hours    
#> [5151] 15 - 20 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [5156] 15 - 20 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [5161] 10 - 15 hours 20+ hours     10 - 15 hours 20+ hours     20+ hours    
#> [5166] 15 - 20 hours 20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [5171] 10 - 15 hours 15 - 20 hours 20+ hours     20+ hours     15 - 20 hours
#> [5176] 20+ hours     20+ hours     15 - 20 hours 15 - 20 hours 20+ hours    
#> [5181] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [5186] 10 - 15 hours 20+ hours     20+ hours     10 - 15 hours 20+ hours    
#> [5191] 10 - 15 hours 20+ hours     10 - 15 hours 20+ hours     15 - 20 hours
#> [5196] 20+ hours     20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [5201] 20+ hours     20+ hours     20+ hours     15 - 20 hours 15 - 20 hours
#> [5206] 20+ hours     15 - 20 hours 15 - 20 hours 20+ hours     20+ hours    
#> [5211] 20+ hours     10 - 15 hours 20+ hours     20+ hours     20+ hours    
#> [5216] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [5221] 15 - 20 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [5226] 20+ hours     20+ hours     20+ hours     10 - 15 hours 15 - 20 hours
#> [5231] 20+ hours     20+ hours     20+ hours     20+ hours     10 - 15 hours
#> [5236] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [5241] 15 - 20 hours 20+ hours     15 - 20 hours 20+ hours     10 - 15 hours
#> [5246] 20+ hours     15 - 20 hours 20+ hours     20+ hours     15 - 20 hours
#> [5251] 15 - 20 hours 15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [5256] 10 - 15 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [5261] 20+ hours     20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [5266] 20+ hours     15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [5271] 20+ hours     10 - 15 hours 15 - 20 hours 20+ hours     15 - 20 hours
#> [5276] 15 - 20 hours 20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [5281] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [5286] 15 - 20 hours < 10 hours    20+ hours     20+ hours     20+ hours    
#> [5291] 15 - 20 hours 10 - 15 hours 20+ hours     20+ hours     20+ hours    
#> [5296] 15 - 20 hours 20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [5301] 10 - 15 hours 20+ hours     15 - 20 hours 20+ hours     15 - 20 hours
#> [5306] 20+ hours     20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [5311] 15 - 20 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [5316] 10 - 15 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [5321] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [5326] 20+ hours     < 10 hours    20+ hours     10 - 15 hours 20+ hours    
#> [5331] 10 - 15 hours 20+ hours     10 - 15 hours 10 - 15 hours 20+ hours    
#> [5336] 20+ hours     10 - 15 hours 20+ hours     15 - 20 hours 20+ hours    
#> [5341] 20+ hours     20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [5346] 20+ hours     15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [5351] 15 - 20 hours 15 - 20 hours 15 - 20 hours 15 - 20 hours 20+ hours    
#> [5356] < 10 hours    15 - 20 hours 10 - 15 hours 20+ hours     20+ hours    
#> [5361] 20+ hours     20+ hours     15 - 20 hours 15 - 20 hours 20+ hours    
#> [5366] 15 - 20 hours 15 - 20 hours 15 - 20 hours 20+ hours     20+ hours    
#> [5371] 15 - 20 hours 20+ hours     15 - 20 hours 20+ hours     15 - 20 hours
#> [5376] 20+ hours     20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [5381] 20+ hours     15 - 20 hours 15 - 20 hours 20+ hours     20+ hours    
#> [5386] 20+ hours     < 10 hours    20+ hours     20+ hours     20+ hours    
#> [5391] 20+ hours     20+ hours     20+ hours     20+ hours     10 - 15 hours
#> [5396] 20+ hours     15 - 20 hours 20+ hours     15 - 20 hours 20+ hours    
#> [5401] 20+ hours     20+ hours     20+ hours     10 - 15 hours 20+ hours    
#> [5406] 15 - 20 hours 20+ hours     15 - 20 hours 20+ hours     15 - 20 hours
#> [5411] 15 - 20 hours 15 - 20 hours < 10 hours    20+ hours     20+ hours    
#> [5416] 20+ hours     20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [5421] 20+ hours     15 - 20 hours 20+ hours     15 - 20 hours 20+ hours    
#> [5426] 20+ hours     20+ hours     20+ hours     15 - 20 hours 15 - 20 hours
#> [5431] 20+ hours     20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [5436] 20+ hours     20+ hours     15 - 20 hours 15 - 20 hours 10 - 15 hours
#> [5441] 20+ hours     15 - 20 hours 15 - 20 hours 20+ hours     < 10 hours   
#> [5446] 20+ hours     20+ hours     20+ hours     15 - 20 hours 15 - 20 hours
#> [5451] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [5456] 20+ hours     20+ hours     15 - 20 hours 20+ hours     15 - 20 hours
#> [5461] 10 - 15 hours 20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [5466] 20+ hours     15 - 20 hours 15 - 20 hours 20+ hours     15 - 20 hours
#> [5471] 20+ hours     15 - 20 hours 10 - 15 hours 20+ hours     20+ hours    
#> [5476] 20+ hours     20+ hours     15 - 20 hours 10 - 15 hours 20+ hours    
#> [5481] 15 - 20 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [5486] 20+ hours     20+ hours     20+ hours     10 - 15 hours 15 - 20 hours
#> [5491] 10 - 15 hours 15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [5496] 20+ hours     20+ hours     10 - 15 hours 10 - 15 hours 20+ hours    
#> [5501] 15 - 20 hours 15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [5506] 20+ hours     15 - 20 hours 15 - 20 hours 20+ hours     10 - 15 hours
#> [5511] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [5516] 20+ hours     20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [5521] 15 - 20 hours 20+ hours     20+ hours     20+ hours     10 - 15 hours
#> [5526] 15 - 20 hours 20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [5531] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [5536] 20+ hours     20+ hours     10 - 15 hours 15 - 20 hours 20+ hours    
#> [5541] 20+ hours     20+ hours     20+ hours     < 10 hours    20+ hours    
#> [5546] 20+ hours     20+ hours     15 - 20 hours 20+ hours     15 - 20 hours
#> [5551] 20+ hours     20+ hours     20+ hours     10 - 15 hours < 10 hours   
#> [5556] 10 - 15 hours 20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [5561] 20+ hours     20+ hours     20+ hours     20+ hours     10 - 15 hours
#> [5566] 15 - 20 hours < 10 hours    20+ hours     20+ hours     20+ hours    
#> [5571] 15 - 20 hours 20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [5576] 20+ hours     20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [5581] 15 - 20 hours 15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [5586] 20+ hours     20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [5591] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [5596] 10 - 15 hours 15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [5601] 20+ hours     15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [5606] 15 - 20 hours 15 - 20 hours 15 - 20 hours 20+ hours     20+ hours    
#> [5611] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [5616] 20+ hours     15 - 20 hours 10 - 15 hours 10 - 15 hours 10 - 15 hours
#> [5621] 20+ hours     15 - 20 hours 20+ hours     20+ hours     15 - 20 hours
#> [5626] 20+ hours     15 - 20 hours 15 - 20 hours 15 - 20 hours 15 - 20 hours
#> [5631] 20+ hours     15 - 20 hours 20+ hours     20+ hours     15 - 20 hours
#> [5636] 20+ hours     20+ hours     20+ hours     < 10 hours    20+ hours    
#> [5641] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [5646] 10 - 15 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [5651] 20+ hours     20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [5656] 20+ hours     20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [5661] 15 - 20 hours 20+ hours     20+ hours     10 - 15 hours 15 - 20 hours
#> [5666] 20+ hours     15 - 20 hours 15 - 20 hours 20+ hours     20+ hours    
#> [5671] 15 - 20 hours 10 - 15 hours 15 - 20 hours 20+ hours     20+ hours    
#> [5676] 20+ hours     10 - 15 hours 15 - 20 hours 20+ hours     20+ hours    
#> [5681] 10 - 15 hours 20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [5686] 20+ hours     20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [5691] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [5696] 20+ hours     15 - 20 hours 20+ hours     10 - 15 hours 20+ hours    
#> [5701] 15 - 20 hours 15 - 20 hours 15 - 20 hours 20+ hours     20+ hours    
#> [5706] 20+ hours     20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [5711] 20+ hours     20+ hours     10 - 15 hours 20+ hours     15 - 20 hours
#> [5716] 20+ hours     20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [5721] 10 - 15 hours 20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [5726] 20+ hours     15 - 20 hours 20+ hours     10 - 15 hours 15 - 20 hours
#> [5731] 20+ hours     10 - 15 hours 10 - 15 hours 15 - 20 hours 20+ hours    
#> [5736] 15 - 20 hours 20+ hours     20+ hours     10 - 15 hours 15 - 20 hours
#> [5741] 20+ hours     20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [5746] 20+ hours     15 - 20 hours 20+ hours     20+ hours     < 10 hours   
#> [5751] 15 - 20 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [5756] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [5761] 20+ hours     20+ hours     15 - 20 hours 20+ hours     15 - 20 hours
#> [5766] 20+ hours     20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [5771] 20+ hours     20+ hours     15 - 20 hours 10 - 15 hours 10 - 15 hours
#> [5776] 20+ hours     15 - 20 hours 20+ hours     20+ hours     10 - 15 hours
#> [5781] 10 - 15 hours 20+ hours     20+ hours     10 - 15 hours 15 - 20 hours
#> [5786] 20+ hours     15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [5791] 15 - 20 hours 10 - 15 hours 20+ hours     15 - 20 hours 20+ hours    
#> [5796] 20+ hours     20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [5801] 15 - 20 hours 10 - 15 hours 20+ hours     20+ hours     20+ hours    
#> [5806] 20+ hours     20+ hours     10 - 15 hours 15 - 20 hours 15 - 20 hours
#> [5811] 20+ hours     15 - 20 hours 20+ hours     20+ hours     15 - 20 hours
#> [5816] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [5821] 20+ hours     20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [5826] 20+ hours     20+ hours     20+ hours     20+ hours     10 - 15 hours
#> [5831] 20+ hours     20+ hours     15 - 20 hours 20+ hours     15 - 20 hours
#> [5836] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [5841] 20+ hours     20+ hours     10 - 15 hours 15 - 20 hours 20+ hours    
#> [5846] 20+ hours     20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [5851] 15 - 20 hours 15 - 20 hours 20+ hours     20+ hours     15 - 20 hours
#> [5856] 15 - 20 hours 15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [5861] 20+ hours     20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [5866] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [5871] 15 - 20 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [5876] 20+ hours     15 - 20 hours 10 - 15 hours 15 - 20 hours 20+ hours    
#> [5881] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [5886] 10 - 15 hours 20+ hours     10 - 15 hours 20+ hours     20+ hours    
#> [5891] 20+ hours     15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [5896] 20+ hours     20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [5901] 20+ hours     20+ hours     20+ hours     10 - 15 hours 20+ hours    
#> [5906] 20+ hours     20+ hours     10 - 15 hours 20+ hours     15 - 20 hours
#> [5911] 20+ hours     20+ hours     10 - 15 hours 20+ hours     20+ hours    
#> [5916] 15 - 20 hours 15 - 20 hours 15 - 20 hours 15 - 20 hours 15 - 20 hours
#> [5921] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [5926] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [5931] 20+ hours     20+ hours     15 - 20 hours 20+ hours     15 - 20 hours
#> [5936] 15 - 20 hours 20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [5941] 20+ hours     20+ hours     20+ hours     20+ hours     < 10 hours   
#> [5946] 20+ hours     20+ hours     15 - 20 hours < 10 hours    20+ hours    
#> [5951] 15 - 20 hours 10 - 15 hours 20+ hours     10 - 15 hours 15 - 20 hours
#> [5956] 15 - 20 hours 15 - 20 hours 15 - 20 hours 20+ hours     10 - 15 hours
#> [5961] 20+ hours     15 - 20 hours 10 - 15 hours 20+ hours     15 - 20 hours
#> [5966] < 10 hours    20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [5971] 15 - 20 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [5976] 15 - 20 hours 20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [5981] 10 - 15 hours 15 - 20 hours 15 - 20 hours 20+ hours     20+ hours    
#> [5986] 20+ hours     20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [5991] 20+ hours     20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [5996] 20+ hours     20+ hours     15 - 20 hours 20+ hours     15 - 20 hours
#> [6001] 15 - 20 hours 20+ hours     15 - 20 hours 20+ hours     15 - 20 hours
#> [6006] 20+ hours     20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [6011] 20+ hours     20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [6016] 10 - 15 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [6021] 10 - 15 hours 20+ hours     20+ hours     10 - 15 hours 15 - 20 hours
#> [6026] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [6031] 20+ hours     20+ hours     10 - 15 hours 20+ hours     20+ hours    
#> [6036] 15 - 20 hours 20+ hours     20+ hours     20+ hours     10 - 15 hours
#> [6041] 20+ hours     15 - 20 hours 15 - 20 hours 20+ hours     20+ hours    
#> [6046] 15 - 20 hours 20+ hours     20+ hours     10 - 15 hours 20+ hours    
#> [6051] < 10 hours    15 - 20 hours 20+ hours     20+ hours     10 - 15 hours
#> [6056] 20+ hours     20+ hours     20+ hours     10 - 15 hours 10 - 15 hours
#> [6061] 20+ hours     10 - 15 hours 10 - 15 hours 10 - 15 hours 15 - 20 hours
#> [6066] 20+ hours     20+ hours     15 - 20 hours 20+ hours     10 - 15 hours
#> [6071] 20+ hours     15 - 20 hours < 10 hours    15 - 20 hours 20+ hours    
#> [6076] 20+ hours     20+ hours     20+ hours     20+ hours     10 - 15 hours
#> [6081] 20+ hours     20+ hours     20+ hours     10 - 15 hours 20+ hours    
#> [6086] 20+ hours     20+ hours     15 - 20 hours 15 - 20 hours 20+ hours    
#> [6091] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [6096] 20+ hours     20+ hours     20+ hours     10 - 15 hours 20+ hours    
#> [6101] 15 - 20 hours 20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [6106] 20+ hours     20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [6111] 20+ hours     15 - 20 hours 10 - 15 hours 20+ hours     20+ hours    
#> [6116] 20+ hours     15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [6121] 15 - 20 hours 20+ hours     20+ hours     15 - 20 hours 15 - 20 hours
#> [6126] 20+ hours     20+ hours     20+ hours     10 - 15 hours 20+ hours    
#> [6131] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [6136] 20+ hours     15 - 20 hours 10 - 15 hours 10 - 15 hours 20+ hours    
#> [6141] 20+ hours     20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [6146] 20+ hours     20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [6151] 20+ hours     15 - 20 hours 20+ hours     20+ hours     10 - 15 hours
#> [6156] 10 - 15 hours 15 - 20 hours 15 - 20 hours 20+ hours     20+ hours    
#> [6161] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [6166] 20+ hours     20+ hours     20+ hours     20+ hours     10 - 15 hours
#> [6171] 15 - 20 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [6176] 20+ hours     20+ hours     15 - 20 hours 20+ hours     15 - 20 hours
#> [6181] 20+ hours     10 - 15 hours 20+ hours     10 - 15 hours 15 - 20 hours
#> [6186] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [6191] 10 - 15 hours 20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [6196] 20+ hours     20+ hours     20+ hours     10 - 15 hours 20+ hours    
#> [6201] 20+ hours     15 - 20 hours 20+ hours     20+ hours     15 - 20 hours
#> [6206] < 10 hours    20+ hours     20+ hours     20+ hours     20+ hours    
#> [6211] 20+ hours     20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [6216] 20+ hours     10 - 15 hours 15 - 20 hours 15 - 20 hours 20+ hours    
#> [6221] 20+ hours     15 - 20 hours 20+ hours     10 - 15 hours 15 - 20 hours
#> [6226] 15 - 20 hours 20+ hours     20+ hours     10 - 15 hours 20+ hours    
#> [6231] 20+ hours     20+ hours     15 - 20 hours 15 - 20 hours 20+ hours    
#> [6236] 15 - 20 hours 20+ hours     20+ hours     15 - 20 hours 15 - 20 hours
#> [6241] 15 - 20 hours 20+ hours     15 - 20 hours 15 - 20 hours 20+ hours    
#> [6246] 20+ hours     20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [6251] 15 - 20 hours 15 - 20 hours 15 - 20 hours 10 - 15 hours 20+ hours    
#> [6256] 20+ hours     20+ hours     15 - 20 hours 15 - 20 hours 15 - 20 hours
#> [6261] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [6266] 20+ hours     20+ hours     15 - 20 hours 15 - 20 hours 20+ hours    
#> [6271] 20+ hours     20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [6276] 15 - 20 hours 20+ hours     15 - 20 hours 15 - 20 hours 15 - 20 hours
#> [6281] 20+ hours     20+ hours     15 - 20 hours 20+ hours     15 - 20 hours
#> [6286] 20+ hours     20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [6291] 15 - 20 hours 20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [6296] 20+ hours     20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [6301] 20+ hours     20+ hours     20+ hours     20+ hours     < 10 hours   
#> [6306] 20+ hours     20+ hours     15 - 20 hours 15 - 20 hours 20+ hours    
#> [6311] 20+ hours     20+ hours     20+ hours     20+ hours     < 10 hours   
#> [6316] 15 - 20 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [6321] 20+ hours     10 - 15 hours 20+ hours     20+ hours     20+ hours    
#> [6326] 15 - 20 hours 10 - 15 hours 20+ hours     20+ hours     20+ hours    
#> [6331] 20+ hours     15 - 20 hours 15 - 20 hours 20+ hours     20+ hours    
#> [6336] 15 - 20 hours 20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [6341] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [6346] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [6351] 20+ hours     20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [6356] 20+ hours     15 - 20 hours 10 - 15 hours 20+ hours     20+ hours    
#> [6361] 20+ hours     10 - 15 hours 15 - 20 hours < 10 hours    20+ hours    
#> [6366] 10 - 15 hours 20+ hours     15 - 20 hours 20+ hours     < 10 hours   
#> [6371] 20+ hours     15 - 20 hours 20+ hours     15 - 20 hours 15 - 20 hours
#> [6376] 15 - 20 hours 20+ hours     10 - 15 hours 15 - 20 hours 20+ hours    
#> [6381] 10 - 15 hours 20+ hours     < 10 hours    10 - 15 hours 20+ hours    
#> [6386] 20+ hours     15 - 20 hours 20+ hours     20+ hours     15 - 20 hours
#> [6391] 20+ hours     20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [6396] 20+ hours     15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [6401] 15 - 20 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [6406] 15 - 20 hours 15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [6411] 10 - 15 hours 20+ hours     10 - 15 hours 20+ hours     20+ hours    
#> [6416] 20+ hours     20+ hours     < 10 hours    20+ hours     20+ hours    
#> [6421] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [6426] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [6431] 20+ hours     20+ hours     15 - 20 hours 15 - 20 hours 15 - 20 hours
#> [6436] 20+ hours     < 10 hours    10 - 15 hours 20+ hours     20+ hours    
#> [6441] 20+ hours     20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [6446] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [6451] 20+ hours     20+ hours     20+ hours     20+ hours     10 - 15 hours
#> [6456] 20+ hours     20+ hours     20+ hours     20+ hours     10 - 15 hours
#> [6461] 10 - 15 hours 20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [6466] 20+ hours     20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [6471] 10 - 15 hours 20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [6476] 20+ hours     20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [6481] 20+ hours     20+ hours     20+ hours     15 - 20 hours 15 - 20 hours
#> [6486] 20+ hours     20+ hours     20+ hours     10 - 15 hours 20+ hours    
#> [6491] 20+ hours     20+ hours     15 - 20 hours 15 - 20 hours 20+ hours    
#> [6496] 20+ hours     20+ hours     10 - 15 hours 20+ hours     20+ hours    
#> [6501] 20+ hours     20+ hours     20+ hours     15 - 20 hours 15 - 20 hours
#> [6506] 20+ hours     15 - 20 hours 15 - 20 hours 20+ hours     15 - 20 hours
#> [6511] 20+ hours     20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [6516] 15 - 20 hours 15 - 20 hours 15 - 20 hours 20+ hours     20+ hours    
#> [6521] 20+ hours     20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [6526] 15 - 20 hours 20+ hours     20+ hours     20+ hours     10 - 15 hours
#> [6531] 15 - 20 hours 15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [6536] 10 - 15 hours 10 - 15 hours 20+ hours     20+ hours     20+ hours    
#> [6541] 20+ hours     20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [6546] 15 - 20 hours 20+ hours     15 - 20 hours 15 - 20 hours 20+ hours    
#> [6551] 20+ hours     20+ hours     10 - 15 hours 20+ hours     20+ hours    
#> [6556] 15 - 20 hours 15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [6561] 15 - 20 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [6566] 20+ hours     15 - 20 hours 15 - 20 hours 20+ hours     20+ hours    
#> [6571] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [6576] 20+ hours     20+ hours     10 - 15 hours < 10 hours    15 - 20 hours
#> [6581] 20+ hours     15 - 20 hours 10 - 15 hours 20+ hours     20+ hours    
#> [6586] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [6591] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [6596] 20+ hours     20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [6601] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [6606] 10 - 15 hours 20+ hours     15 - 20 hours 15 - 20 hours 20+ hours    
#> [6611] 20+ hours     10 - 15 hours 15 - 20 hours 15 - 20 hours 20+ hours    
#> [6616] 20+ hours     20+ hours     20+ hours     10 - 15 hours 20+ hours    
#> [6621] 20+ hours     20+ hours     20+ hours     15 - 20 hours 15 - 20 hours
#> [6626] 20+ hours     20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [6631] 15 - 20 hours 10 - 15 hours 20+ hours     15 - 20 hours 15 - 20 hours
#> [6636] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [6641] 20+ hours     10 - 15 hours 15 - 20 hours 20+ hours     20+ hours    
#> [6646] 10 - 15 hours 15 - 20 hours 15 - 20 hours 20+ hours     20+ hours    
#> [6651] 20+ hours     10 - 15 hours 20+ hours     20+ hours     15 - 20 hours
#> [6656] 15 - 20 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [6661] 20+ hours     15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [6666] 20+ hours     15 - 20 hours 20+ hours     15 - 20 hours 20+ hours    
#> [6671] 20+ hours     20+ hours     20+ hours     15 - 20 hours 10 - 15 hours
#> [6676] 20+ hours     20+ hours     15 - 20 hours 10 - 15 hours 15 - 20 hours
#> [6681] 20+ hours     20+ hours     15 - 20 hours 15 - 20 hours 20+ hours    
#> [6686] 15 - 20 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [6691] 20+ hours     20+ hours     10 - 15 hours 20+ hours     20+ hours    
#> [6696] 20+ hours     20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [6701] 20+ hours     15 - 20 hours 10 - 15 hours 20+ hours     20+ hours    
#> [6706] 15 - 20 hours 15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [6711] 15 - 20 hours 20+ hours     10 - 15 hours 20+ hours     20+ hours    
#> [6716] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [6721] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [6726] 15 - 20 hours 20+ hours     20+ hours     20+ hours     15 - 20 hours
#> [6731] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [6736] 20+ hours     20+ hours     15 - 20 hours 20+ hours     15 - 20 hours
#> [6741] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [6746] 15 - 20 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [6751] 10 - 15 hours 15 - 20 hours 20+ hours     20+ hours     15 - 20 hours
#> [6756] 20+ hours     20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [6761] 20+ hours     15 - 20 hours 20+ hours     20+ hours     15 - 20 hours
#> [6766] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [6771] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [6776] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [6781] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [6786] 20+ hours     20+ hours     15 - 20 hours 10 - 15 hours 20+ hours    
#> [6791] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [6796] 20+ hours     15 - 20 hours 20+ hours     20+ hours     15 - 20 hours
#> [6801] 20+ hours     20+ hours     15 - 20 hours 20+ hours     20+ hours    
#> [6806] 20+ hours     20+ hours     20+ hours     10 - 15 hours 20+ hours    
#> [6811] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [6816] 20+ hours     20+ hours     20+ hours     15 - 20 hours 20+ hours    
#> [6821] 10 - 15 hours 15 - 20 hours 20+ hours     15 - 20 hours 20+ hours    
#> [6826] 20+ hours     15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [6831] 20+ hours     20+ hours     10 - 15 hours 10 - 15 hours 20+ hours    
#> [6836] 15 - 20 hours 15 - 20 hours 10 - 15 hours 20+ hours     20+ hours    
#> [6841] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [6846] 15 - 20 hours 15 - 20 hours 15 - 20 hours 20+ hours     20+ hours    
#> [6851] 20+ hours     10 - 15 hours 20+ hours     15 - 20 hours 20+ hours    
#> [6856] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [6861] 15 - 20 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [6866] < 10 hours    10 - 15 hours 20+ hours     15 - 20 hours 15 - 20 hours
#> [6871] 15 - 20 hours 20+ hours     20+ hours     20+ hours     20+ hours    
#> [6876] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [6881] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> [6886] 20+ hours     20+ hours     20+ hours     15 - 20 hours < 10 hours   
#> [6891] 20+ hours     15 - 20 hours 20+ hours     20+ hours     20+ hours    
#> [6896] 20+ hours     20+ hours     20+ hours     20+ hours     20+ hours    
#> Levels: < 10 hours 10 - 15 hours 15 - 20 hours 20+ hours
```
