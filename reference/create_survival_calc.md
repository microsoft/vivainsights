# Kaplan–Meier Survival Curve (Calculation)

Computes a long-format Kaplan–Meier survival table by group and applies
a minimum group size threshold (`mingroup`).

## Usage

``` r
create_survival_calc(
  data,
  time_col,
  event_col,
  hrvar = NULL,
  id_col = "PersonId",
  mingroup = 5,
  na.rm = TRUE
)
```

## Arguments

- data:

  data.frame.

- time_col:

  Character. Time-to-event column name.

- event_col:

  Character. Event indicator column name.

- hrvar:

  Character or NULL. Grouping column name.

- id_col:

  Character. Optional id column name for distinct counts.

- mingroup:

  Numeric. Minimum group size.

- na.rm:

  Logical. Drop missing values in required columns.

## Value

A list with elements:

- `table`: long survival table with columns (group, time, survival,
  at_risk, events, n)

- `counts`: group size table
