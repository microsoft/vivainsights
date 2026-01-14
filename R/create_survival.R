# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See LICENSE.txt in the project root for license information.
# --------------------------------------------------------------------------------------------

#' @title Kaplan–Meier Survival Curve
#'
#' @description
#' Computes Kaplan–Meier survival curves and returns a step-function survival plot by default,
#' with an option to return the underlying long-format survival table.
#'
#' Supports:
#' - Flexible grouping via `group_col`
#' - Optional usage segmentation via `identify_usage_segments()` when `group_col = NULL`
#'   and `usage_metrics` are supplied
#' - Privacy filtering via `mingroup`
#'
#' @template spq-params
#' @param time_col Character string containing the name of the time-to-event column.
#' @param event_col Character string containing the name of the event indicator column.
#'   Accepted forms:
#'   - Logical (TRUE/FALSE)
#'   - Numeric 0/1
#'   - Numeric event-like (>=0): values >0 treated as event, 0 as censored
#'   - Character tokens ("true"/"false", "yes"/"no", "1"/"0")
#' @param group_col Character string containing the name of the grouping column.
#'   Supply `NULL` (without quotes) to compute an overall curve. If `group_col = NULL`
#'   and `usage_metrics` are supplied, grouping is inferred from `identify_usage_segments()`.
#' @param usage_metrics Character vector of metric column name(s) to be used in
#'   `identify_usage_segments()` when `group_col = NULL`.
#' @param usage_version String passed to `identify_usage_segments(version = ...)`, e.g. `"12w"` or `"4w"`.
#' @param id_col Character string containing the name of the person identifier column used for
#'   distinct counts in privacy filtering (`mingroup`). Defaults to `"PersonId"`.
#' @param mingroup Numeric value setting the privacy threshold / minimum group size. Defaults to 5.
#' @param dropna A logical value indicating whether `NA` should be stripped before computation proceeds.
#'   Defaults to `TRUE`.
#' @param return String specifying what to return. This must be one of:
#'   - `"plot"` (default)
#'   - `"table"`
#'
#' @return
#' A different output is returned depending on the value passed to the `return` argument:
#'   - `"plot"`: 'ggplot' object. A Kaplan–Meier survival curve by group.
#'   - `"table"`: data frame. A long-format survival table by group.
#'
#' @import dplyr
#' @import ggplot2
#' @importFrom rlang .data
#'
#' @family Visualization
#' @family Flexible
#'
#' @examples
#' # \dontrun{
#' # library(vivainsights)
#' # data("pq_data", package = "vivainsights")
#' #
#' # # Overall curve (no grouping)
#' # create_survival(pq_data,
#' #   time_col  = "Active_connected_hours",
#' #   event_col = "Days_of_active_Copilot_chat__work__usage",
#' #   group_col = NULL,
#' #   mingroup = 1
#' # )
#' #
#' # # Grouping by an existing column
#' # create_survival(pq_data,
#' #   time_col  = "Active_connected_hours",
#' #   event_col = "Days_of_active_Copilot_chat__work__usage",
#' #   group_col = "Organization",
#' #   mingroup = 1
#' # )
#' #
#' # # Derive usage segments (grouping inferred from identify_usage_segments)
#' # create_survival(pq_data,
#' #   time_col  = "Active_connected_hours",
#' #   event_col = "Days_of_active_Copilot_chat__work__usage",
#' #   group_col = NULL,
#' #   usage_metrics = c("Copilot_actions_taken_in_Teams", "Copilot_actions_taken_in_Outlook"),
#' #   usage_version = "12w",
#' #   mingroup = 1
#' # )
#' # }
#' @export
create_survival <- function(data,
                            time_col,
                            event_col,
                            group_col = NULL,
                            usage_metrics = NULL,
                            usage_version = "12w",
                            id_col = "PersonId",
                            mingroup = 5,
                            dropna = TRUE,
                            return = "plot"){
  
  ## Check inputs
  required_variables <- c(time_col, event_col)
  
  if(!is.null(group_col)){
    required_variables <- c(required_variables, group_col)
  }
  
  # Only required if we are deriving segments
  if(is.null(group_col) && !is.null(usage_metrics)){
    required_variables <- c(required_variables, usage_metrics, "PersonId", "MetricDate")
  }
  
  required_variables <- unique(required_variables)
  
  data %>%
    .check_inputs_safe(requirements = required_variables)
  
  if(!is.numeric(mingroup) || length(mingroup) != 1 || mingroup < 1){
    stop("Please enter a valid input for `mingroup` (single numeric >= 1).")
  }
  
  if(!is.logical(dropna) || length(dropna) != 1){
    stop("Please enter a valid input for `dropna` (TRUE/FALSE).")
  }
  
  if(is.null(return) || !is.character(return) || length(return) != 1){
    stop("Please enter a valid input for `return`.")
  }
  
  df <- data
  group_col_for_calc <- group_col
  
  ## Optional: derive usage segments when no grouping column supplied
  if(is.null(group_col_for_calc) && !is.null(usage_metrics)){
    
    seg_out <- .auto_segment_using_identify_usage(
      data = df,
      usage_metrics = usage_metrics,
      usage_version = usage_version
    )
    
    df <- seg_out$data
    group_col_for_calc <- seg_out$segment_col
    
  } else if(!is.null(group_col_for_calc)){
    
    if(!is.character(group_col_for_calc) || length(group_col_for_calc) != 1){
      stop("Please enter a valid input for `group_col` (single character or NULL).")
    }
    
    if(!group_col_for_calc %in% names(df)){
      stop("`group_col` not found in data: ", group_col_for_calc)
    }
  }
  
  out <-
    create_survival_calc(
      data = df,
      time_col = time_col,
      event_col = event_col,
      group_col = group_col_for_calc,
      id_col = id_col,
      mingroup = mingroup,
      dropna = dropna
    )
  
  if(return == "table"){
    
    return(out$table)
    
  } else if(return == "plot"){
    
    ## Titles
    if(is.null(group_col_for_calc)){
      ttl <- "Survival Curve"
      sub <- "Kaplan–Meier estimate"
      gcol <- "group"
    } else {
      ttl <- "Survival Curve by Group"
      sub <- paste("Kaplan–Meier estimate by", group_col_for_calc)
      gcol <- group_col_for_calc
    }
    
    return(
      create_survival_viz(
        data = out$table,
        group_col = gcol,
        title = ttl,
        subtitle = sub
      )
    )
    
  } else {
    
    stop("Please enter a valid input for `return`.")
    
  }
}


