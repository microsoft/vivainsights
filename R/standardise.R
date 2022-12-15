# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See LICENSE.txt in the project root for license information.
# --------------------------------------------------------------------------------------------
#' @title Standardise variable names for Standard Person Query Quietly for
#' `Collaboration_hours`
#'
#' @noRd
#'
qui_stan_c <- function(data){

  if(!("Collaboration_hours" %in% names(data)) &
     ("Collaboration_hrs" %in% names(data))){

    data <- data %>% mutate(Collaboration_hours = Collaboration_hrs)
    # message("Adding `Collaboration_hours` column based on `Collaboration_hrs`")

  }

  return(data)
}

#' @title Standardise variable names for Standard Person Query Quietly for
#' `Instant_Message_hours`
#'
#' @noRd
#'
qui_stan_im <- function(data){

  if(!("Instant_Message_hours" %in% names(data)) &
     ("Instant_message_hours" %in% names(data))){

    data <- data %>% mutate(Instant_Message_hours = Instant_message_hours)
    # message("Adding `Instant_Message_hours` column based on `Instant_message_hours`")

  }

  return(data)
}
