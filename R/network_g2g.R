# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See LICENSE.txt in the project root for license information.
# --------------------------------------------------------------------------------------------

#' @title Create a network plot with the group-to-group query
#'
#' @description
#' Pass a data frame containing a group-to-group query and return a network
#' plot. Automatically handles `"Within Group"` and `"Other_collaborators"`
#' values within query data.
#'
#' @param data Data frame containing a group-to-group query.
#' @param primary String containing the variable name for the Primary
#'   Collaborator column.
#' @param secondary String containing the variable name for the Secondary
#'   Collaborator column.
#' @param metric String containing the variable name for metric. Defaults to
#'   `Meeting_Count`.
#' @param algorithm String to specify the node placement algorithm to be used.
#'   Defaults to `"fr"` for the force-directed algorithm of Fruchterman and
#'   Reingold. See
#'   <https://rdrr.io/cran/ggraph/man/layout_tbl_graph_igraph.html> for a full
#'   list of options.
#' @param node_colour String or named vector to specify the colour to be used
#'   for displaying nodes. Defaults to `"lightblue"`.
#'   - If `"vary"` is supplied, a different colour is shown for each node at
#' random.
#'   - If a named vector is supplied, the names must match the values of the
#'   variable provided for the `primary` and `secondary` columns. See
#'   example section for details.
#' @param exc_threshold Numeric value between 0 and 1 specifying the exclusion
#'   threshold to apply. Defaults to 0.1, which means that the plot will only
#'   display collaboration above 10% of a node's total collaboration. This
#'   argument has no impact on `"data"` or `"table"` return.
#' @param org_count Optional data frame to provide the size of each organization
#' in the `secondary` attribute. The data frame should contain only two
#' columns:
#'   - Name of the `secondary` attribute excluding any prefixes, e.g.
#'   `"Organization"`. Must be of character or factor type.
#'   - `"n"`. Must be of numeric type.
#' Defaults to `NULL`, where node sizes will be fixed.
#'
#' @param subtitle String to override default plot subtitle.
#' @param return String specifying what to return. This must be one of the
#'   following strings:
#'   - `"plot"`
#'   - `"table"`
#'   - `"network"`
#'   - `"data"`
#'
#' See `Value` for more information.
#'
#' @return
#' A different output is returned depending on the value passed to the `return`
#' argument:
#'   - `"plot"`: 'ggplot' object. A group-to-group network plot.
#'   - `"table"`: data frame. An interactive matrix of the network.
#'   - `"network`: 'igraph' object used for creating the network plot.
#'   - `"data"`: data frame. A long table of the underlying data.
#'
#' @examples
#' # Return a network plot
#' g2g_data %>% network_g2g(metric = "Meeting_Count")
#'
#' # Return a network plot - Meeting hours and 5% threshold
#' network_g2g(
#'   data = g2g_data,
#'   metric = "Meeting_Count",
#'   primary = "PrimaryCollaborator_Organization",
#'   secondary = "SecondaryCollaborator_Organization",
#'   exc_threshold = 0.05
#' )
#'
#' # Return a network plot - custom-specific colours
#' # Get labels of orgs and assign random colours
#' org_str <- unique(g2g_data$PrimaryCollaborator_Organization)
#'
#' col_str <-
#'   sample(
#'     x = heat_colours(n = length(org_str)), # generate colour codes for each one
#'     size = length(org_str),
#'     replace = TRUE
#'   )
#'
#' # Create and supply a named vector to `node_colour`
#' names(col_str) <- org_str
#'
#' g2g_data %>%
#'   network_g2g(node_colour = col_str)
#'
#'
#' # Return a network plot with circle layout
#' # Vary node colours and add org sizes
#' org_tb <-
#'   data.frame(
#'     Organization = c(
#'       "G&A East",
#'       "G&A West",
#'       "G&A North",
#'       "South Sales",
#'       "North Sales",
#'       "G&A South"
#'     ),
#'     n = sample(30:1000, size = 6)
#'   )
#'
#' g2g_data %>%
#'   network_g2g(algorithm = "circle",
#'               node_colour = "vary",
#'               org_count = org_tb)
#'
#' # Return an interaction matrix
#' # Minimum arguments specified
#' g2g_data %>%
#'   network_g2g(return = "table")
#'
#' @import ggplot2
#' @import dplyr
#'
#' @family Network
#'
#'
#' @export
network_g2g <- function(data,
                        primary = NULL,
                        secondary = NULL,
                        metric = "Group_collaboration_time_invested",
                        algorithm = "fr",
                        node_colour = "lightblue",
                        exc_threshold = 0.1,
                        org_count = NULL,
                        subtitle = "Collaboration Across Organizations",
                        return = "plot"){

  if(is.null(primary)){

    # Only return first match
    primary <-
      names(data)[grepl(pattern = "^PrimaryCollaborator_", names(data))][1]

    message(
      paste("`primary` field not provided.",
            "Assuming", wrap(primary, wrapper = "`"),
            "as the `primary` variable.")
    )

  }

  if(is.null(secondary)){

    # Only return first match
    secondary <-
      names(data)[grepl(pattern = "^SecondaryCollaborator_", names(data))][1]

    message(
      paste("`secondary` field not provided.",
            "Assuming", wrap(secondary, wrapper = "`"),
            "as the `secondary` variable.")
    )
  }

  ## Get string of HR variable
  hrvar_string <- gsub(pattern = "SecondaryCollaborator_",
                       replacement = "",
                       x = secondary)

  ## Warn if 'Within Group' is not present in data
  if(! "Within Group" %in% unique(data[[secondary]])){

    warning(
      "`Within Group` is not found in the `secondary` variable.
      The analysis may be excluding in-group collaboration."
    )
  }


  ## Run plot_data
  plot_data <-
    data %>%
    rename(PrimaryOrg = primary,
           SecondaryOrg = secondary,
           Metric = metric) %>%
    mutate(SecondaryOrg = case_when(SecondaryOrg == "Within Group" ~ PrimaryOrg,
                                       TRUE ~ SecondaryOrg)) %>%
    group_by(PrimaryOrg, SecondaryOrg) %>%
    filter(PrimaryOrg != "Other_Collaborators" &
             SecondaryOrg!="Other_Collaborators") %>%
    summarise_at("Metric", ~mean(.)) %>%
    group_by(PrimaryOrg) %>%
    mutate(metric_prop = Metric / sum(Metric, na.rm = TRUE)) %>%
    select(PrimaryOrg, SecondaryOrg, metric_prop) %>%
    ungroup()

  if(return == "table"){

    ## Return a 'tidy' matrix
    plot_data %>%
      tidyr::pivot_wider(names_from = SecondaryOrg,
                         values_from = metric_prop)

  } else if(return == "data"){

    ## Return long table
    plot_data

  } else if(return %in% c("plot", "network")){

    ## Network object
    mynet_em <-
      plot_data %>%
      filter(metric_prop > exc_threshold) %>%
      mutate(
        across(
          .cols = c(PrimaryOrg, SecondaryOrg),
          .fns = ~sub(pattern = " ", replacement = "\n", x = .)
        )) %>%
      mutate(metric_prop = metric_prop * 10) %>%
      igraph::graph_from_data_frame(directed = FALSE)

    # Org count vary by size -------------------------------------------

    if(!is.null(org_count)){

      igraph::V(mynet_em)$org_size <-
        tibble(id = igraph::get.vertex.attribute(mynet_em)$name) %>%
        mutate(id = gsub(pattern = "\n", replacement = " ", x = id)) %>%
        left_join(org_count, by = c("id" = hrvar_string)) %>%
        pull(n)

    } else {

      # Imputed size if not specified
      igraph::V(mynet_em)$org_size <-
        tibble(id = igraph::get.vertex.attribute(mynet_em)$name) %>%
        mutate(id = gsub(pattern = "\n", replacement = " ", x = id)) %>%
        mutate(n = 20) %>%
        pull(n)
    }

    ## Plot object
    plot_obj <-
      mynet_em %>%
      ggraph::ggraph(layout = algorithm) +
      ggraph::geom_edge_link(aes(edge_width = metric_prop * 1),
                             edge_alpha = 0.5,
                             edge_colour = "grey")

    if(return == "network"){

      mynet_em # Return 'igraph' object

    } else {

      # Custom node colours ----------------------------------------------

      # String vector with length greater than 1
      if(is.character(node_colour) & length(node_colour) > 1){

        names(node_colour) <-
          gsub(
            pattern = " ",
            replacement = "\n",
            x = names(node_colour))

        plot_obj <-
          plot_obj +
          ggraph::geom_node_point(
            aes(color = name,
                size = org_size),
            alpha = 0.9
          ) +
          scale_colour_manual(
            # Enable matching
            values = node_colour
          )

        # Auto assign colours

      } else if(node_colour == "vary"){

        plot_obj <-
          plot_obj +
          ggraph::geom_node_point(
            aes(color = name,
                size = org_size),
            alpha = 0.9
          )

      } else {

        plot_obj <-
          plot_obj +
          ggraph::geom_node_point(
            aes(size = org_size),
            colour = node_colour,
            alpha = 0.9
          )

      }

      plot_obj +
        ggraph::geom_node_text(aes(label = name), size = 3, repel = FALSE) +
        ggplot2::theme(
          panel.background = ggplot2::element_rect(fill = 'white'),
          legend.position = "none") +
        theme_wpa_basic() +
        scale_size(range = c(1, 30)) +
        labs(title = "Group to Group Collaboration",
             subtitle = subtitle,
             x = "",
             y = "",
             caption = paste("Displays only collaboration above ", exc_threshold * 100, "% of node's total collaboration", sep = "")) +
        theme(axis.line = element_blank(),
              axis.text = element_blank(),
              legend.position = "none")

    }

  } else {

    stop("Please enter a valid input for `return`.")

  }
}