#' @title Kaplan–Meier Survival Curve (Calculation)
#'
#' @description
#' Computes a long-format Kaplan–Meier survival table by group and applies a minimum group
#' size threshold (`mingroup`).
#'
#' @param data data.frame.
#' @param time_col Character. Time-to-event column name.
#' @param event_col Character. Event indicator column name.
#' @param group_col Character or NULL. Grouping column name.
#' @param id_col Character. Optional id column name for distinct counts.
#' @param mingroup Numeric. Minimum group size.
#' @param dropna Logical. Drop missing values in required columns.
#'
#' @return A list with elements:
#'   - `table`: long survival table with columns (group, time, survival, at_risk, events, n)
#'   - `counts`: group size table
#'
#' @export
create_survival_calc <- function(data,
                                 time_col,
                                 event_col,
                                 group_col = NULL,
                                 id_col = "PersonId",
                                 mingroup = 5,
                                 dropna = TRUE){
  
  ## Check inputs
  required_variables <- c(time_col, event_col)
  
  if(!is.null(group_col)){
    required_variables <- c(required_variables, group_col)
  }
  
  required_variables <- unique(required_variables)
  
  data %>%
    .check_inputs_safe(requirements = required_variables)
  
  df <- data
  
  ## Handle overall curve
  if(is.null(group_col)){
    df$group <- "Overall"
    group_col <- "group"
  }
  
  ## Drop NA in required fields
  if(isTRUE(dropna)){
    
    df <-
      df %>%
      dplyr::filter(!is.na(.data[[group_col]])) %>%
      dplyr::filter(!is.na(.data[[time_col]]), !is.na(.data[[event_col]]))
    
  } else {
    
    df <-
      df %>%
      dplyr::filter(!is.na(.data[[group_col]]))
    
  }
  
  ## Ensure join key is stable
  df[[group_col]] <- as.character(df[[group_col]])
  
  df <-
    df %>%
    dplyr::mutate(
      .time = suppressWarnings(as.numeric(.data[[time_col]])),
      .event = .coerce_event(.data[[event_col]])
    ) %>%
    dplyr::filter(!is.na(.data$.time), !is.na(.data$.event))
  
  ## Group counts for mingroup (unique ids if possible, else row counts)
  if(!is.null(id_col) && is.character(id_col) && id_col %in% names(df)){
    
    counts <-
      df %>%
      dplyr::group_by(.data[[group_col]]) %>%
      dplyr::summarise(n = dplyr::n_distinct(.data[[id_col]], na.rm = TRUE), .groups = "drop")
    
  } else {
    
    counts <-
      df %>%
      dplyr::group_by(.data[[group_col]]) %>%
      dplyr::summarise(n = dplyr::n(), .groups = "drop")
    
  }
  
  counts[[group_col]] <- as.character(counts[[group_col]])
  
  keep_groups <-
    counts %>%
    dplyr::filter(.data$n >= mingroup) %>%
    dplyr::pull(.data[[group_col]])
  
  df <-
    df %>%
    dplyr::filter(.data[[group_col]] %in% keep_groups)
  
  counts <-
    counts %>%
    dplyr::filter(.data[[group_col]] %in% keep_groups)
  
  if(nrow(df) == 0){
    
    empty_tbl <- data.frame(
      group = character(0),
      time = numeric(0),
      survival = numeric(0),
      at_risk = integer(0),
      events = integer(0),
      n = integer(0),
      check.names = FALSE
    )
    
    names(empty_tbl)[1] <- group_col
    
    return(list(table = empty_tbl, counts = counts))
  }
  
  split_list <- split(df, df[[group_col]], drop = TRUE)
  
  km_list <- lapply(names(split_list), function(g){
    
    x <- split_list[[g]]
    
    km <- .km_curve(durations = x$.time, events = x$.event)
    km[[group_col]] <- as.character(g)
    
    km
  })
  
  surv_tbl <-
    dplyr::bind_rows(km_list) %>%
    dplyr::select(dplyr::all_of(c(group_col, "time", "survival", "at_risk", "events"))) %>%
    dplyr::left_join(counts, by = group_col) %>%
    dplyr::relocate(.data$n, .after = dplyr::all_of(group_col))
  
  list(table = surv_tbl, counts = counts)
}


