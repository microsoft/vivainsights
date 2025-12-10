# Data validation

This section covers the topic of **how to validate Viva Insights data**.
Before you apply any functions to your data set and start looking for
new insights, it is recommended that you perform data validation. This
best practice is applicable regardless of whether your aim is to explore
the data, to establish a baseline, or to perform advanced analytics.

## Why validate?

Data validation is an essential routine for every analyst as it ensures
that you can trust the data you are using to be accurate, clean and
helpful. Data validation ensures that your dataset provides a good basis
for your analyses, and acts as a proactive intervention to safeguard
your analyses from the starting point.

There are several additional reasons why you should validate your Viva
Insights data.

1.  There may be gaps, anomalies, or errors in the organizational data,
    such as missing data or excessive / insufficient granularity. This
    may require rectifying at source, or the resulting data should be
    interpreted differently, e.g. any biases caveated or accounted for.
2.  Outliers may exist in Viva Insights data, and often for very
    legitimate reasons. For instance, collaboration hours for a
    particular week or employee may be significantly low due to public
    holidays or paid time off. If these outliers are not surfaced and
    addressed accordingly, the interpretation of the data may be
    incorrect.

In a nutshell, it is good practice to have a comprehensive understanding
of the data context and checks for common biases, errors, and anomalies
prior to analysis, as otherwise we would risk the quality and the
reliability of the analysis.

## Know what you are looking at

Before you begin with data validation, it’s helpful to know what data
set you are looking at, which includes information such as:

- What query type is loaded
- Number of unique employees in the dataset
- Date range of the dataset
- Organizational attributes int he dataset

