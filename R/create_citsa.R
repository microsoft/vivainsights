# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See LICENSE.txt in the project root for license information.
# --------------------------------------------------------------------------------------------

#' @title
#' Estimate intervention effects using Controlled Interrupted Time-Series 
#' Analysis (CITSA) with treatment and control groups
#'
#' @author Martin Chan <martin.chan@@microsoft.com>
#'
#' @description
#' `r lifecycle::badge('experimental')`
#'
#' This function implements a controlled (comparative) interrupted time-series 
#' analysis method as described in Linden (2015). Unlike single-group ITSA, 
#' this approach uses a control group to account for secular trends and 
#' external factors, providing stronger causal inference about intervention 
#' effects.
#'
#' The function estimates a segmented regression model with interaction terms 
#' to compare changes in outcomes between treatment and control groups before 
#' and after an intervention. This method is particularly valuable when you 
#' want to distinguish intervention effects from general time trends affecting 
#' both groups.
#'
#' This function requires the installation of 'sandwich' and 'lmtest' packages
#' from CRAN to handle autocorrelation and heteroscedasticity in time-series data.
#'
#' @details
#' ## Statistical Model
#' 
#' The function fits the following segmented regression model:
#' 
#' \deqn{Y_t = \beta_0 + \beta_1 T_t + \beta_2 X_t + \beta_3 X_t T_t + \beta_4 Z + 
#'       \beta_5 Z T_t + \beta_6 Z X_t + \beta_7 Z X_t T_t + \epsilon_t}
#' 
#' Where:
#' - \eqn{Y_t}: Outcome metric at time t
#' - \eqn{T_t}: Time variable (continuous, centered at intervention)
#' - \eqn{X_t}: Intervention indicator (0 = pre-intervention, 1 = post-intervention)
#' - \eqn{Z}: Group indicator (0 = treatment, 1 = control)
#' - \eqn{\epsilon_t}: Error term
#'
#' ## Key Coefficients and Interpretation
#' 
#' **Treatment Group Effects:**
#' - \eqn{\beta_2}: Immediate level change in treatment group at intervention
#' - \eqn{\beta_3}: Change in slope (trend) in treatment group after intervention
#' 
#' **Control Group Effects:**
#' - \eqn{\beta_2 + \beta_6}: Immediate level change in control group
#' - \eqn{\beta_3 + \beta_7}: Change in slope in control group
#' 
#' **Differential Effects (Treatment vs Control):**
#' - \eqn{\beta_6}: Difference in immediate intervention effect between groups
#' - \eqn{\beta_7}: Difference in slope change between groups
#' 
#' **Critical for Causal Inference:**
#' Focus on \eqn{\beta_6} and \eqn{\beta_7} with their p-values. Significant values 
#' indicate that the intervention had different effects on treatment vs control 
#' groups, suggesting a true intervention effect beyond secular trends.
#'
#' ## Assumptions and Recommendations
#' 
#' This method assumes:
#' 
#' 1. **Parallel Trends**: Treatment and control groups would have followed 
#'    similar trends in the absence of intervention. Verify this by examining 
#'    pre-intervention trends.
#'    
#' 2. **Group Comparability**: Treatment and control groups are similar in 
#'    baseline characteristics. If not comparable, consider:
#'    - Propensity score matching before analysis
#'    - Inverse probability weighting
#'    - Covariate adjustment in the model
#'    - Stratification by key characteristics
#'    
#' 3. **No Contamination**: Control group is not affected by the intervention 
#'    (no spillover effects).
#'    
#' 4. **Stable Composition**: Group membership doesn't change over time, or 
#'    changes are minimal and random.
#'
#' ## Autocorrelation Handling
#' 
#' The function automatically tests for autocorrelation using the Ljung-Box test 
#' and applies Newey-West heteroscedasticity and autocorrelation consistent (HAC) 
#' standard errors when needed. This ensures valid inference even with correlated 
#' residuals common in time-series data.
#'
#' ## References
#' 
#' Linden, A. (2015). Conducting interrupted time-series analysis for single- and 
#' multiple-group comparisons. The Stata Journal, 15(2), 480-500.
#'
#' @param data Person Query as a data frame including date column named
#'   `MetricDate`. This function assumes the date format is `%Y-%m-%d` as is
#'   standard in a Viva Insights query output.
#' @param metrics A character vector containing the variable names to perform
#'   the controlled interrupted time series analysis for.
#' @param control String specifying the name of a binary column that 
#'   identifies the control group. This column should contain logical values 
#'   (TRUE/FALSE) or 0/1, where TRUE (or 1) indicates control group membership 
#'   and FALSE (or 0) indicates treatment group membership. For example, if you 
#'   have a column "IsControl" where TRUE means control group, pass "IsControl" 
#'   as this parameter.
#' @param before_start String specifying the start date of the 'before'
#'   time period in `%Y-%m-%d` format. The 'before' time period refers to the
#'   period before the intervention occurs. If not provided, this defaults to 
#'   the earliest date in the dataset. Longer pre-intervention periods increase 
#'   statistical power and allow better assessment of parallel trends assumption.
#' @param before_end String specifying the end date of 'before' time
#'   period in `%Y-%m-%d` format. This parameter is required and defines the 
#'   last date before the intervention. The intervention is assumed to occur 
#'   between `before_end` and `after_start`.
#' @param after_start String specifying the start date of the 'after'
#'   time period in `%Y-%m-%d` format. If `NULL`, this will default to the value
#'   of `before_end`, assuming immediate intervention effect. The 'after' time 
#'   period refers to the post-intervention period. Longer post-intervention 
#'   periods improve detection of sustained effects and trend changes.
#' @param after_end String specifying the end date of the 'after' time
#'   period in `%Y-%m-%d` format. If not provided, defaults to the latest date 
#'   in the dataset.
#' @param ac_lags_max Numeric value specifying the maximum lag for the 
#'   Ljung-Box autocorrelation test. The test checks for autocorrelation in 
#'   model residuals up to this number of lags. Higher values test for 
#'   longer-term dependencies. Default is 7. Consider increasing for data with 
#'   strong seasonal patterns or long-memory processes.
#' @param return String specifying what output to return. Valid options:
#'   - `'table'` (default): Returns a data frame with estimated coefficients, 
#'     p-values, and diagnostic information for all metrics.
#'   - `'plot'`: Returns a list of plots showing observed data, fitted lines 
#'     for both groups, and intervention effects.
#'   - `'plot_combined'`: Returns plots with treatment and control groups 
#'     overlaid on the same panel for direct comparison.
#'   - `'plot_difference'`: Returns plots showing the difference between 
#'     treatment and control groups over time, highlighting the differential 
#'     intervention effect.
#'
#' @import dplyr
#' @import ggplot2
#'
#' @family Flexible Input
#' @family Interrupted Time-Series Analysis
#'
#' @examples
#' \dontrun{
#' library(dplyr)
#' 
#' # Simulate a controlled experiment dataset
#' # Randomly assign 40% of unique PersonIds to control group
#' set.seed(123)
#' unique_persons <- unique(pq_data$PersonId)
#' control_persons <- sample(unique_persons, size = floor(0.4 * length(unique_persons)))
#' 
#' # Create control group indicator and simulate an intervention effect
#' pq_data_citsa <- pq_data %>%
#'   mutate(
#'     IsControl = PersonId %in% control_persons,
#'     # Simulate intervention effect: treatment group gets 15% boost in collaboration
#'     # after 2024-07-01, control group has only a 3% trend increase
#'     Collaboration_hours_modified = case_when(
#'       MetricDate > as.Date("2024-07-01") & !IsControl ~ 
#'         Collaboration_hours * 1.15,
#'       MetricDate > as.Date("2024-07-01") & IsControl ~ 
#'         Collaboration_hours * 1.03,
#'       TRUE ~ Collaboration_hours
#'     )
#'   )
#'
#' # Returns summary table with comparative effects
#' create_citsa(
#'   data = pq_data_citsa,
#'   metrics = c("Collaboration_hours_modified", "Meeting_hours"),
#'   control = "IsControl",
#'   before_end = "2024-07-01",
#'   after_start = "2024-07-01",
#'   ac_lags_max = 7,
#'   return = "table"
#' )
#'
#' # Returns list of plots with separate panels
#' plot_list <-
#'   create_citsa(
#'     data = pq_data_citsa,
#'     metrics = c("Collaboration_hours_modified", "Meeting_hours"),
#'     control = "IsControl",
#'     before_end = "2024-07-01",
#'     after_start = "2024-07-01",
#'     return = "plot"
#'   )
#'
#' # Extract and view a specific plot
#' plot_list$Collaboration_hours_modified
#'
#' # Combined overlay plot for direct comparison
#' create_citsa(
#'   data = pq_data_citsa,
#'   metrics = "Collaboration_hours_modified",
#'   control = "IsControl",
#'   before_end = "2024-07-01",
#'   return = "plot_combined"
#' )
#'
#' # Difference plot showing intervention effect
#' create_citsa(
#'   data = pq_data_citsa,
#'   metrics = "Collaboration_hours_modified",
#'   control = "IsControl",
#'   before_end = "2024-07-01",
#'   return = "plot_difference"
#' )
#' }
#'
#' @return 
#' When 'table' is passed to `return`, a data frame with the following columns:
#' - `metric_name`: Name of the metric being analyzed.
#' - `beta_2`: Immediate level change in treatment group (intervention effect at time 0).
#' - `beta_3`: Slope change in treatment group (sustained trend change).
#' - `beta_6`: Differential immediate effect (treatment vs control) - **key for causal inference**.
#' - `beta_7`: Differential slope change (treatment vs control) - **key for causal inference**.
#' - `beta_2_pvalue`: P-value for treatment group immediate effect.
#' - `beta_3_pvalue`: P-value for treatment group slope change.
#' - `beta_6_pvalue`: P-value for differential immediate effect - **focus here for intervention impact**.
#' - `beta_7_pvalue`: P-value for differential slope change - **focus here for sustained impact**.
#' - `AR_flag`: Logical flag indicating whether autocorrelation was detected and corrected.
#' - `n_treatment`: Number of observations in treatment group.
#' - `n_control`: Number of observations in control group.
#' - `error_warning`: Error or warning message if applicable.
#' 
#' When 'plot', 'plot_combined', or 'plot_difference' is passed to `return`, 
#' returns a named list of ggplot objects, one for each metric.
#' 
#' @export

