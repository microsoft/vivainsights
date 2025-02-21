# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See LICENSE.txt in the project root for license information.
# --------------------------------------------------------------------------------------------

#' @title Check a query to ensure that it is suitable for analysis
#'
#' @description Prints diagnostic data about the data query to the R console,
#' with information such as date range, number of employees, HR attributes
#' identified, etc.
#'
#' @details This can be used with any person-level query, such as the standard
#' person query, Ways of Working assessment query, and the hourly collaboration
#' query. When run, this prints diagnostic data to the R console.
#'
#' @param data A person-level query in the form of a data frame. This includes:
#'   - Standard Person Query
#'   - Ways of Working Assessment Query
#'   - Hourly Collaboration Query
#'
#' All person-level query have a `PersonId` column and a `MetricDate` column.
#'
#' @param return String specifying what to return. This must be one of the
#'   following strings:
#'   - `"message"` (default)
#'   - `"text"`
#'
#' See `Value` for more information.
#'
#' @param validation Logical value to specify whether to show summarized version. Defaults to `FALSE`. To hide checks on variable
#'   names, set `validation` to `TRUE`.
#'
#' @return
#' A different output is returned depending on the value passed to the `return`
#' argument:
#'   - `"message"`: a message is returned to the console.
#'   - `"text"`: string containing the diagnostic message.
#'
#' @examples
#' check_query(pq_data)
#'
#' @family Data Validation
#' @import dplyr
#' @importFrom tidyselect all_of
#'
#' @export
check_query <- function(data, return = "message", validation = FALSE){

  if(!is.data.frame(data)){
    stop("Input is not a data frame.")
  }

  if("PersonId" %in% names(data)){

    if(validation == FALSE){

      check_person_query(data = data, return = return)

    } else if(validation == TRUE){

      # Different displays required for validation_report()
      check_query_validation(data = data, return = return)

    }
  } else {
    message("Note: checks are currently unavailable for a non-Person query")
  }
}

#' @title Check a Person Query to ensure that it is suitable for analysis
#'
#' @description
#' Prints diagnostic data about the data query to the R console, with information
#' such as date range, number of employees, HR attributes identified, etc.
#'
#' @inheritParams check_query
#'
#' @details Used as part of `check_query()`.
#'
#' @noRd
#'
check_person_query <- function(data, return){

  ## Query Type - In {wpa}, this uses `identify_query()`
  ## Set as blank for initiation
  main_chunk <- ""

  ## PersonId
  if(!("PersonId" %in% names(data))){
    stop("There is no `PersonId` variable in the input.")
  } else {
    new_chunk <- paste("There are", dplyr::n_distinct(data$PersonId), "employees in this dataset.")
    main_chunk <- paste(main_chunk, new_chunk, sep = "\n\n")
  }

  ## Date
  if(!("MetricDate" %in% names(data))){

    stop("There is no `MetricDate` variable in the input.")

  } else if("Influence_rank" %in% names(data)){

    # Omit date conversion
    new_chunk <- paste0("Date ranges from ", min(data$MetricDate), " to ", max(data$MetricDate), ".")
    main_chunk <- paste(main_chunk, new_chunk, sep = "\n\n")

  } else {

    data$MetricDate <- as.Date(data$MetricDate, "%m/%d/%Y")
    new_chunk <- paste0("Date ranges from ", min(data$MetricDate), " to ", max(data$MetricDate), ".")
    main_chunk <- paste(main_chunk, new_chunk, sep = "\n\n")

  }

 ## Extract unique identifiers of query ------------------------------------

	extracted_chr <-
	  data %>%
	  hrvar_count_all(return = "table") %>%
	  filter(`Unique values`== 1) %>%
	  pull(Attributes)

	if (length(extracted_chr)>1) {

		extractHRValues <- function(data, hrvar){
			data %>%
		    summarise(FirstValue = first(!!sym(hrvar))) %>%
		    mutate(HRAttribute = wrap(hrvar, wrapper = "`")) %>%
		    select(HRAttribute, FirstValue) %>%
		    mutate(FirstValue = as.character(FirstValue)) # Coerce type
			}

		result <-
		  extracted_chr %>%
		  purrr::map(function(x){ extractHRValues(data = data, hrvar = x)}) %>%
		  bind_rows()

     new_chunk <- paste("Unique identifiers include:",
                        result %>%
                          mutate(identifier = paste(HRAttribute, "is", FirstValue)) %>%
                          pull(identifier) %>%
                          paste(collapse = "; "))

     main_chunk <- paste(main_chunk, new_chunk, sep = "\n\n")
	 }


  ## HR Variables
  hr_chr <- extract_hr(data, max_unique = 200) %>% wrap(wrapper = "`")
  new_chunk <- paste("There are", length(hr_chr), "(estimated) HR attributes in the data:" )
  main_chunk <- paste(main_chunk, new_chunk, sep = "\n\n")
  new_chunk <- paste(hr_chr, collapse = ", ")
  main_chunk <- paste(main_chunk, new_chunk, sep = "\n")

  ## `IsActive` flag
  if(!("IsActive" %in% names(data))){
    new_chunk <- "The `IsActive` flag is not present in the data."
    main_chunk <- paste(main_chunk, new_chunk, sep = "\n")
  } else {
    data$IsActive <- as.logical(data$IsActive) # Force to logical
    active_n <- dplyr::n_distinct(data[data$IsActive == TRUE, "PersonId"])
    new_chunk <- paste0("There are ", active_n, " active employees out of all in the dataset.")
    main_chunk <- paste(main_chunk, new_chunk, sep = "\n\n")
  }

  ## Return
  if(return == "message"){

    main_chunk <- paste("", main_chunk, sep = "\n")
    message(main_chunk)

  } else if(return == "text"){
    main_chunk
  } else {
    stop("Please check inputs for `return`")
  }
}

