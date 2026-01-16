# Sample person-to-person dataset

A demo dataset representing a person-to-person query, structured as an
edgelist. The identifier variable for each person is `PersonId`, where
the variables have been prefixed with `PrimaryCollaborator_` and
`SecondaryCollaborator_` to represent the direction of collaboration.

## Usage

``` r
p2p_data
```

## Format

A data frame with 11550 rows and 13 variables:

- PrimaryCollaborator_PersonId:

- SecondaryCollaborator_PersonId:

- MetricDate:

- Diverse_tie_score:

- Diverse_tie_type:

- Strong_tie_score:

- Strong_tie_type:

- PrimaryCollaborator_Organization:

- SecondaryCollaborator_Organization:

- PrimaryCollaborator_LevelDesignation:

- SecondaryCollaborator_LevelDesignation:

- PrimaryCollaborator_FunctionType:

- SecondaryCollaborator_FunctionType:

## Source

<https://analysis.insights.cloud.microsoft/analyst/analysis/>

## Value

data frame.

## See also

Other Data:
[`g2g_data`](https://microsoft.github.io/vivainsights/reference/g2g_data.md),
[`mt_data`](https://microsoft.github.io/vivainsights/reference/mt_data.md),
[`p2p_data_sim()`](https://microsoft.github.io/vivainsights/reference/p2p_data_sim.md),
[`pq_data`](https://microsoft.github.io/vivainsights/reference/pq_data.md)

Other Network:
[`g2g_data`](https://microsoft.github.io/vivainsights/reference/g2g_data.md),
[`network_g2g()`](https://microsoft.github.io/vivainsights/reference/network_g2g.md),
[`network_p2p()`](https://microsoft.github.io/vivainsights/reference/network_p2p.md),
[`network_summary()`](https://microsoft.github.io/vivainsights/reference/network_summary.md),
[`p2p_data_sim()`](https://microsoft.github.io/vivainsights/reference/p2p_data_sim.md)
