# Find the right vivainsights function

## Find the right function

Start with the task below before writing custom `dplyr`, `ggplot2`, or
network code. The package functions apply established Viva Insights
aggregation and privacy conventions.

| Task | Start with | Input | Returns | Python parity |
|----|----|----|----|----|
| Import and prepare a Viva Insights query | [`import_query()`](https://microsoft.github.io/vivainsights/reference/import_query.md) | Viva Insights CSV export | data frame | [`import_query()`](https://microsoft.github.io/vivainsights/reference/import_query.md) (partial) |
| Validate query structure and data quality | [`validation_report()`](https://microsoft.github.io/vivainsights/reference/validation_report.md) | Person or meeting query | HTML validation report | r_only |
| Inspect available HR attributes | [`hrvar_count_all()`](https://microsoft.github.io/vivainsights/reference/hrvar_count_all.md) | Person query | message or table | [`hrvar_count_all()`](https://microsoft.github.io/vivainsights/reference/hrvar_count_all.md) (partial) |
| Compare a metric across groups | [`create_bar()`](https://microsoft.github.io/vivainsights/reference/create_bar.md) | Person-period query | ggplot or summary table | [`create_bar()`](https://microsoft.github.io/vivainsights/reference/create_bar.md) (partial) |
| Plot a metric over time | [`create_line()`](https://microsoft.github.io/vivainsights/reference/create_line.md) | Person-period query | ggplot or summary table | [`create_line()`](https://microsoft.github.io/vivainsights/reference/create_line.md) (partial) |
| Inspect a metric distribution | [`create_dist()`](https://microsoft.github.io/vivainsights/reference/create_dist.md) | Person-period query | ggplot or summary table | r_only |
| Rank groups by a metric | [`create_rank()`](https://microsoft.github.io/vivainsights/reference/create_rank.md) | Person-period query | ggplot or ranking table | [`create_rank()`](https://microsoft.github.io/vivainsights/reference/create_rank.md) (partial) |
| Summarize collaboration workload | [`collaboration_summary()`](https://microsoft.github.io/vivainsights/reference/collaboration_sum.md) | Person-period query | ggplot or summary table | r_only |
| Segment people by product usage | [`identify_usage_segments()`](https://microsoft.github.io/vivainsights/reference/identify_usage_segments.md) | Person-period query | person-level data, table, or plot | [`identify_usage_segments()`](https://microsoft.github.io/vivainsights/reference/identify_usage_segments.md) (partial) |
| Measure retention between periods | [`identify_retention()`](https://microsoft.github.io/vivainsights/reference/identify_retention.md) | Person-period data with a category column | message, table, or detailed data | r_only |
| Compare a profile of several metrics | [`create_radar()`](https://microsoft.github.io/vivainsights/reference/create_radar.md) | Person-period query | ggplot or indexed data | [`create_radar()`](https://microsoft.github.io/vivainsights/reference/create_radar.md) (partial) |
| Analyze time to adoption or another event | [`create_survival()`](https://microsoft.github.io/vivainsights/reference/create_survival.md) | Person-period event data | ggplot or survival calculation data | [`create_survival()`](https://microsoft.github.io/vivainsights/reference/create_survival.md) (partial) |
| Analyze a person-to-person collaboration network | [`network_p2p()`](https://microsoft.github.io/vivainsights/reference/network_p2p.md) | Single-date person-to-person query | plot, table, node data, Sankey chart, or igraph object | [`network_p2p()`](https://microsoft.github.io/vivainsights/reference/network_p2p.md) (partial) |
| Analyze a group-to-group collaboration network | [`network_g2g()`](https://microsoft.github.io/vivainsights/reference/network_g2g.md) | Group-to-group query | plot or igraph object | [`network_g2g()`](https://microsoft.github.io/vivainsights/reference/network_g2g.md) (partial) |
| Anonymize identifiers and HR attributes | [`anonymise()`](https://microsoft.github.io/vivainsights/reference/anonymise.md) | Viva Insights query | anonymized data frame | r_only |
| Generate a reusable analysis report | [`generate_report()`](https://microsoft.github.io/vivainsights/reference/generate_report.md) | Person query | rendered report files | r_only |

### Workflow details

#### Import and prepare a Viva Insights query

**Use:**
[`import_query()`](https://microsoft.github.io/vivainsights/reference/import_query.html)

**Typical requests:** read a Viva Insights CSV, import a person query,
prepare query data

**Required columns:** None specified

**Privacy:** Import does not apply disclosure thresholds; validate and
aggregate before sharing results.

**Returns:** data frame

``` r

import_query("Person Query.csv")
```

**Related functions:**
[`check_query()`](https://microsoft.github.io/vivainsights/reference/check_query.md),
[`prep_query()`](https://microsoft.github.io/vivainsights/reference/prep_query.md),
[`validation_report()`](https://microsoft.github.io/vivainsights/reference/validation_report.md)

#### Validate query structure and data quality

**Use:**
[`validation_report()`](https://microsoft.github.io/vivainsights/reference/validation_report.html)

**Typical requests:** validate a query, check data quality, diagnose
missing Viva Insights fields

**Required columns:** None specified

**Privacy:** Validation reports may describe small groups; review output
before sharing.

**Returns:** HTML validation report

``` r

validation_report(pq_data)
```

**Related functions:**
[`check_query()`](https://microsoft.github.io/vivainsights/reference/check_query.md),
[`extract_hr()`](https://microsoft.github.io/vivainsights/reference/extract_hr.md),
[`hrvar_count_all()`](https://microsoft.github.io/vivainsights/reference/hrvar_count_all.md)

#### Inspect available HR attributes

**Use:**
[`hrvar_count_all()`](https://microsoft.github.io/vivainsights/reference/hrvar_count_all.html)

**Typical requests:** find grouping variables, count HR attribute
levels, choose an HR variable

**Required columns:** PersonId

**Privacy:** Use the counts to avoid selecting attributes that create
groups below the disclosure threshold.

**Returns:** message or table

``` r

hrvar_count_all(pq_data, return = "table")
```

**Related functions:**
[`extract_hr()`](https://microsoft.github.io/vivainsights/reference/extract_hr.md),
[`identify_privacythreshold()`](https://microsoft.github.io/vivainsights/reference/identify_privacythreshold.md)

#### Compare a metric across groups

**Use:**
[`create_bar()`](https://microsoft.github.io/vivainsights/reference/create_bar.html)

**Typical requests:** compare organizations, plot a metric by HR
attribute, summarize group averages

**Required columns:** PersonId

**Privacy:** Groups with fewer than mingroup distinct people are
excluded.

**Returns:** ggplot or summary table

``` r

create_bar(pq_data, metric = "Collaboration_hours", hrvar = "Organization")
```

**Related functions:**
[`create_boxplot()`](https://microsoft.github.io/vivainsights/reference/create_boxplot.md),
[`create_rank()`](https://microsoft.github.io/vivainsights/reference/create_rank.md),
[`create_bar_asis()`](https://microsoft.github.io/vivainsights/reference/create_bar_asis.md)

#### Plot a metric over time

**Use:**
[`create_line()`](https://microsoft.github.io/vivainsights/reference/create_line.html)

**Typical requests:** create a time trend, compare weekly metrics, plot
change over time

**Required columns:** PersonId, MetricDate

**Privacy:** Groups with fewer than mingroup distinct people are
excluded.

**Returns:** ggplot or summary table

``` r

create_line(pq_data, metric = "Collaboration_hours", hrvar = "Organization")
```

**Related functions:**
[`create_trend()`](https://microsoft.github.io/vivainsights/reference/create_trend.md),
[`hr_trend()`](https://microsoft.github.io/vivainsights/reference/hr_trend.md),
[`collaboration_trend()`](https://microsoft.github.io/vivainsights/reference/collaboration_trend.md)

#### Inspect a metric distribution

**Use:**
[`create_dist()`](https://microsoft.github.io/vivainsights/reference/create_dist.html)

**Typical requests:** plot a distribution, inspect metric spread,
compare distributions by group

**Required columns:** PersonId

**Privacy:** Groups with fewer than mingroup distinct people are
excluded.

**Returns:** ggplot or summary table

``` r

create_dist(pq_data, metric = "Collaboration_hours", hrvar = "Organization")
```

**Related functions:**
[`create_density()`](https://microsoft.github.io/vivainsights/reference/create_density.md),
[`create_hist()`](https://microsoft.github.io/vivainsights/reference/create_hist.md),
[`create_boxplot()`](https://microsoft.github.io/vivainsights/reference/create_boxplot.md)

#### Rank groups by a metric

**Use:**
[`create_rank()`](https://microsoft.github.io/vivainsights/reference/create_rank.html)

**Typical requests:** rank organizations, identify high and low groups,
compare group performance

**Required columns:** PersonId

**Privacy:** Groups with fewer than mingroup distinct people are
excluded.

**Returns:** ggplot or ranking table

``` r

create_rank(pq_data, metric = "Collaboration_hours", hrvar = "Organization")
```

**Related functions:**
[`create_bar()`](https://microsoft.github.io/vivainsights/reference/create_bar.md),
[`create_rank_combine()`](https://microsoft.github.io/vivainsights/reference/create_rank_combine.md)

#### Summarize collaboration workload

**Use:**
[`collaboration_summary()`](https://microsoft.github.io/vivainsights/reference/collaboration_summary.html)

**Typical requests:** analyze collaboration hours, summarize meetings
and email, compare collaboration patterns

**Required columns:** PersonId

**Privacy:** Groups with fewer than mingroup distinct people are
excluded.

**Returns:** ggplot or summary table

``` r

collaboration_summary(pq_data, hrvar = "Organization")
```

**Related functions:**
[`collaboration_area()`](https://microsoft.github.io/vivainsights/reference/collaboration_area.md),
[`collaboration_dist()`](https://microsoft.github.io/vivainsights/reference/collaboration_dist.md),
[`collaboration_rank()`](https://microsoft.github.io/vivainsights/reference/collaboration_rank.md)

#### Segment people by product usage

**Use:**
[`identify_usage_segments()`](https://microsoft.github.io/vivainsights/reference/identify_usage_segments.html)

**Typical requests:** classify usage segments, find power users, analyze
adoption maturity

**Required columns:** PersonId, MetricDate

**Privacy:** Review segment counts before sharing; downstream summaries
should apply disclosure thresholds.

**Returns:** person-level data, table, or plot

``` r

identify_usage_segments(pq_data, metric = "Copilot_Chat_active_days")
```

**Related functions:**
[`identify_habit()`](https://microsoft.github.io/vivainsights/reference/identify_habit.md),
[`create_rogers()`](https://microsoft.github.io/vivainsights/reference/create_rogers.md),
[`identify_retention()`](https://microsoft.github.io/vivainsights/reference/identify_retention.md)

#### Measure retention between periods

**Use:**
[`identify_retention()`](https://microsoft.github.io/vivainsights/reference/identify_retention.html)

**Typical requests:** calculate retention, track retained power users,
compare category membership over time

**Required columns:** PersonId, MetricDate

**Privacy:** Review returned counts and suppress small categories before
sharing.

**Returns:** message, table, or detailed data

``` r

identify_retention(data, start_x = "2026-01-01", end_x = "2026-02-01", start_y = "2026-02-01", end_y = "2026-03-01", category = "Segment", category_values = "Power User")
```

**Related functions:**
[`identify_usage_segments()`](https://microsoft.github.io/vivainsights/reference/identify_usage_segments.md),
[`identify_churn()`](https://microsoft.github.io/vivainsights/reference/identify_churn.md)

#### Compare a profile of several metrics

**Use:**
[`create_radar()`](https://microsoft.github.io/vivainsights/reference/create_radar.html)

**Typical requests:** create a radar chart, compare groups across
metrics, normalize a metric profile

**Required columns:** PersonId

**Privacy:** Groups with fewer than mingroup distinct people are
excluded.

**Returns:** ggplot or indexed data

``` r

create_radar(pq_data, metrics = c("Email_hours", "Meeting_hours"), hrvar = "Organization")
```

**Related functions:**
[`create_radar_calc()`](https://microsoft.github.io/vivainsights/reference/create_radar_calc.md),
[`create_radar_viz()`](https://microsoft.github.io/vivainsights/reference/create_radar_viz.md)

#### Analyze time to adoption or another event

**Use:**
[`create_survival()`](https://microsoft.github.io/vivainsights/reference/create_survival.html)

**Typical requests:** create a survival curve, analyze time to adoption,
compare event timing by group

**Required columns:** PersonId, MetricDate

**Privacy:** Apply an appropriate mingroup threshold to group
comparisons.

**Returns:** ggplot or survival calculation data

``` r

create_survival(surv_data, time_col = "time", event_col = "event", hrvar = "Organization")
```

**Related functions:**
[`create_survival_prep()`](https://microsoft.github.io/vivainsights/reference/create_survival_prep.md),
[`create_survival_calc()`](https://microsoft.github.io/vivainsights/reference/create_survival_calc.md),
[`create_survival_viz()`](https://microsoft.github.io/vivainsights/reference/create_survival_viz.md)

#### Analyze a person-to-person collaboration network

**Use:**
[`network_p2p()`](https://microsoft.github.io/vivainsights/reference/network_p2p.html)

**Typical requests:** create a person network, find network communities,
calculate network centrality

**Required columns:** PrimaryCollaborator_PersonId,
SecondaryCollaborator_PersonId

**Privacy:** Network outputs can identify individuals; apply
organizational privacy and disclosure policy.

**Returns:** plot, table, node data, Sankey chart, or igraph object

``` r

network_p2p(p2p_data, return = "network")
```

**Related functions:**
[`network_summary()`](https://microsoft.github.io/vivainsights/reference/network_summary.md),
[`p2p_data_sim()`](https://microsoft.github.io/vivainsights/reference/p2p_data_sim.md),
[`create_sankey()`](https://microsoft.github.io/vivainsights/reference/create_sankey.md)

#### Analyze a group-to-group collaboration network

**Use:**
[`network_g2g()`](https://microsoft.github.io/vivainsights/reference/network_g2g.html)

**Typical requests:** create an organization network, compare group
connections, analyze collaboration between teams

**Required columns:** None specified

**Privacy:** Confirm source query groups meet disclosure requirements.

**Returns:** plot or igraph object

``` r

network_g2g(g2g_data)
```

**Related functions:**
[`network_p2p()`](https://microsoft.github.io/vivainsights/reference/network_p2p.md),
[`network_summary()`](https://microsoft.github.io/vivainsights/reference/network_summary.md)

#### Anonymize identifiers and HR attributes

**Use:**
[`anonymise()`](https://microsoft.github.io/vivainsights/reference/anonymise.html)

**Typical requests:** anonymize employee data, remove identifying
information, prepare sample data safely

**Required columns:** None specified

**Privacy:** Anonymization reduces direct identifiers but does not
replace disclosure review.

**Returns:** anonymized data frame

``` r

anonymise(pq_data)
```

**Related functions:**
[`anonymize()`](https://microsoft.github.io/vivainsights/reference/anonymise.md),
[`jitter_metrics()`](https://microsoft.github.io/vivainsights/reference/jitter_metrics.md),
[`identify_privacythreshold()`](https://microsoft.github.io/vivainsights/reference/identify_privacythreshold.md)

#### Generate a reusable analysis report

**Use:**
[`generate_report()`](https://microsoft.github.io/vivainsights/reference/generate_report.html)

**Typical requests:** create an HTML report, generate a wellbeing
report, automate analysis output

**Required columns:** PersonId

**Privacy:** Review the generated report and its grouping thresholds
before distribution.

**Returns:** rendered report files

``` r

generate_report(title = "Viva Insights report", filename = "report", outputs = output_list, titles = title_list, subheaders = rep("", length(output_list)), echos = rep(FALSE, length(output_list)), levels = rep(2, length(output_list)))
```

**Related functions:**
[`generate_report2()`](https://microsoft.github.io/vivainsights/reference/generate_report2.md),
[`validation_report()`](https://microsoft.github.io/vivainsights/reference/validation_report.md)
