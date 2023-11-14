# vivainsights (development version)

# vivainsights 0.5.0

Added new functionality to calculate information value: `create_IV()` and `IV_report()` 

# vivainsights 0.4.3

- Updated datasets for `g2g_data` and `p2p_data`
- Improve test coverage

# vivainsights 0.4.2

- Improved versatility to `identify_query()`
- Added `any_idate()`
- Bug fixes

# vivainsights 0.4.1

- Removed the DT dependency

# vivainsights 0.4.0

Added new functionality for organizational network analysis (ONA):

  - Introduced `p2p_data` and `g2g_data` sample datasets, with an option to simulate a person-to-person dataset using `p2p_data_sim()`
  - Added `network_g2g()`, `network_p2p()`, `network_summary()`, and `create_sankey()` functions
  - `network_p2p()` now has a `centrality` argument for computing and visualizing centrality as node sizes in the network plot
  - For `network_p2p()`:
    - the `algorithm` argument is renamed to `layout` for better intuitiveness
    - Improved consistency and intuitiveness of the API, with `style` argument now controlling the network plotting mechanism and `return` argument controlling whether plots are generated interactively or saved as PDF
    - Added a large number of community detection algorithms from `igraph`

# vivainsights 0.3.1

- Fixed bug in running validation report (#11)

# vivainsights 0.3.0

- Added new text analytics functions relating to the meeting query

# vivainsights 0.2.0

- colour contrast improved for `create_dist()` family functions
- added data validation family of functions, including `validation_report()`
- adds 'wpa' as a package dependency 

# vivainsights 0.1.0

This is the first version of the **vivainsights** package to be released open-source on GitHub and CRAN. This is based on the original [wpa](https://microsoft.github.io/wpa/) library, with functions and documentation updated to reflect the latest features in Viva Insights.
