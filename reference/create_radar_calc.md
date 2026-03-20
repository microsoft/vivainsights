# Radar Chart (Calculation)

Computes group-level metric values and applies optional indexing.

## Usage

``` r
create_radar_calc(
  data,
  metrics,
  hrvar,
  id_col = "PersonId",
  mingroup = 5,
  agg = "mean",
  index_mode = "total",
  index_ref_group = NULL,
  na.rm = FALSE
)
```

## Arguments

- data:

  data.frame.

- metrics:

  character vector of metric column names.

- hrvar:

  character string specifying grouping column.

- id_col:

  character string specifying person id column.

- mingroup:

  numeric minimum unique people per group.

- agg:

  "mean" or "median".

- index_mode:

  "total","none","ref_group","minmax".

- index_ref_group:

  reference group name when index_mode="ref_group".

- na.rm:

  logical.

## Value

list(table=group_level_table, ref=reference_used)
