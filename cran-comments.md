## R CMD check results

0 errors | 0 warnings | 0 notes

## Release summary

This is a minor release (0.7.1) that implements a few enhancements for the newer functions.

## What's new in this version

* Bug fix to `identify_usage_segments()`: Fixed incorrect `n` count in table output to use distinct PersonIds instead of row count
* Improvement to `identify_usage_segments()`: Reordered table output columns to follow logical segment progression (Non-user, Low User, Novice User, Habitual User, Power User)
* Aesthetic improvements to `create_rogers()`
* Added warning message to `identify_usage_segments()` when NA values are detected in the metric variable

## Reverse dependencies

There are currently no reverse dependencies for this package.

## Additional notes

* All examples and tests run successfully
* Package maintains backward compatibility
* New function follows established package patterns and conventions
