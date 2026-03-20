# Prepare Survival Data from a Panel Dataset

Converts a Standard Person Query (panel) dataset into a person-level
survival table suitable for direct use with
[`create_survival`](https://microsoft.github.io/vivainsights/reference/create_survival.md).

Each person's weekly rows are reduced to a single row containing:

- `time`: the number of periods from the first observation until the
  event condition is first met. If the condition is never met, `time`
  equals the total number of observed periods (censored).

- `event`: `1` if the condition was met at any point in the observation
  window, `0` if the person was censored (never met it).

Although rooted in survival analysis, the `event_condition` is typically
a **positive milestone** in a workforce context — first use of a tool,
first week as a power user, first week crossing a collaboration
threshold. The resulting curve is therefore often better described as a
**time-to-adoption**, **conversion**, or **graduation** curve. See
[`create_survival`](https://microsoft.github.io/vivainsights/reference/create_survival.md)
for further framing guidance.

## Usage

``` r
create_survival_prep(
  data,
  metric,
  event_condition = function(x) x > 0,
  hrvar = "Organization"
)
```

## Arguments

- data:

  A Standard Person Query dataset in the form of a data frame.

- metric:

  Character string containing the name of the metric column to evaluate
  the event condition on.

- event_condition:

  A function that takes a numeric vector and returns a logical vector.
  Applied to `metric` to mark whether the event occurred in a given
  period. Defaults to `function(x) x > 0` (any non-zero value is treated
  as the event).

- hrvar:

  Character string containing the name of the HR attribute column to
  carry through into the output. The most recent (last observed) value
  per person is used. Defaults to `"Organization"`. Set to `NULL` to
  omit.

## Value

A data frame with one row per person containing:

- `PersonId`

- `time`: numeric — periods until event, or total observed periods if
  censored

- `event`: integer — `1` (event) or `0` (censored)

- The `hrvar` column, if supplied

## See also

[`create_survival`](https://microsoft.github.io/vivainsights/reference/create_survival.md)

## Examples

``` r
# \dontrun{
# library(vivainsights)
# data("pq_data", package = "vivainsights")
#
# # Step 1: derive person-level survival data
# surv_data <- create_survival_prep(
#   data = pq_data,
#   metric = "Copilot_actions_taken_in_Teams",
#   event_condition = function(x) x > 0
# )
#
# # Step 2: visualise
# create_survival(
#   data = surv_data,
#   time_col = "time",
#   event_col = "event",
#   hrvar = "Organization"
# )
# }
```
