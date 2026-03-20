# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See LICENSE.txt in the project root for license information.
# --------------------------------------------------------------------------------------------

# Internal helpers shared by create_radar* and create_survival* functions.
# Not exported.

.check_inputs_safe <- function(data, requirements) {

  if (exists("check_inputs", mode = "function")) {
    data %>% check_inputs(requirements = requirements)
    return(invisible(TRUE))
  }

  missing <- setdiff(requirements, names(data))
  if (length(missing) > 0) {
    stop("Missing required column(s): ", paste(missing, collapse = ", "))
  }

  invisible(TRUE)
}

.theme_wpa_safe <- function() {

  # Use theme_wpa_basic() (no custom font) to ensure compatibility across
  # platforms and devices (including the PostScript device used by R CMD check).
  if (exists("theme_wpa_basic", mode = "function")) return(theme_wpa_basic())

  if ("vivainsights" %in% loadedNamespaces() &&
      exists("theme_wpa_basic", envir = asNamespace("vivainsights"), mode = "function")) {
    return(get("theme_wpa_basic", envir = asNamespace("vivainsights"))())
  }

  ggplot2::theme_minimal()
}

# Produce a human-readable label from an hrvar column name, consistent with
# the convention used by other create_* functions (e.g. create_bar).
.pretty_hrvar_name <- function(hrvar) {

  if (exists("camel_clean", mode = "function")) return(tolower(camel_clean(hrvar)))

  gsub("_", " ", tolower(hrvar), fixed = TRUE)
}

# Derive a segment column from identify_usage_segments().
# `metrics`: non-empty character vector of metric column names.
.auto_segment_using_identify_usage <- function(data,
                                               metrics,
                                               usage_version = "12w") {

  if (!is.character(metrics) || length(metrics) < 1) {
    stop("`metrics` must be a non-empty character vector.")
  }

  miss <- setdiff(metrics, names(data))
  if (length(miss) > 0) {
    stop("Some metric columns are missing: ", paste(miss, collapse = ", "))
  }

  # Locate identify_usage_segments() (package namespace preferred)
  ident_fun <- NULL
  if ("vivainsights" %in% loadedNamespaces() &&
      exists("identify_usage_segments", envir = asNamespace("vivainsights"), mode = "function")) {
    ident_fun <- get("identify_usage_segments", envir = asNamespace("vivainsights"))
  } else if (exists("identify_usage_segments", mode = "function")) {
    ident_fun <- identify_usage_segments
  } else {
    stop("`identify_usage_segments()` not found. Load `vivainsights` first.")
  }

  original_cols <- names(data)

  if (length(metrics) == 1) {
    seg_data <- ident_fun(
      data = data,
      metric = metrics[[1]],
      metric_str = NULL,
      version = usage_version,
      return = "data"
    )
  } else {
    seg_data <- ident_fun(
      data = data,
      metric = NULL,
      metric_str = metrics,
      version = usage_version,
      return = "data"
    )
  }

  # Infer segment column from newly-added columns
  new_cols <- setdiff(names(seg_data), original_cols)

  candidates <- Filter(function(cn) {
    x <- seg_data[[cn]]
    (is.factor(x) || is.character(x)) &&
      dplyr::n_distinct(x, na.rm = TRUE) > 1 &&
      dplyr::n_distinct(x, na.rm = TRUE) <= 10
  }, new_cols)

  if (length(candidates) == 0) {
    stop("No suitable segment column detected after running `identify_usage_segments()`.")
  }

  # Prefer a version-matching column name if uniquely available
  if (!is.null(usage_version) && is.character(usage_version) && length(usage_version) == 1) {
    vmatch <- candidates[grepl(usage_version, candidates, fixed = TRUE)]
    if (length(vmatch) == 1) {
      return(list(data = seg_data, segment_col = vmatch[[1]]))
    }
  }

  # Otherwise choose smallest cardinality
  nunique <- vapply(candidates, function(cn) {
    dplyr::n_distinct(seg_data[[cn]], na.rm = TRUE)
  }, numeric(1))

  segment_col <- candidates[[which.min(nunique)]]

  list(data = seg_data, segment_col = segment_col)
}
