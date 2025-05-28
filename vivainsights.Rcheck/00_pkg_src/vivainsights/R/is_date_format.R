# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See LICENSE.txt in the project root for license information.
# --------------------------------------------------------------------------------------------

#' @title Identify whether string is a date format
#'
#' @description
#' This function uses regular expression to determine whether a string is of the
#' format `"mdy"`, separated by `"-"`, `"/"`, or `"."`, returning a logical
#' vector.
#'
#' @param string Character string to test whether is a date format.
#'
#' @return logical value indicating whether the string is a date format.
#'
#' @examples
#' is_date_format("1/5/2020")
#'
#' @family Support
#'
#' @export
is_date_format <- function(string){

  grepl("^\\d{1,2}[- /.]\\d{1,2}[- /.]\\d{1,4}$", string)
}

#' @title Identify whether variable is an IDate class.
#'
#' @description
#' This function checks whether the variable is an IDate class.
#'
#' @param x Variable to test whether an IDate class.
#'
#' @return logical value indicating whether the string is of an IDate class.
#'
#' @examples
#' any_idate("2023-12-15")
#'
#' @family Support
#'
#' @export

any_idate <- function(x){
  any(class(x) %in% "IDate")
}
