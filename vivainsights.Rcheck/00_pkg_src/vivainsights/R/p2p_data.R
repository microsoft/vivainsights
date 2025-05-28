# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See LICENSE.txt in the project root for license information.
# --------------------------------------------------------------------------------------------

#' @title Sample person-to-person dataset
#'
#' @description
#' A demo dataset representing a person-to-person query, structured as an
#' edgelist. The identifier variable for each person is `PersonId`, where the
#' variables have been prefixed with `PrimaryCollaborator_` and
#' `SecondaryCollaborator_` to represent the direction of collaboration.
#'
#' @family Data
#' @family Network
#'
#' @return data frame.
#'
#' @format A data frame with 11550 rows and 13 variables:
#' \describe{
#'   \item{PrimaryCollaborator_PersonId}{ }
#'   \item{SecondaryCollaborator_PersonId}{ }
#'   \item{MetricDate}{ }
#'   \item{Diverse_tie_score}{ }
#'   \item{Diverse_tie_type}{ }
#'   \item{Strong_tie_score}{ }
#'   \item{Strong_tie_type}{ }
#'   \item{PrimaryCollaborator_Organization}{ }
#'   \item{SecondaryCollaborator_Organization}{ }
#'   \item{PrimaryCollaborator_LevelDesignation}{ }
#'   \item{SecondaryCollaborator_LevelDesignation}{ }
#'   \item{PrimaryCollaborator_FunctionType}{ }
#'   \item{SecondaryCollaborator_FunctionType}{ }
#'
#'   ...
#' }
#' @source \url{https://analysis.insights.viva.office.com/analyst/analysis/}
"p2p_data"
