# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See LICENSE.txt in the project root for license information.
# --------------------------------------------------------------------------------------------

#' @title Perform network analysis with the person-to-person query
#'
#' @description
#' `r lifecycle::badge('experimental')`
#'
#' Analyse a person-to-person (P2P) network query, with multiple visualisation
#' and analysis output options. Pass a data frame containing a person-to-person
#' query and return a network visualization. Options are available for community
#' detection using either the Louvain or the Leiden algorithms.
#'
#' @param data Data frame containing a person-to-person query.
#' @param hrvar String containing the label for the HR attribute.
#' @param return
#' A different output is returned depending on the value passed to the `return`
#' argument:
#' @param centrality String determining whether centrality measures are calculated
#' and reflected in the plot. Valid values include:
#'   - `betweenness`
#'   - `closeness`
#'   - `degree`
#'   - `eigenvector`
#'   - `pagerank`
#' @param community String determining what output to return. Valid values
#'   include:
#'   - `NULL` (default): compute analysis or visuals without computing
#'   communities.
#'   - `"louvain"`: compute analysis or visuals with community detection, using
#'   the Louvain algorithm. This is a wrapper around
#'   `igraph::cluster_louvain()`.
#'   - `"leiden"`: compute analysis or visuals with community detection, using
#'   the Leiden algorithm. This is a wrapper around `igraph::cluster_leiden()`.
#' @param weight String to specify which column to use as weights for the
#'   network. To create a graph without weights, supply `NULL` to this argument.
#' @param algorithm String to specify the node placement algorithm to be used.
#'   Defaults to `"mds"` for the deterministic multi-dimensional scaling of
#'   nodes. See
#'   <https://rdrr.io/cran/ggraph/man/layout_tbl_graph_igraph.html> for a full
#'   list of options.
#' @param path File path for saving the PDF output. Defaults to a timestamped
#'   path based on current parameters.
#' @param style String to specify which plotting style to use for the network
#' plot. Valid values include:
#'   - `"igraph"`
#'   - `"ggraph"`
#' @param bg_fill String to specify background fill colour.
#' @param font_col String to specify font and link colour.
#' @param legend_pos String to specify position of legend. Defaults to
#'   `"bottom"`. See `ggplot2::theme()`. This is applicable for both the
#'   'ggraph' and the fast plotting method. Valid inputs include:
#'   - `"bottom"`
#'   - `"top"`
#'   - `"left"`
#'   -`"right"`
#'
#' @param palette Function for generating a colour palette with a single
#'   argument `n`. Uses "rainbow" by default.
#' @param node_alpha A numeric value between 0 and 1 to specify the transparency
#'   of the nodes. Defaults to 0.7.
#' @param edge_alpha A numeric value between 0 and 1 to specify the transparency
#'   of the edges (only for 'ggraph' mode). Defaults to 1.
#' @param res Resolution parameter to be passed to `igraph::cluster_leiden()`.
#'   Defaults to 0.5.
#' @param seed Seed for the random number generator passed to either
#'   `set.seed()` when the louvain or leiden community detection algorithm is
#'   used, to ensure consistency. Only applicable when `community` is set to
#'   `"louvain"` or `"leiden"`.
#'
#' @family Network
#'
#' @examples
#' p2p_df <- p2p_data_sim(dim = 1, size = 100)
#'
#'
#' # default - ggraph visual
#' network_p2p(data = p2p_df, style = "ggraph", path = NULL)
#'
#' # return vertex table
#' network_p2p(data = p2p_df, return = "table")
#'
#' # louvain - igraph style
#' network_p2p(data = p2p_df, community = "louvain", path = NULL)
#'
#' # leiden - igraph style
#' network_p2p(data = p2p_df, community = "leiden", path = NULL)
#'
#' @import ggplot2
#' @import dplyr
#'
#' @export

