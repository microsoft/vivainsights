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
#' @format A data frame with 150 rows and 11 variables:
#' \describe{
#'   \item{PrimaryCollaborator_Organization}{ }
#'   \item{PrimaryCollaborator_GroupSize}{ }
#'   \item{SecondaryCollaborator_Organization}{ }
#'   \item{SecondaryCollaborator_GroupSize}{ }
#'   \item{MetricDate}{ }
#'   \item{Percent_Group_collaboration_time_invested}{ }
#'   \item{Group_collaboration_time_invested}{ }
#'   \item{Group_email_sent_count}{ }
#'   \item{Group_email_time_invested}{ }
#'   \item{Group_meeting_count}{ }
#'   \item{Group_meeting_time_invested}{ }
#'   ...
#' }
#' @source \url{https://analysis.insights.viva.office.com/analyst/analysis/}
"g2g_data"