#' @title Kaplan–Meier Survival Curve (Visualization)
#'
#' @description
#' Renders a Kaplan–Meier step curve by group from a long-format survival table.
#'
#' @param data Long survival table produced by `create_survival_calc()`.
#' @param group_col Character. Group column name in `data`.
#' @param title,subtitle Character. Plot annotations.
#'
#' @return ggplot object.
#'
#' @export
create_survival_viz <- function(data,
                                group_col = "group",
                                title = "Survival Curve",
                                subtitle = "Kaplan–Meier estimate"){
  
  ggplot2::ggplot(
    data,
    ggplot2::aes(
      x = .data$time,
      y = .data$survival,
      colour = .data[[group_col]],
      group = .data[[group_col]]
    )
  ) +
    ggplot2::geom_step(linewidth = 0.8, na.rm = TRUE) +
    ggplot2::scale_y_continuous(limits = c(0, 1)) +
    ggplot2::labs(
      x = "Time",
      y = "Survival probability",
      colour = NULL,
      title = title,
      subtitle = subtitle
    ) +
    .theme_wpa_safe()
}

# =========================
# Internal helpers
# =========================

.check_inputs_safe <- function(data, requirements){
  
  if(exists("check_inputs", mode = "function")){
    data %>% check_inputs(requirements = requirements)
    return(invisible(TRUE))
  }
  
  missing <- setdiff(requirements, names(data))
  if(length(missing) > 0){
    stop("Missing required column(s): ", paste(missing, collapse = ", "))
  }
  
  invisible(TRUE)
}

.coerce_event <- function(x){
  
  if(is.logical(x)) return(as.integer(x))
  
  if(is.numeric(x)){
    
    ok01 <- x %in% c(0, 1) | is.na(x)
    if(all(ok01)) return(as.integer(x))
    
    if(all(x >= 0 | is.na(x))) return(as.integer(x > 0))
    
    return(rep(NA_integer_, length(x)))
  }
  
  if(is.character(x)){
    xl <- tolower(x)
    return(ifelse(xl %in% c("1", "true", "t", "yes", "y"), 1L,
                  ifelse(xl %in% c("0", "false", "f", "no", "n"), 0L, NA_integer_)))
  }
  
  rep(NA_integer_, length(x))
}