network_p2p <-
  function(
    data,
    hrvar = "Organization",
    return = "plot",
    centrality = NULL,
    community = NULL,
    weight = NULL,
    algorithm = "mds",
    path = paste("p2p", NULL, sep = "_"),
    style = "igraph",
    bg_fill = "#FFFFFF",
    font_col = "grey20",
    legend_pos = "bottom",
    palette = "rainbow",
    node_alpha = 0.7,
    edge_alpha = 1,
    res = 0.5,
    seed = 1
    ){

    ## Set data frame for edges
    if(is.null(weight)){

      edges <-
        data %>%
        mutate(NoWeight = 1) %>% # No weight
        select(from = "PrimaryCollaborator_PersonId",
               to = "SecondaryCollaborator_PersonId",
               weight = "NoWeight")

    } else {

      edges <-
        data %>%
        select(from = "PrimaryCollaborator_PersonId",
               to = "SecondaryCollaborator_PersonId",
               weight = weight)

    }

    ## Set variables
    # TieOrigin = PrimaryCollaborator
    # TieDestination = SecondaryCollaborator
    pc_hrvar <- paste0("PrimaryCollaborator_", hrvar)
    sc_hrvar <- paste0("SecondaryCollaborator_", hrvar)

    ## Vertices data frame to provide meta-data
    vert_ft <-
      rbind(
        # TieOrigin
        edges %>%
          select(from) %>% # Single column
          unique() %>% # Remove duplications
          left_join(select(data, PrimaryCollaborator_PersonId, pc_hrvar),
                    by = c("from"  = "PrimaryCollaborator_PersonId")) %>%
          select(node = "from", !!sym(hrvar) := pc_hrvar),

        # TieDestination
        edges %>%
          select(to) %>% # Single column
          unique() %>% # Remove duplications
          left_join(select(data, SecondaryCollaborator_PersonId, sc_hrvar),
                    by = c("to"  = "SecondaryCollaborator_PersonId")) %>%
          select(node = "to", !!sym(hrvar) := sc_hrvar)
      )



    ## Create 'igraph' object
    g_raw <-
      igraph::graph_from_data_frame(edges,
                                    directed = TRUE, # Directed, but FALSE for visualization
                                    vertices = unique(vert_ft)) # remove duplicates

    ## Assign weights
    g_raw$weight <- edges$weight

    ## Finalise `g` object
    ## If community detection is selected, this is where the communities are appended
    if(is.null(community)){ # no community detection

      g <- igraph::simplify(g_raw)
      v_attr <- hrvar # Name of vertex attribute

    } else if(community == "louvain"){

      set.seed(seed = seed)
      g_ud <- igraph::as.undirected(g_raw) # Convert to undirected

      ## Return a numeric vector of partitions / clusters / modules
      ## Set a low resolution parameter to have fewer groups for leiden method
      ## weights = NULL means that if the graph as a `weight` edge attribute,
      ## the present attribute will be used by default.
      if(res != 0.5){
        warning("`res` parameter is only applicable to the 'leiden' method.")
      }

      lc <- igraph::cluster_louvain(g_ud, weights = NULL)

      ## Add cluster
      g <-
        g_ud %>%
        # Add louvain partitions to graph object
        # Return membership - diff from Leiden
        igraph::set_vertex_attr(
          "cluster",
          value = as.character(igraph::membership(lc))) %>%
        igraph::simplify()

      ## Name of vertex attribute
      v_attr <- "cluster"

    } else if(community == "leiden"){

      set.seed(seed = seed)
      ## Using `g` because Leiden algorithm is only implemented for undirected
      ## graphs.
      g_ud <- igraph::as.undirected(g_raw) # Convert to undirected

      ## Return a numeric vector of partitions / clusters / modules
      ## Set a low resolution parameter to have fewer groups
      ld <- igraph::cluster_leiden(
        graph = g_ud,
        resolution_parameter = res,
        weights = g_ud$weight # create partitions
      )

      ## Add cluster
      g <-
        g_ud %>%
        # Add leiden partitions to graph object
        igraph::set_vertex_attr(
          "cluster",
          value = as.character(ld$membership)
          ) %>%
        igraph::simplify()

      ## Name of vertex attribute
      v_attr <- "cluster"

    } else {

      stop("Please enter a valid input for `community`.")

    }

    # Common area -------------------------------------------------------------

    ## Create vertex table
    vertex_tb <-
      g %>%
      igraph::get.vertex.attribute() %>%
      as_tibble()

    ## Set layout for graph
    g_layout <-
      g %>%
      ggraph::ggraph(layout = "igraph", algorithm = algorithm)

    ## Timestamped File Path
    out_path <- paste0(path, "_", tstamp(), ".pdf")

    # Return outputs ----------------------------------------------------------

    ## Use fast plotting method
    if(return == "plot"){

      if(style == "igraph"){

        message("Using fast plot method due to large network size...")

        ## Set colours
        colour_tb <-
          tibble(!!sym(v_attr) := unique(igraph::get.vertex.attribute(g, name = v_attr))) %>%
          mutate(colour = rainbow(nrow(.))) # No palette choice

        ## Colour vector
        colour_v <-
          tibble(!!sym(v_attr) := igraph::get.vertex.attribute(g, name = v_attr)) %>%
          left_join(colour_tb, by = v_attr) %>%
          pull(colour)

        ## Set graph plot colours
        igraph::V(g)$color <- grDevices::adjustcolor(colour_v, alpha.f = node_alpha)
        igraph::V(g)$frame.color <- NA
        igraph::E(g)$width <- 1

        ## Internal basic plotting function used inside `network_p2p()`
        plot_basic_graph <- function(lpos = legend_pos){

          old_par <- par(no.readonly = TRUE)
          on.exit(par(old_par))

          par(bg = bg_fill)

          layout_text <- paste0("igraph::layout_with_", algorithm)

          ## Legend position

          if(lpos == "left"){

            leg_x <- -1.5
            leg_y <- 0.5

          } else if(lpos == "right"){

            leg_x <- 1.5
            leg_y <- 0.5

          } else if(lpos == "top"){

            leg_x <- 0
            leg_y <- 1.5

          } else if(lpos == "bottom"){

            leg_x <- 0
            leg_y <- -1.0

          } else {

            stop("Invalid `legend_pos` input.")

          }

          graphics::plot(g,
                         layout = eval(parse(text = layout_text)),
                         vertex.label = NA,
                         vertex.size = 3,
                         edge.arrow.mode = "-",
                         edge.color = "#adadad")

          graphics::legend(x = leg_x,
                           y = leg_y,
                           legend = colour_tb[[v_attr]], # vertex attribute
                           pch = 21,
                           text.col = font_col,
                           col = "#777777",
                           pt.bg = colour_tb$colour,
                           pt.cex = 2,
                           cex = .8,
                           bty = "n",
                           ncol = 1)
        }

        ## Default PDF output unless NULL supplied to path
        if(is.null(path)){

          plot_basic_graph()

        } else {

          grDevices::pdf(out_path)

          plot_basic_graph()

          grDevices::dev.off()

          message(paste0("Saved to ", out_path, "."))

        }
      } else if(style == "ggraph"){

        plot_output <-
          g_layout +
          ggraph::geom_edge_link(colour = "lightgrey", edge_width = 0.05, alpha = edge_alpha) +
          ggraph::geom_node_point(aes(colour = !!sym(v_attr)),
                                  alpha = node_alpha,
                                  pch = 16) +
          theme_void() +
          theme(
            legend.position = legend_pos,
            legend.background = element_rect(fill = bg_fill, colour = bg_fill),

            text = element_text(colour = font_col),
            axis.line = element_blank(),
            panel.grid = element_blank()
          ) +
          labs(caption = paste0("Person to person collaboration showing ", v_attr, ".  "), # spaces intentional
               y = "",
               x = "")

        # Default PDF output unless NULL supplied to path
        if(is.null(path)){

          plot_output

        } else {

          ggsave(out_path,
                 plot = plot_output,
                 width = 16,
                 height = 9)

          message(paste0("Saved to ", out_path, "."))

        }

      } else {

        stop("invalid input for `style`")

      }

    } else if (return == "data"){

      vertex_tb

    } else if(return == "network"){

      g

    } else if(return == "table"){

      if(is.null(community)){

        vertex_tb %>% count(!!sym(hrvar))

      } else if(community %in% c("louvain", "leiden")){

        vertex_tb %>% count(!!sym(hrvar), cluster)

      }

    } else {

      stop("invalid input for `return`")

    }
}