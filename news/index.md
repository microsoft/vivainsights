# Changelog

## vivainsights 0.7.1

- Bug fix to
  [`identify_usage_segments()`](https://microsoft.github.io/vivainsights/reference/identify_usage_segments.md):
  Fixed incorrect `n` count in table output to use distinct PersonIds
  instead of row count
- Improvement to
  [`identify_usage_segments()`](https://microsoft.github.io/vivainsights/reference/identify_usage_segments.md):
  Reordered table output columns to follow logical segment progression
  (Non-user, Low User, Novice User, Habitual User, Power User)
- Aesthetic improvements to
  [`create_rogers()`](https://microsoft.github.io/vivainsights/reference/create_rogers.md)
- Added warning message to
  [`identify_usage_segments()`](https://microsoft.github.io/vivainsights/reference/identify_usage_segments.md)
  when NA values are detected in the metric variable

## vivainsights 0.7.0

CRAN release: 2025-07-24

- Added
  [`create_rogers()`](https://microsoft.github.io/vivainsights/reference/create_rogers.md)
  function for analyzing technology adoption patterns using Rogers
  adoption curve theory
- Feature improvements to
  [`create_hist()`](https://microsoft.github.io/vivainsights/reference/create_hist.md),
  [`create_density()`](https://microsoft.github.io/vivainsights/reference/create_density.md),
  [`identify_usage_segments()`](https://microsoft.github.io/vivainsights/reference/identify_usage_segments.md),
  [`create_line()`](https://microsoft.github.io/vivainsights/reference/create_line.md)
- Refactor superseded dplyr syntax to current best practices
- Optimized dependencies using base R functions where appropriate

## vivainsights 0.6.2

CRAN release: 2025-05-28

- Minor bug fixes to
  [`validation_report()`](https://microsoft.github.io/vivainsights/reference/validation_report.md)
- Clearer diagnostic messages to `identify_*()` family of functions

## vivainsights 0.6.1

CRAN release: 2025-05-12

- Added
  [`identify_usage_segments()`](https://microsoft.github.io/vivainsights/reference/identify_usage_segments.md)
  for classifying usage segments.
- Added
  [`create_itsa()`](https://microsoft.github.io/vivainsights/reference/create_itsa.md)
  for performing interrupted time-series analysis.

## vivainsights 0.6.0

CRAN release: 2025-02-20

- Add `identify_habits()` for classifying habitual behavior.
- Refactored code to latest dplyr and tidyselect practices.
- Updated metrics in `pq_data` to include Copilot metrics.

## vivainsights 0.5.5

CRAN release: 2024-11-19

- Add new functionality on calculating Chatterjee’s coefficient
- Improved test coverage

## vivainsights 0.5.4

CRAN release: 2024-09-06

Added new functionality to calculate Gini coefficient and Lorenz curve.

## vivainsights 0.5.3

CRAN release: 2024-06-06

Minor bug fixes and visual improvements.

## vivainsights 0.5.2

CRAN release: 2024-03-14

Minor bugfix on
[`create_line()`](https://microsoft.github.io/vivainsights/reference/create_line.md).

## vivainsights 0.5.1

CRAN release: 2024-01-10

Minor changes to documentation on static report outputs.

## vivainsights 0.5.0

CRAN release: 2023-11-09

Added new functionality to calculate information value:
[`create_IV()`](https://microsoft.github.io/vivainsights/reference/create_IV.md)
and
[`IV_report()`](https://microsoft.github.io/vivainsights/reference/IV_report.md)

## vivainsights 0.4.3

CRAN release: 2023-11-01

- Updated datasets for `g2g_data` and `p2p_data`
- Improve test coverage

## vivainsights 0.4.2

CRAN release: 2023-10-17

- Improved versatility to `identify_query()`
- Added
  [`any_idate()`](https://microsoft.github.io/vivainsights/reference/any_idate.md)
- Bug fixes

## vivainsights 0.4.1

CRAN release: 2023-08-25

- Removed the DT dependency

## vivainsights 0.4.0

CRAN release: 2023-08-16

Added new functionality for organizational network analysis (ONA):

- Introduced `p2p_data` and `g2g_data` sample datasets, with an option
  to simulate a person-to-person dataset using
  [`p2p_data_sim()`](https://microsoft.github.io/vivainsights/reference/p2p_data_sim.md)
- Added
  [`network_g2g()`](https://microsoft.github.io/vivainsights/reference/network_g2g.md),
  [`network_p2p()`](https://microsoft.github.io/vivainsights/reference/network_p2p.md),
  [`network_summary()`](https://microsoft.github.io/vivainsights/reference/network_summary.md),
  and
  [`create_sankey()`](https://microsoft.github.io/vivainsights/reference/create_sankey.md)
  functions
- [`network_p2p()`](https://microsoft.github.io/vivainsights/reference/network_p2p.md)
  now has a `centrality` argument for computing and visualizing
  centrality as node sizes in the network plot
- For
  [`network_p2p()`](https://microsoft.github.io/vivainsights/reference/network_p2p.md):
  - the `algorithm` argument is renamed to `layout` for better
    intuitiveness
  - Improved consistency and intuitiveness of the API, with `style`
    argument now controlling the network plotting mechanism and `return`
    argument controlling whether plots are generated interactively or
    saved as PDF
  - Added a large number of community detection algorithms from `igraph`

## vivainsights 0.3.1

CRAN release: 2023-05-22

- Fixed bug in running validation report
  ([\#11](https://github.com/microsoft/vivainsights/issues/11))

## vivainsights 0.3.0

CRAN release: 2023-03-30

- Added new text analytics functions relating to the meeting query

## vivainsights 0.2.0

CRAN release: 2023-01-17

- colour contrast improved for
  [`create_dist()`](https://microsoft.github.io/vivainsights/reference/create_dist.md)
  family functions
- added data validation family of functions, including
  [`validation_report()`](https://microsoft.github.io/vivainsights/reference/validation_report.md)
- adds ‘wpa’ as a package dependency

## vivainsights 0.1.0

CRAN release: 2022-10-04

This is the first version of the **vivainsights** package to be released
open-source on GitHub and CRAN. This is based on the original
[wpa](https://microsoft.github.io/wpa/) library, with functions and
documentation updated to reflect the latest features in Viva Insights.
