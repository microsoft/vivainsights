# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See LICENSE.txt in the project root for license information.
# --------------------------------------------------------------------------------------------

#' @title Sample Group-to-Group dataset
#'
#' @description
#' A demo dataset representing a Group-to-Group Query. The grouping
#' organizational attribute used here is `Organization`, where the variable have
#' been prefixed with `PrimaryCollaborator_` and `SecondaryCollaborator_` to represent the
#' direction of collaboration.
#'
#' @family Data
#' @family Network
#'
#' @return data frame.
#'
#' @format A data frame with 126 rows and 5 variables:
#' \describe{
#'   \item{PrimaryCollaborator_Organization}{ }
#'   \item{SecondaryCollaborator_Organization}{ }
#'   \item{MetricDate}{ }
#'   \item{Meeting_Count}{ }
#'   \item{Group_Meeting_Time_Invested}{ }
#'
#'   ...
#' }
#' @source \url{https://analysis.insights.viva.office.com/analyst/analysis/}
"g2g_data"