create_citsa <- function(
    data,
    metrics = NULL,
    control,
    before_start = NULL,
    before_end = NULL,
    after_start = NULL,
    after_end = NULL,
    ac_lags_max = 7,
    return = 'table'
) {
  
  ## Check inputs types
  stopifnot(is.data.frame(data))
  stopifnot(is.character(metrics) | is.null(metrics))
  stopifnot(is.character(control))
  stopifnot(is.character(before_start) | inherits(before_start, "Date") | is.null(before_start))
  stopifnot(is.character(before_end) | inherits(before_end, "Date") | is.null(before_end))
  stopifnot(is.character(after_start) | inherits(after_start, "Date") | is.null(after_start))
  stopifnot(is.character(after_end) | inherits(after_end, "Date") | is.null(after_end))
  stopifnot(is.numeric(ac_lags_max))
  stopifnot(is.character(return))
  
  # Check if control column exists
  if (!control %in% names(data)) {
    stop(paste0("Column '", control, "' not found in data. Please specify a valid control group column."))
  }
  
  # Set variables for min and max dates in `data`
  min_date <- min(data$MetricDate, na.rm = TRUE)
  max_date <- max(data$MetricDate, na.rm = TRUE)
  
  # If `before_start` is not provided, set it to the earliest date in the dataset
  if (is.null(before_start)) {
    before_start <- min_date
  }
  
  # Raise an error if `before_end` is NULL
  if (is.null(before_end)) {
    stop("The 'before_end' parameter must be provided.")
  }
  
  # If `after_start` is NULL, set it to the value of `before_end`
  if (is.null(after_start)) {
    after_start <- before_end
  }
  
  # If `after_end` is not provided, set it to the latest date in the dataset
  if (is.null(after_end)) {
    after_end <- max_date
  }
  
  # Check if dependencies are installed
  check_pkg_installed(pkgname = "sandwich")
  check_pkg_installed(pkgname = "lmtest")
  
  ## Check required columns in data
  required_variables <- c("MetricDate", "PersonId", control, metrics)
  
  ## Error message if variables are not present
  check_inputs(data, requirements = required_variables)
  
  # Parse the date strings
  before_start <- as.Date(before_start, "%Y-%m-%d")
  before_end <- as.Date(before_end, "%Y-%m-%d")
  after_start <- as.Date(after_start, "%Y-%m-%d")
  after_end <- as.Date(after_end, "%Y-%m-%d")
  
  # Debugging: Print the parsed dates
  message("Parsed dates:")
  message(paste("  before_start:", before_start))
  message(paste("  before_end:", before_end))
  message(paste("  after_start:", after_start))
  message(paste("  after_end:", after_end))
  
  # Check for missing dates
  if (any(is.na(c(before_start, before_end, after_start, after_end)))) {
    stop("One or more dates are missing.")
  }
  
  dateranges <- c(before_start, before_end, after_start, after_end)
  
  # Prepare dataset
  prepped_dataset <- 
    data %>%
    mutate(MetricDate = as.Date(MetricDate, "%Y-%m-%d")) %>%
    select(all_of(required_variables))
  
  # Check for dates in data file
  if (!all(dateranges >= min_date & dateranges <= max_date)){
    stop("Not all dates are found in the dataset")
  }
  
  # Convert control to numeric if needed (TRUE/1 = control, FALSE/0 = treatment)
  prepped_dataset <- prepped_dataset %>%
    mutate(Z = as.numeric(!!sym(control)))
  
  # Verify binary nature of control group
  if (!all(unique(prepped_dataset$Z) %in% c(0, 1))) {
    stop(paste0("Column '", control, "' must be binary (TRUE/FALSE or 1/0)."))
  }
  
  # Create variable => Period
  prepped_dataset_table <-
    prepped_dataset %>%
    mutate(
      Period = case_when(
        (before_start <= MetricDate) & (MetricDate <= before_end) ~ "Before",
        (after_start <= MetricDate) & (MetricDate <= after_end) ~ "After"
      )
    ) %>%
    filter(Period %in% c("Before", "After")) %>%
    mutate(X = case_when(Period == "Before" ~ 0, Period == "After" ~ 1))
  
  # Create "train" data with metrics and Date columns
  train <- 
    prepped_dataset_table %>%
    select(where(is.numeric), MetricDate) %>%
    drop_na()
  
  # Aggregate metric values at Date level for each group
  grouped_by_Date_train <- train %>% 
    group_by(MetricDate, Z)
  
  # Get metric names - exclude MetricDate, X, and Z columns
  metric_names <- setdiff(colnames(grouped_by_Date_train), c("MetricDate", "X", "Z"))
  
  # Create empty data.frame to save results
  results <- data.frame(
    metric_name = character(),
    beta_2 = double(),
    beta_3 = double(),
    beta_6 = double(),
    beta_7 = double(),
    beta_2_pvalue = double(),
    beta_3_pvalue = double(),
    beta_6_pvalue = double(),
    beta_7_pvalue = double(),
    AR_flag = logical(),
    n_treatment = integer(),
    n_control = integer(),
    error_warning = character()
  )
  
  # Create empty list to save plots
  results_plot <- list()
  
  # Perform CITSA for every metric in metric_names
  for (metric_name in metric_names) {
    
    error_flag <- FALSE
    AR_flag <- FALSE
    lm_train_success_flag <- FALSE
    
    buf_trycatch <- tryCatch({
      
      # Create a metric time-series by averaging metric values across users for each group
      metric_data <- grouped_by_Date_train %>%
        summarise(
          across(
            c(metric_name, "X"), mean, na.rm = TRUE
          ),
          .groups = "drop"
        )
      
      # Count observations per group
      n_treatment <- sum(metric_data$Z == 0)
      n_control <- sum(metric_data$Z == 1)
      
      # Transform metric_data into CITSA format
      # X is dummy variable: 0 = pre-intervention, 1 = post-intervention
      # Z is group indicator: 0 = treatment, 1 = control
      X <- metric_data[["X"]]
      num_Zeros <- length(X[metric_data$Z == 0]) - sum(X[metric_data$Z == 0]) + 1
      
      data_OLS <- metric_data %>%
        arrange(Z, MetricDate) %>%
        group_by(Z) %>%
        mutate(
          T = row_number(),
          T_centered = T - ifelse(Z == 0, num_Zeros, 
                                  length(T[Z == 1]) - sum(X[Z == 1]) + 1)
        ) %>%
        ungroup() %>%
        mutate(
          Y = .data[[metric_name]],
          XT = X * T_centered,
          ZT = Z * T_centered,
          ZX = Z * X,
          ZXT = Z * X * T_centered
        )
      
      # Fit comparative ITSA model: Y ~ T + X + XT + Z + ZT + ZX + ZXT
      citsa_model <- stats::lm(Y ~ T_centered + X + XT + Z + ZT + ZX + ZXT, data = data_OLS)
      
      # Newey-West variance estimator
      coeff_pvalues <- lmtest::coeftest(
        citsa_model,
        vcov = sandwich::NeweyWest(citsa_model, lag = 0, prewhite = FALSE)
      )
      
      beta_2 <- round(citsa_model$coefficients["X"], 3)
      beta_3 <- round(citsa_model$coefficients["XT"], 3)
      beta_6 <- round(citsa_model$coefficients["ZX"], 3)
      beta_7 <- round(citsa_model$coefficients["ZXT"], 3)
      beta_2_pvalue <- round(coeff_pvalues["X", 4], 3)
      beta_3_pvalue <- round(coeff_pvalues["XT", 4], 3)
      beta_6_pvalue <- round(coeff_pvalues["ZX", 4], 3)
      beta_7_pvalue <- round(coeff_pvalues["ZXT", 4], 3)
      
      lm_train_success_flag <- TRUE
      
      # Test for autocorrelation
      residuals <- citsa_model$residuals
      N <- length(residuals)
      
      # Run Ljung and Box Test
      lb_test <- wpa::LjungBox(
        citsa_model,
        lags = seq(1, ac_lags_max),
        order = 8,  # Increased order for comparative model
        season = 1,
        squared.residuals = FALSE
      )
      
      ind_stat_significant_coeff <- which(lb_test[, 'p-value'] <= 0.05)
      
      # If autocorrelation detected, use Newey-West with appropriate lag
      if (length(ind_stat_significant_coeff) > 0) {
        coeff_pvalues <- lmtest::coeftest(
          citsa_model,
          vcov = sandwich::NeweyWest(
            citsa_model,
            lag = max(ind_stat_significant_coeff),
            prewhite = FALSE
          )
        )
        
        AR_flag <- TRUE
        
        # Update coefficients with corrected standard errors
        beta_2_pvalue <- round(coeff_pvalues["X", 4], 3)
        beta_3_pvalue <- round(coeff_pvalues["XT", 4], 3)
        beta_6_pvalue <- round(coeff_pvalues["ZX", 4], 3)
        beta_7_pvalue <- round(coeff_pvalues["ZXT", 4], 3)
      }
      
      buf <- dplyr::tibble(
        metric_name = metric_name,
        beta_2 = beta_2,
        beta_3 = beta_3,
        beta_6 = beta_6,
        beta_7 = beta_7,
        beta_2_pvalue = beta_2_pvalue,
        beta_3_pvalue = beta_3_pvalue,
        beta_6_pvalue = beta_6_pvalue,
        beta_7_pvalue = beta_7_pvalue,
        AR_flag = AR_flag,
        n_treatment = n_treatment,
        n_control = n_control,
        error_warning = ""
      )
      
      # Store data_OLS and citsa_model for plotting
      list(result = buf, data_OLS = data_OLS, model = citsa_model)
      
    },
    error = function(c) {
      error_flag <<- TRUE
      buf <- dplyr::tibble(
        metric_name = metric_name,
        beta_2 = ifelse(exists("beta_2", inherits = FALSE), beta_2, NA),
        beta_3 = ifelse(exists("beta_3", inherits = FALSE), beta_3, NA),
        beta_6 = NA,
        beta_7 = NA,
        beta_2_pvalue = ifelse(exists("beta_2_pvalue", inherits = FALSE), beta_2_pvalue, NA),
        beta_3_pvalue = ifelse(exists("beta_3_pvalue", inherits = FALSE), beta_3_pvalue, NA),
        beta_6_pvalue = NA,
        beta_7_pvalue = NA,
        AR_flag = FALSE,
        n_treatment = ifelse(exists("n_treatment", inherits = FALSE), n_treatment, NA),
        n_control = ifelse(exists("n_control", inherits = FALSE), n_control, NA),
        error_warning = paste0('Error: ', c$message, "; lm_train_success=", lm_train_success_flag)
      )
      list(result = buf, data_OLS = NULL, model = NULL)
    },
    warning = function(c) {
      buf <- dplyr::tibble(
        metric_name = metric_name,
        beta_2 = ifelse(exists("beta_2", inherits = FALSE), beta_2, NA),
        beta_3 = ifelse(exists("beta_3", inherits = FALSE), beta_3, NA),
        beta_6 = ifelse(exists("beta_6", inherits = FALSE), beta_6, NA),
        beta_7 = ifelse(exists("beta_7", inherits = FALSE), beta_7, NA),
        beta_2_pvalue = ifelse(exists("beta_2_pvalue", inherits = FALSE), beta_2_pvalue, NA),
        beta_3_pvalue = ifelse(exists("beta_3_pvalue", inherits = FALSE), beta_3_pvalue, NA),
        beta_6_pvalue = ifelse(exists("beta_6_pvalue", inherits = FALSE), beta_6_pvalue, NA),
        beta_7_pvalue = ifelse(exists("beta_7_pvalue", inherits = FALSE), beta_7_pvalue, NA),
        AR_flag = AR_flag,
        n_treatment = ifelse(exists("n_treatment", inherits = FALSE), n_treatment, NA),
        n_control = ifelse(exists("n_control", inherits = FALSE), n_control, NA),
        error_warning = paste0('Warning: ', c$message, "; lm_train_success=", lm_train_success_flag)
      )
      list(result = buf, data_OLS = data_OLS, model = citsa_model)
    }
    )
    
    results <- rbind(results, buf_trycatch$result)
    
    # Create plots if requested and no error occurred
    if (grepl("plot", return) && !error_flag && !is.null(buf_trycatch$data_OLS)) {
      
      data_OLS <- buf_trycatch$data_OLS
      citsa_model <- buf_trycatch$model
      
      # Separate data for treatment and control groups
      data_treatment <- data_OLS %>% filter(Z == 0)
      data_control <- data_OLS %>% filter(Z == 1)
      
      # Get fitted values for both groups
      data_OLS$Y_fitted <- fitted(citsa_model)
      
      # Identify intervention time point for each group
      event_T_treatment <- which.max(data_treatment$X == 1)
      event_T_control <- which.max(data_control$X == 1)
      
      # Create counterfactual (what would have happened without intervention)
      # For treatment group
      before_intervention_treatment <- data_treatment[1:event_T_treatment,]
      before_intervention_treatment[event_T_treatment, "X"] <- 0
      before_intervention_treatment[event_T_treatment, "XT"] <- 0
      before_intervention_treatment[event_T_treatment, "ZX"] <- 0
      before_intervention_treatment[event_T_treatment, "ZXT"] <- 0
      
      counterfactual_treatment <- data.frame(
        MetricDate = data_treatment[1:event_T_treatment, "MetricDate"],
        T_plot = 1:event_T_treatment,
        Y = stats::predict(citsa_model, before_intervention_treatment),
        Group = "Treatment"
      )
      
      # For control group
      before_intervention_control <- data_control[1:event_T_control,]
      before_intervention_control[event_T_control, "X"] <- 0
      before_intervention_control[event_T_control, "XT"] <- 0
      before_intervention_control[event_T_control, "ZX"] <- 0
      before_intervention_control[event_T_control, "ZXT"] <- 0
      
      counterfactual_control <- data.frame(
        MetricDate = data_control[1:event_T_control, "MetricDate"],
        T_plot = 1:event_T_control,
        Y = stats::predict(citsa_model, before_intervention_control),
        Group = "Control"
      )
      
      # Fitted values after intervention
      fitted_after_treatment <- data.frame(
        MetricDate = data_treatment[event_T_treatment:nrow(data_treatment), "MetricDate"],
        T_plot = event_T_treatment:nrow(data_treatment),
        Y = data_treatment[event_T_treatment:nrow(data_treatment), "Y_fitted"],
        Group = "Treatment"
      )
      
      fitted_after_control <- data.frame(
        MetricDate = data_control[event_T_control:nrow(data_control), "MetricDate"],
        T_plot = event_T_control:nrow(data_control),
        Y = data_control[event_T_control:nrow(data_control), "Y_fitted"],
        Group = "Control"
      )
      
      # Prepare data for plotting
      plot_data <- data_OLS %>%
        mutate(
          Group = ifelse(Z == 0, "Treatment", "Control"),
          T_plot = ifelse(Z == 0, 
                          row_number()[Z == 0],
                          row_number()[Z == 1])
        )
      
      if (return == "plot") {
        # Separate panels for treatment and control
        p <- ggplot() +
          geom_point(data = plot_data, aes(x = MetricDate, y = Y, color = Group), size = 2) +
          geom_line(data = counterfactual_treatment, aes(x = MetricDate, y = Y), 
                    color = "#0078D4", size = 1, linetype = "solid") +
          geom_line(data = fitted_after_treatment, aes(x = MetricDate, y = Y), 
                    color = "#0078D4", size = 1, linetype = "solid") +
          geom_line(data = counterfactual_control, aes(x = MetricDate, y = Y), 
                    color = "#D83B01", size = 1, linetype = "solid") +
          geom_line(data = fitted_after_control, aes(x = MetricDate, y = Y), 
                    color = "#D83B01", size = 1, linetype = "solid") +
          geom_vline(xintercept = as.numeric(data_treatment$MetricDate[event_T_treatment]),
                     linetype = "dashed", color = "red", size = 1) +
          facet_wrap(~ Group, ncol = 1, scales = "free_y") +
          scale_color_manual(values = c("Treatment" = "#0078D4", "Control" = "#D83B01")) +
          labs(
            title = paste("Controlled ITSA:", metric_name),
            subtitle = paste0("β6 (differential immediate effect) = ", beta_6, " (p=", beta_6_pvalue, ")\n",
                             "β7 (differential slope change) = ", beta_7, " (p=", beta_7_pvalue, ")"),
            x = "Date",
            y = metric_name,
            color = "Group"
          ) +
          theme_wpa_basic() +
          theme(legend.position = "bottom")
        
      } else if (return == "plot_combined") {
        # Combined overlay plot
        p <- ggplot() +
          geom_point(data = plot_data, aes(x = MetricDate, y = Y, color = Group), size = 2, alpha = 0.6) +
          geom_line(data = counterfactual_treatment, aes(x = MetricDate, y = Y, color = "Treatment"), 
                    size = 1, linetype = "solid") +
          geom_line(data = fitted_after_treatment, aes(x = MetricDate, y = Y, color = "Treatment"), 
                    size = 1, linetype = "solid") +
          geom_line(data = counterfactual_control, aes(x = MetricDate, y = Y, color = "Control"), 
                    size = 1, linetype = "solid") +
          geom_line(data = fitted_after_control, aes(x = MetricDate, y = Y, color = "Control"), 
                    size = 1, linetype = "solid") +
          geom_vline(xintercept = as.numeric(data_treatment$MetricDate[event_T_treatment]),
                     linetype = "dashed", color = "red", size = 1) +
          scale_color_manual(values = c("Treatment" = "#0078D4", "Control" = "#D83B01")) +
          labs(
            title = paste("Controlled ITSA (Combined):", metric_name),
            subtitle = paste0("β6 (differential immediate effect) = ", beta_6, " (p=", beta_6_pvalue, ")\n",
                             "β7 (differential slope change) = ", beta_7, " (p=", beta_7_pvalue, ")"),
            x = "Date",
            y = metric_name,
            color = "Group"
          ) +
          theme_wpa_basic() +
          theme(legend.position = "bottom")
        
      } else if (return == "plot_difference") {
        # Difference plot showing treatment effect
        # Calculate differences between treatment and control at each time point
        treatment_values <- data_treatment %>% 
          arrange(MetricDate) %>% 
          select(MetricDate, Y, Y_fitted)
        
        control_values <- data_control %>% 
          arrange(MetricDate) %>% 
          select(MetricDate, Y, Y_fitted) %>%
          rename(Y_control = Y, Y_fitted_control = Y_fitted)
        
        difference_data <- treatment_values %>%
          left_join(control_values, by = "MetricDate") %>%
          mutate(
            Difference_observed = Y - Y_control,
            Difference_fitted = Y_fitted - Y_fitted_control,
            Period = ifelse(MetricDate <= before_end, "Pre-intervention", "Post-intervention")
          )
        
        p <- ggplot(difference_data, aes(x = MetricDate)) +
          geom_point(aes(y = Difference_observed, color = Period), size = 2) +
          geom_line(aes(y = Difference_fitted), color = "#107C10", size = 1.2) +
          geom_hline(yintercept = 0, linetype = "dashed", color = "gray50") +
          geom_vline(xintercept = as.numeric(as.Date(before_end)),
                     linetype = "dashed", color = "red", size = 1) +
          scale_color_manual(values = c("Pre-intervention" = "#605E5C", "Post-intervention" = "#0078D4")) +
          labs(
            title = paste("Treatment Effect (Difference):", metric_name),
            subtitle = paste0("Difference = Treatment - Control\n",
                             "β6 (differential immediate effect) = ", beta_6, " (p=", beta_6_pvalue, ")\n",
                             "β7 (differential slope change) = ", beta_7, " (p=", beta_7_pvalue, ")"),
            x = "Date",
            y = "Difference (Treatment - Control)",
            color = "Period"
          ) +
          theme_wpa_basic() +
          theme(legend.position = "bottom")
      }
      
      results_plot[[metric_name]] <- p
      
    } else if (grepl("plot", return) && error_flag) {
      results_plot[[metric_name]] <- buf_trycatch$result
    }
  }
  
  if (grepl("plot", return)) {
    return(results_plot)
  }
  
  # Return table
  return(results)
}