This can all be done with
[`check_query()`](https://microsoft.github.io/vivainsights/reference/check_query.md):

``` r
library(vivainsights)
check_query(pq_data)
```

The resulting output would look something like the following and will
give you an initial view into your data:

    There are 100 employees in this dataset.

    Date ranges from 2022-05-01 to 2022-07-03.

    There are 6 (estimated) HR attributes in the data:
    `PersonId`, `LevelDesignation`, `SupervisorIndicator`, `Organization`, `FunctionType`, `WeekendDays`

    There are 100 active employees out of all in the dataset.

    Variable name check:

    `Collaboration_hours` is used instead of `Collaboration_hrs` in the data.

    No instant message hour metric exists in the data.

The below functions are also helpful for exploring your data:

1.  Get all column names, e.g. `names(pq_data)`
2.  Check object type, e.g. `class(pq_data$MetricDate)`
3.  Get summary statistics, e.g. `summary(pq_data)`
4.  Compute number of unique values,
    e.g. `length(unique(pq_data$PersonId))`
5.  Get an overview of the data, e.g. `dplyr::glimpse(pq_data)`, or
    `skimr::skim(pq_data)`.
6.  View the entire dataset - `View(pq_data)` (not recommended for large
    datasets)

Validating the structure of your data is just as important as validating
the data itself. You may wish to check that your data is correctly
imported into R if you observe certain anomalies, such as:

- Unexpected / misspelt column names
- Unexpected number of rows in the data
- Unexpectedly high number of missing or unique values
- `Date` variable is showing up as a variable type that is neither
  *character* nor *Date* type

## Data Validation Report

An easy way to perform data validation with the **vivainsights** package
is to run the data validation report:

``` r
 # `pq_data` is your Person Query data
validation_report(pq_data)
```

This function generates an interactive HTML report in your working
directory which contains a series of checks against your data,
including:

- Viva Insights Settings
- Organizational Data Quality
- M365 Data Quality

You can find a demo output of the validation report
[here](https://microsoft.github.io/wpa/report-demo/validation-report-demo.html).
Note that
[`validation_report()`](https://microsoft.github.io/vivainsights/reference/validation_report.md)
only runs with a Standard Person Query, but you can supply an optional
meeting query to include checks against meeting subject lines. To do so,
you should run:

``` r
# Assuming:
# `pq_data` is your Person Query data
# `mt_data` is your Meeting Query data
validation_report(
  pq_data, 
  meeting_data = mt_data
  )
```

The data validation report provides you with a series of recommendations
on whether you should adjust certain settings or consider certain
assumptions before proceeding with your analysis. After you have made
the relevant adjustments, you can run the ‘cleaned’ dataset through
[`validation_report()`](https://microsoft.github.io/vivainsights/reference/validation_report.md)
again to make sure that the potential issues have been caught out.

Note that
[`validation_report()`](https://microsoft.github.io/vivainsights/reference/validation_report.md)
only provides recommendations based on common scenarios observed with
Viva Insights data. When deciding whether to make an adjustment, you
should consider other factors such as quality of organizational data,
context, and other known collaboration norms within the organization.

## Individual functions

The **vivainsights** package provides additional data validation
functions to be used prior to embarking on a new analysis. These
functions make up the majority of the automated checks of
[`validation_report()`](https://microsoft.github.io/vivainsights/reference/validation_report.md),
where you can run them individually to extract more detailed information
(for instance, the report may identify certain employees as
*non-knowledge workers*, but does the distribution of these workers with
respect to organization make sense? ). The key data validation functions
are described below.

### Organizational attributes

[`check_query()`](https://microsoft.github.io/vivainsights/reference/check_query.md)
performs a check on a query (data frame) and returns a diagnostic
message about the data query to the R console, with information such as
date range, number of employees, HR attributes identified, etc.

``` r
check_query(pq_data)
```

[`hrvar_count()`](https://microsoft.github.io/vivainsights/reference/hrvar_count.md)
enables you to create a count of the distinct people by the specified HR
attribute:

``` r
hrvar_count(pq_data, hrvar = "LevelDesignation")
```

To run a blanket analysis for all the organizational attributes in the
dataset, you can run
[`hrvar_count_all()`](https://microsoft.github.io/vivainsights/reference/hrvar_count_all.md)
instead.

Also check out:

- [`identify_privacythreshold()`](https://microsoft.github.io/vivainsights/reference/identify_privacythreshold.md)
- [`track_HR_change()`](https://microsoft.github.io/vivainsights/reference/track_HR_change.md)
- [`identify_tenure()`](https://microsoft.github.io/vivainsights/reference/identify_tenure.md)

Click on the linked functions to find out more.

### M365 Data Quality

There are three common reasons for removing certain employees or weeks
from the data:

1.  A given *week* is likely a **public holiday** which impacts a
    significant proportion of the organization, e.g. Christmas, New
    Year.
2.  An *employee* is a **non-knowledge worker** - in the sense that
    collaboration via emails and meetings is not a key part of their
    role.
3.  An employee is off work for *certain weeks* due to annual leave,
    sabbaticals, etc. which do not necessarily coincide with public
    holidays.

There are three functions in **wpa** to address each these respective
scenarios:

1.  [`identify_holidayweeks()`](https://microsoft.github.io/vivainsights/reference/identify_holidayweeks.md)
    identifies weeks where collaboration hours are low outliers for the
    entire organization.
2.  [`identify_nkw()`](https://microsoft.github.io/vivainsights/reference/identify_nkw.md)
    identifies employees with overall low collaboration signals, based
    on average collaboration hours. In addition to non-knowledge
    workers, this method would also capture any effective part-timers or
    freelancers, where their collaboration hours are significantly low.
3.  [`identify_inactiveweeks()`](https://microsoft.github.io/vivainsights/reference/identify_inactiveweeks.md)
    identifies individual weeks where collaboration hours are low
    outliers for the entire organization.

Functions (1) to (3) all come with options to return only the ‘clean’
dataset or the original dataset with an appended flag to identify the
anomalous persons/weeks. As per above, you can click on the linked
functions to find out more.

#### Example data clean-up

Below is an example of one might create a ‘clean’ dataset using the
functions above:

``` r
library(vivainsights)
library(tidyverse) # You may also just load dplyr

clean_spq <-
  raw_wowa %>% # Loaded in as a Ways of Working query
  identify_nkw(collab_threshold = 4.99999, return = "data_cleaned") %>% # >= 5 CH
  identify_inactiveweeks(sd = 2, return = "data_cleaned") %>% # 2 SD
  filter(Date >= as.Date("08/30/2020", "%m/%d/%Y")) %>% # Trim start date
  filter(Date <= as.Date("03/07/2021", "%m/%d/%Y")) %>% # Trim end date
  filter(Date != as.Date("11/22/2020", "%m/%d/%Y")) # Remove certain weeks
```
