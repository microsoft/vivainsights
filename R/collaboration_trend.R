# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See LICENSE.txt in the project root for license information.
# --------------------------------------------------------------------------------------------

#' @title Collaboration Time Trend
#'
#' @description
#' Provides a week by week view of collaboration time.
#' By default returns a week by week heatmap, highlighting the points in time with most activity.
#' Additional options available to return a summary table.
#'
#' @template ch
#'
#' @inheritParams create_trend
#'
#' @family Visualization
#' @family Collaboration
#'
#' @return
#' Returns a 'ggplot' object by default, where 'plot' is passed in `return`.
#' When 'table' is passed, a summary table is returned as a data frame.
#'
#' @examples
#' # Run plot
#' collaboration_trend(pq_data)
#'
#' # Run table
#' collaboration_trend(pq_data, hrvar = "LevelDesignation", return = "table")
#'
#' @export

collaboration_trend <- function(data,
                                hrvar = "Organization",
                                mingroup = 5,
                                return = "plot"){

  create_trend(data,
               metric = "Collaboration_hours",
               hrvar = hrvar,
               mingroup = mingroup,
               return = return)

}