#' @title Perform a query check for the validation report
#'
#' @description
#' Prints diagnostic data about the data query to the R console, with information
#' such as date range, number of employees, HR attributes identified, etc.
#' Optimised for the `validation_report()`
#'
#' @inheritParams check_query
#'
#' @details Used as part of `check_query()`.
#'
#' @noRd
check_query_validation <- function(data, return){
  ## Query Type - Initialise
  main_chunk <- ""

  ## PersonId
  if(!("PersonId" %in% names(data))){
    stop("There is no `PersonId` variable in the input.")
  } else {
    new_chunk <- paste("There are", dplyr::n_distinct(data$PersonId), "employees in this dataset.")
    main_chunk <- paste(main_chunk, new_chunk, sep = "\n\n")
  }

  ## Date
  if(!("MetricDate" %in% names(data))){
    stop("There is no `MetricDate` variable in the input.")
  } else {
    data$MetricDate <- as.Date(data$MetricDate, "%m/%d/%Y")
    new_chunk <- paste0("Date ranges from ", min(data$MetricDate), " to ", max(data$MetricDate), ".")
    main_chunk <- paste(main_chunk, new_chunk, sep = "\n\n")
  }

 ## Extract unique identifiers of query ------------------------------------

	extracted_chr <-  data %>%
	  hrvar_count_all(return = "table") %>%
	  filter(`Unique values`==1) %>%
	  pull(Attributes)

	if (length(extracted_chr) > 1) {


	  extractHRValues <- function(data, hrvar){
	    data %>%
	      summarise(FirstValue = first(!!sym(hrvar))) %>%
	      mutate(HRAttribute = wrap(hrvar, wrapper = "`")) %>%
	      select(HRAttribute, FirstValue) %>%
	      mutate(FirstValue = as.character(FirstValue)) # Coerce type
	  }

	  result <-
	    extracted_chr %>%
	    purrr::map(function(x){ extractHRValues(data = data, hrvar = x)}) %>%
	    bind_rows()

	  new_chunk <- paste("Unique identifiers include:",
	                     result %>%
	                       mutate(identifier = paste(HRAttribute, "is", FirstValue)) %>%
	                       pull(identifier) %>%
	                       paste(collapse = "; "))

	  main_chunk <- paste(main_chunk, new_chunk, sep = "\n\n")

	 }


  ## HR Variables
  hr_chr <- extract_hr(data, max_unique = 200) %>% wrap(wrapper = "`")
  new_chunk <- paste("There are", length(hr_chr), "(estimated) HR attributes in the data:" )
  main_chunk <- paste(main_chunk, new_chunk, sep = "\n\n")
  new_chunk <- paste(hr_chr, collapse = ", ")
  main_chunk <- paste(main_chunk, new_chunk, sep = "\n")

  ## `IsActive` flag
  if(!("IsActive" %in% names(data))){
    new_chunk <- "The `IsActive` flag is not present in the data."
    main_chunk <- paste(main_chunk, new_chunk, sep = "\n")
  } else {
    data$IsActive <- as.logical(data$IsActive) # Force to logical
    active_n <- dplyr::n_distinct(data[data$IsActive == TRUE, "PersonId"])
    new_chunk <- paste0("There are ", active_n, " active employees out of all in the dataset.")
    main_chunk <- paste(main_chunk, new_chunk, sep = "\n\n")
  }

  ## Return
  if(return == "message"){

    main_chunk <- paste("", main_chunk, sep = "\n")
    message(main_chunk)

  } else if(return == "text"){
    main_chunk
  } else {
    stop("Please check inputs for `return`")
  }
}
