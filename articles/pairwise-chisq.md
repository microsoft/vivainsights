# Running pairwise chi-square tests with the \`vivainsights\` R library

This script shows an example of how to perform pairwise chi-square tests
for categorical variables in a dataset.

A pairwise chi-square test helps detect associations between distinct
pairs of categorical variables. By running multiple chi-square tests on
each pair, it allows you to pinpoint which specific pairs exhibit
significant relationships.

## Step 1: load libraries and sample data

In this example, we will use the sample `pq_data` dataset from the
**vivainsights** package. We will also use **dplyr** and **purrr** for
data manipulation and iteration respectively, and optionally you can
just load the **tidyverse** package instead.

``` r
library(vivainsights)
library(dplyr)
library(purrr)

sample_data <- pq_data
```

## Step 2: simulating a dataset with categorical variables

The next step is to simulate additional categorical variables for the
sample data. In this example, we will create three fake categorical
variables: `Teams`, `Regions`, and `Functions`. We will then merge these
variables with the sample data.

``` r
# Set random seed for reproducibility
set.seed(123)

# Number of unique PersonId in data
n_personid <- length(unique(sample_data$PersonId))

# Create fake categorical variables for each PersonId
cat_data <- data.frame(
  PersonId = unique(sample_data$PersonId),
  Teams = sample(c('Team 1', 'Team 2', 'Team 3'), size = n_personid, replace = TRUE),
  Regions = sample(c('East', 'South', 'West', 'North'), size = n_personid, replace = TRUE),
  Functions = sample(c('HR', 'Finance', 'Operations', 'Sales'), size = n_personid, replace = TRUE)
)

# Merge the datasets
sample_data_merged <- merge(sample_data, cat_data, by = "PersonId")

# Assign categorical variables names to `cat_vars`, alongside existing variables
cat_vars <- c("Teams", "Regions", "Functions", "Organization", "LevelDesignation")
```

## Step 3: Perform pairwise chi-square tests for all categorical variables

In the following, we first use
[`combn()`](https://rdrr.io/r/utils/combn.html) to generate all
combinations of variable pairs.
[`combn()`](https://rdrr.io/r/utils/combn.html) comes from the **utils**
package, and generates all combinations of a vector of elements of a
given size. Here, we set `m = 2` to yield pairs.

Next, we use
[`map_dfr()`](https://purrr.tidyverse.org/reference/map_dfr.html) from
the **purrr** package to loop over each combination and perform a
chi-square test. The operation is similar to a for loop, but the results
are row-bound (similar to [`rbind()`](https://rdrr.io/r/base/cbind.html)
or
[`bind_rows()`](https://dplyr.tidyverse.org/reference/bind_rows.html))
and returned as a data frame. In R, it is generally more efficient to
use [`map()`](https://purrr.tidyverse.org/reference/map.html) functions
from the **purrr** package than to use for loops.

Towards the end of the code, we add a significance level to the results
based on the p-value. The significance level is denoted by asterisks,
where `***` indicates p \< 0.001, `**` indicates p \< 0.01, and `*`
indicates p \< 0.05.

``` r
# Generate all combinations of variable pairs
cat_var_combinations <- combn(x = cat_vars, m = 2, simplify = FALSE)

# Use `map_dfr()` to loop over each combination
results_df <-
  map_dfr(cat_var_combinations, ~{
  var1 <- .x[1]
  var2 <- .x[2]
  
  # Create a contingency table
  contingency_table <- table(sample_data_merged[[var1]], sample_data_merged[[var2]])
  
  # Perform chi-square test
  chi_test <- chisq.test(contingency_table)
  
  # Return data frame with results
  tibble(
    var1 = var1,
    var2 = var2,
    chi2 = chi_test$statistic,
    p = chi_test$p.value,
    n = sum(contingency_table)
  ) %>%
    # Add significance level
    mutate(
      significance = case_when(
        p < 0.001 ~ "***",
        p < 0.01 ~ "**",
        p < 0.05 ~ "*",
        TRUE ~ ""
    ))
})

print(results_df)
```

    ## # A tibble: 10 × 6
    ##    var1         var2              chi2         p     n significance
    ##    <chr>        <chr>            <dbl>     <dbl> <int> <chr>       
    ##  1 Teams        Regions          186.  1.98e- 37  6900 ***         
    ##  2 Teams        Functions         69.7 4.69e- 13  6900 ***         
    ##  3 Teams        Organization     325.  3.19e- 62  6900 ***         
    ##  4 Teams        LevelDesignation 127.  6.93e- 25  6900 ***         
    ##  5 Regions      Functions        243.  2.39e- 47  6900 ***         
    ##  6 Regions      Organization     306.  2.93e- 54  6900 ***         
    ##  7 Regions      LevelDesignation 145.  7.75e- 27  6900 ***         
    ##  8 Functions    Organization     277.  2.14e- 48  6900 ***         
    ##  9 Functions    LevelDesignation  92.8 4.43e- 16  6900 ***         
    ## 10 Organization LevelDesignation 835.  1.40e-165  6900 ***

Finally, you can export the results to csv or clipboard using the
following code:

``` r
# Copy to clipboard
results_df %>% export(method = "clipboard")

# Export to csv
results_df %>% export(method = "csv", path = "chi-square-results", timestamp = FALSE)
```
