# vivainsights 0.7.0

* Added `create_rogers()` function for analyzing technology adoption patterns using Rogers adoption curve theory
* Feature improvements to `create_hist()`, `create_density()`, `identify_usage_segments()`, `create_line()`
* Refactor superseded dplyr syntax to current best practices
* Optimized dependencies using base R functions where appropriate

# vivainsights 0.6.2

* Minor bug fixes to `validation_report()`
* Clearer diagnostic messages to `identify_*()` family of functions

# vivainsights 0.6.1

* Added `identify_usage_segments()` for classifying usage segments. 
* Added `create_itsa()` for performing interrupted time-series analysis.

# vivainsights 0.6.0

* Add `identify_habits()` for classifying habitual behavior.
* Refactored code to latest dplyr and tidyselect practices.
* Updated metrics in `pq_data` to include Copilot metrics.

# vivainsights 0.5.5

* Add new functionality on calculating Chatterjee's coefficient
* Improved test coverage

# vivainsights 0.5.4

Added new functionality to calculate Gini coefficient and Lorenz curve.

# vivainsights 0.5.3

Minor bug fixes and visual improvements.

# vivainsights 0.5.2

Minor bugfix on `create_line()`. 

# vivainsights 0.5.1

Minor changes to documentation on static report outputs.

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