.km_curve <- function(durations, events){
  
  d <- as.numeric(durations)
  e <- as.integer(events)
  
  ok <- !is.na(d) & !is.na(e)
  d <- d[ok]
  e <- e[ok]
  
  if(length(d) == 0){
    return(data.frame(
      time = numeric(0),
      at_risk = integer(0),
      events = integer(0),
      survival = numeric(0),
      check.names = FALSE
    ))
  }
  
  timeline <- sort(unique(d))
  
  S <- 1.0
  surv <- numeric(length(timeline))
  at_risk_seq <- integer(length(timeline))
  events_seq <- integer(length(timeline))
  
  for(i in seq_along(timeline)){
    
    t <- timeline[i]
    at_risk <- sum(d >= t)
    d_t <- sum(d == t & e == 1L)
    
    at_risk_seq[i] <- at_risk
    events_seq[i] <- d_t
    
    if(at_risk > 0) S <- S * (1 - d_t / at_risk)
    surv[i] <- S
  }
  
  data.frame(
    time = timeline,
    at_risk = at_risk_seq,
    events = events_seq,
    survival = surv,
    check.names = FALSE
  )
}

.theme_wpa_safe <- function(){
  
  if(exists("theme_wpa", mode = "function")) return(theme_wpa())
  
  if("vivainsights" %in% loadedNamespaces() &&
     exists("theme_wpa", envir = asNamespace("vivainsights"), mode = "function")){
    return(get("theme_wpa", envir = asNamespace("vivainsights"))())
  }
  
  ggplot2::theme_minimal()
}

.auto_segment_using_identify_usage <- function(data,
                                               usage_metrics,
                                               usage_version = "12w"){
  
  if(!is.character(usage_metrics) || length(usage_metrics) < 1){
    stop("`usage_metrics` must be a non-empty character vector.")
  }
  
  miss <- setdiff(usage_metrics, names(data))
  if(length(miss) > 0){
    stop("Some `usage_metrics` columns are missing: ", paste(miss, collapse = ", "))
  }
  
  ## Locate identify_usage_segments() (package namespace preferred)
  ident_fun <- NULL
  if("vivainsights" %in% loadedNamespaces() &&
     exists("identify_usage_segments", envir = asNamespace("vivainsights"), mode = "function")){
    ident_fun <- get("identify_usage_segments", envir = asNamespace("vivainsights"))
  } else if(exists("identify_usage_segments", mode = "function")){
    ident_fun <- identify_usage_segments
  } else {
    stop("`identify_usage_segments()` not found. Load `vivainsights` first.")
  }
  
  original_cols <- names(data)
  
  if(length(usage_metrics) == 1){
    
    seg_data <- ident_fun(
      data = data,
      metric = usage_metrics[[1]],
      metric_str = NULL,
      version = usage_version,
      return = "data"
    )
    
  } else {
    
    seg_data <- ident_fun(
      data = data,
      metric = NULL,
      metric_str = usage_metrics,
      version = usage_version,
      return = "data"
    )
  }
  
  new_cols <- setdiff(names(seg_data), original_cols)
  
  candidates <- Filter(function(cn){
    
    x <- seg_data[[cn]]
    
    (is.factor(x) || is.character(x)) &&
      dplyr::n_distinct(x, na.rm = TRUE) > 1 &&
      dplyr::n_distinct(x, na.rm = TRUE) <= 10
    
  }, new_cols)
  
  if(length(candidates) == 0){
    stop("No suitable segment column detected after running `identify_usage_segments()`.")
  }
  
  ## Prefer a version-matching column if uniquely available
  if(!is.null(usage_version) && is.character(usage_version) && length(usage_version) == 1){
    vmatch <- candidates[grepl(usage_version, candidates, fixed = TRUE)]
    if(length(vmatch) == 1){
      return(list(data = seg_data, segment_col = vmatch[[1]]))
    }
  }
  
  ## Otherwise choose smallest cardinality
  nunique <- vapply(candidates, function(cn){
    dplyr::n_distinct(seg_data[[cn]], na.rm = TRUE)
  }, numeric(1))
  
  segment_col <- candidates[[which.min(nunique)]]
  
  list(data = seg_data, segment_col = segment_col)
}
