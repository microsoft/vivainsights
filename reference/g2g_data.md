# Sample Group-to-Group dataset

A demo dataset representing a Group-to-Group Query. The grouping
organizational attribute used here is `Organization`, where the variable
have been prefixed with `PrimaryCollaborator_` and
`SecondaryCollaborator_` to represent the direction of collaboration.

## Usage

``` r
g2g_data
```

## Format

A data frame with 150 rows and 11 variables:

- PrimaryCollaborator_Organization:

- PrimaryCollaborator_GroupSize:

- SecondaryCollaborator_Organization:

- SecondaryCollaborator_GroupSize:

- MetricDate:

- Percent_Group_collaboration_time_invested:

- Group_collaboration_time_invested:

- Group_email_sent_count:

- Group_email_time_invested:

- Group_meeting_count:

- Group_meeting_time_invested:

## Source

<https://analysis.insights.cloud.microsoft/analyst/analysis/>

## Value

data frame.

## See also

Other Data:
[`mt_data`](https://microsoft.github.io/vivainsights/reference/mt_data.md),
[`p2p_data`](https://microsoft.github.io/vivainsights/reference/p2p_data.md),
[`p2p_data_sim()`](https://microsoft.github.io/vivainsights/reference/p2p_data_sim.md),
[`pq_data`](https://microsoft.github.io/vivainsights/reference/pq_data.md)

Other Network:
[`network_g2g()`](https://microsoft.github.io/vivainsights/reference/network_g2g.md),
[`network_p2p()`](https://microsoft.github.io/vivainsights/reference/network_p2p.md),
[`network_summary()`](https://microsoft.github.io/vivainsights/reference/network_summary.md),
[`p2p_data`](https://microsoft.github.io/vivainsights/reference/p2p_data.md),
[`p2p_data_sim()`](https://microsoft.github.io/vivainsights/reference/p2p_data_sim.md)
