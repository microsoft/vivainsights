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
#' - Flexible grouping via `hrvar`
#' - Optional usage segmentation via `identify_usage_segments()` when `hrvar = NULL`
#'   and `usage_metrics` are supplied
#' - Privacy filtering via `mingroup`
#'
#' This function expects one row per person with a pre-computed time-to-event column
#' and an event indicator. Use \code{\link{create_survival_prep}} to derive these
#' from a Standard Person Query panel dataset.
#'
#' @param data A person-level data frame with one row per person, as produced by
#'   \code{\link{create_survival_prep}}.
#' @param time_col Character string containing the name of the time-to-event column.
#' @param event_col Character string containing the name of the event indicator column.
#'   Accepted forms:
#'   - Logical (TRUE/FALSE)
#'   - Numeric 0/1
#'   - Numeric event-like (>=0): values >0 treated as event, 0 as censored
#'   - Character tokens ("true"/"false", "yes"/"no", "1"/"0")
#' @param hrvar Character string containing the name of the grouping column.
#'   Supply `NULL` (without quotes) to compute an overall curve. If `hrvar = NULL`
#'   and `usage_metrics` are supplied, grouping is inferred from `identify_usage_segments()`.
#' @param usage_metrics Character vector of metric column name(s) to be used in
#'   `identify_usage_segments()` when `hrvar = NULL`.
#' @param usage_version String passed to `identify_usage_segments(version = ...)`, e.g. `"12w"` or `"4w"`.
#' @param mingroup Numeric value setting the privacy threshold / minimum group size. Defaults to 5.
#' @param na.rm A logical value indicating whether `NA` should be stripped before computation proceeds.
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
#' \dontrun{
#' library(vivainsights)
#' data("pq_data", package = "vivainsights")
#'
#' # Step 1: convert panel data to person-level survival format
#' surv_data <- create_survival_prep(
#'   data = pq_data,
#'   metric = "Copilot_actions_taken_in_Teams"
#' )
#'
#' # Step 2: plot Kaplan-Meier curves by organisation
#' create_survival(
#'   data = surv_data,
#'   time_col = "time",
#'   event_col = "event",
#'   hrvar = "Organization"
#' )
#'
#' # Return the survival table instead
#' create_survival(
#'   data = surv_data,
#'   time_col = "time",
#'   event_col = "event",
#'   hrvar = "Organization",
#'   return = "table"
#' )
#' }
#' @export
create_survival <- function(data,
                            time_col,
                            event_col,
                            hrvar = NULL,
                            usage_metrics = NULL,
                            usage_version = "12w",
                            mingroup = 5,
                            na.rm = TRUE,
                            return = "plot"){

  ## Check inputs
  required_variables <- c(time_col, event_col)

  if(!is.null(hrvar)){
    required_variables <- c(required_variables, hrvar)
  }

  # Only required if we are deriving segments
  if(is.null(hrvar) && !is.null(usage_metrics)){
    required_variables <- c(required_variables, usage_metrics, "PersonId", "MetricDate")
  }

  required_variables <- unique(required_variables)

  data %>%
    .check_inputs_safe(requirements = required_variables)

  if(!is.numeric(mingroup) || length(mingroup) != 1 || mingroup < 1){
    stop("Please enter a valid input for `mingroup` (single numeric >= 1).")
  }

  if(!is.logical(na.rm) || length(na.rm) != 1){
    stop("Please enter a valid input for `na.rm` (TRUE/FALSE).")
  }

  if(is.null(return) || !is.character(return) || length(return) != 1){
    stop("Please enter a valid input for `return`.")
  }

  df <- data
  hrvar_for_calc <- hrvar

  ## Optional: derive usage segments when no grouping column supplied
  if(is.null(hrvar_for_calc) && !is.null(usage_metrics)){

    seg_out <- .auto_segment_using_identify_usage(
      data = df,
      metrics = usage_metrics,
      usage_version = usage_version
    )

    df <- seg_out$data
    hrvar_for_calc <- seg_out$segment_col

  } else if(!is.null(hrvar_for_calc)){

    if(!is.character(hrvar_for_calc) || length(hrvar_for_calc) != 1){
      stop("Please enter a valid input for `hrvar` (single character or NULL).")
    }

    if(!hrvar_for_calc %in% names(df)){
      stop("`hrvar` not found in data: ", hrvar_for_calc)
    }
  }

  out <-
    create_survival_calc(
      data = df,
      time_col = time_col,
      event_col = event_col,
      hrvar = hrvar_for_calc,
      mingroup = mingroup,
      na.rm = na.rm
    )

  if(return == "table"){

    return(out$table)

  } else if(return == "plot"){

    ## Titles
    if(is.null(hrvar_for_calc)){
      ttl <- "Survival Curve"
      sub <- "Kaplan\u2013Meier estimate"
      gcol <- "group"
    } else {
      ttl <- "Survival Curve by Group"
      sub <- paste("Kaplan\u2013Meier estimate by", hrvar_for_calc)
      gcol <- hrvar_for_calc
    }

    return(
      create_survival_viz(
        data = out$table,
        hrvar = gcol,
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
#' @param hrvar Character or NULL. Grouping column name.
#' @param id_col Character. Optional id column name for distinct counts.
#' @param mingroup Numeric. Minimum group size.
#' @param na.rm Logical. Drop missing values in required columns.
#'
#' @return A list with elements:
#'   - `table`: long survival table with columns (group, time, survival, at_risk, events, n)
#'   - `counts`: group size table
#'
#' @export
create_survival_calc <- function(data,
                                 time_col,
                                 event_col,
                                 hrvar = NULL,
                                 id_col = "PersonId",
                                 mingroup = 5,
                                 na.rm = TRUE){

  ## Check inputs
  required_variables <- c(time_col, event_col)

  if(!is.null(hrvar)){
    required_variables <- c(required_variables, hrvar)
  }

  required_variables <- unique(required_variables)

  data %>%
    .check_inputs_safe(requirements = required_variables)

  df <- data

  ## Handle overall curve
  if(is.null(hrvar)){
    df$group <- "Overall"
    hrvar <- "group"
  }

  ## Drop NA in required fields
  if(isTRUE(na.rm)){

    df <-
      df %>%
      dplyr::filter(!is.na(.data[[hrvar]])) %>%
      dplyr::filter(!is.na(.data[[time_col]]), !is.na(.data[[event_col]]))

  } else {

    df <-
      df %>%
      dplyr::filter(!is.na(.data[[hrvar]]))

  }

  ## Ensure join key is stable
  df[[hrvar]] <- as.character(df[[hrvar]])

  # Track original row count for warning
  n_before <- nrow(df)

  df <-
    df %>%
    dplyr::mutate(
      .time = suppressWarnings(as.numeric(.data[[time_col]])),
      .event = .coerce_event(.data[[event_col]])
    ) %>%
    dplyr::filter(!is.na(.data$.time), !is.na(.data$.event))

  n_after <- nrow(df)
  n_dropped <- n_before - n_after

  # Warn if coercion dropped rows
  if (n_dropped > 0) {
    warning(n_dropped, " row(s) dropped due to NA values in time or event columns after coercion. ",
            "Original rows: ", n_before, ", remaining: ", n_after, ".")
  }

  ## Group counts for mingroup (unique ids if possible, else row counts)
  if(!is.null(id_col) && is.character(id_col) && id_col %in% names(df)){

    counts <-
      df %>%
      dplyr::group_by(.data[[hrvar]]) %>%
      dplyr::summarise(n = dplyr::n_distinct(.data[[id_col]], na.rm = TRUE), .groups = "drop")

  } else {

    counts <-
      df %>%
      dplyr::group_by(.data[[hrvar]]) %>%
      dplyr::summarise(n = dplyr::n(), .groups = "drop")

  }

  counts[[hrvar]] <- as.character(counts[[hrvar]])

  keep_groups <-
    counts %>%
    dplyr::filter(.data$n >= mingroup) %>%
    dplyr::pull(.data[[hrvar]])

  df <-
    df %>%
    dplyr::filter(.data[[hrvar]] %in% keep_groups)

  counts <-
    counts %>%
    dplyr::filter(.data[[hrvar]] %in% keep_groups)

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

    names(empty_tbl)[1] <- hrvar

    return(list(table = empty_tbl, counts = counts))
  }

  split_list <- split(df, df[[hrvar]], drop = TRUE)

  km_list <- lapply(names(split_list), function(g){

    x <- split_list[[g]]

    km <- .km_curve(durations = x$.time, events = x$.event)
    km[[hrvar]] <- as.character(g)

    km
  })

  surv_tbl <-
    dplyr::bind_rows(km_list) %>%
    dplyr::select(dplyr::all_of(c(hrvar, "time", "survival", "at_risk", "events"))) %>%
    dplyr::left_join(counts, by = hrvar) %>%
    dplyr::relocate(.data$n, .after = dplyr::all_of(hrvar))

  list(table = surv_tbl, counts = counts)
}


#' @title Kaplan–Meier Survival Curve (Visualization)
#'
#' @description
#' Renders a Kaplan–Meier step curve by group from a long-format survival table.
#'
#' @param data Long survival table produced by `create_survival_calc()`.
#' @param hrvar Character. Group column name in `data`.
#' @param title,subtitle Character. Plot annotations.
#'
#' @return ggplot object.
#'
#' @export
create_survival_viz <- function(data,
                                hrvar = "group",
                                title = "Survival Curve",
                                subtitle = "Kaplan\u2013Meier estimate"){

  ggplot2::ggplot(
    data,
    ggplot2::aes(
      x = .data$time,
      y = .data$survival,
      colour = .data[[hrvar]],
      group = .data[[hrvar]]
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
# Internal helpers (file-local)
# =========================

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

  # Prepend t = 0 anchor: everyone is at risk, survival = 1
  data.frame(
    time     = c(0, timeline),
    at_risk  = c(as.integer(length(d)), at_risk_seq),
    events   = c(0L, events_seq),
    survival = c(1.0, surv),
    check.names = FALSE
  )
}
