## R CMD check results

0 errors | 0 warnings | 0 notes

## Release summary

This is a patch release (0.7.3) that contains bug fixes, a small feature addition, and documentation improvements.

## What's new in this version

* Replaced dynamic string evaluation in `network_p2p()` with allowlisted community, layout, and palette dispatch
* Added support for passing a palette function directly to `network_p2p()`
* Fixed `network_p2p()` ggraph colours so palettes are matched to group or cluster labels rather than vertex order
* Fixed `heat_colors()` and `heat_colours()` so their documented default usage no longer requires an explicit `alpha` value
* Added a task-oriented function catalogue and agent discovery guide covering primary Viva Insights workflows and R/Python capability parity

## Reverse dependencies

There are currently no reverse dependencies for this package.

## Additional notes

* All examples and tests run successfully
* Package maintains backward compatibility
