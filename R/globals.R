# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See LICENSE.txt in the project root for license information.
# --------------------------------------------------------------------------------------------

###################################################################

## Global Variables

## This file is added to minimize the false positives flagged during R CMD check.
## Example: afterhours_trend: no visible binding for global variable 'Date'

###################################################################

utils::globalVariables(
  c(
    "PersonId",
    ".",
    "group",
    "Employee_Count",
    "PANEL",
    "y",
    "x",
    "bucket_hours",
    "Employees",
    "heat_colours",
    "xmin",
    "xmax",
    "Date",
    "MetricDate", # New `Date`
    "top_group",
    "OrgGroup",
    "var1",
    "var2",
    "Total",
    "Metric",
    "Value",
    "Start",
    "End",
    "Group",
    "value",
    "where", # in `jitter_metrics()` for tidyselect
    "Hours",
    "Collaboration_hours",
    "External_collaboration_hours",
    "attribute",
    "values",
    "calculation",
    "variable",
    "value_rescaled",
    "Meeting_hours_with_manager_1_1",
    "Meetings_with_manager_1_on_1",
    "Cadence_of_1_on_1_meetings_with_manager"
    )
)
