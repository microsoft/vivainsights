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
#'   - `'plot'` (default)
#'   - `'plot-pdf'`
#'   - `'sankey'`
#'   - `'table'`
#'   - `'data'`
#'   - `'network'`
#' @param centrality string to determines which centrality measure is used to
#'   scale the size of the nodes. All centrality measures are automatically
#'   calculated when it is set to one of the below values, and reflected in the
#'   `'network'` and `'data'` outputs.
#' Measures include:
#'   - `betweenness`
#'   - `closeness`
#'   - `degree`
#'   - `eigenvector`
#'   - `pagerank`
#'
#' When `centrality` is set to NULL, no centrality is calculated in the outputs
#' and all the nodes would have the same size.
#'
#' @param community String determining which community detection algorithms to
#'   apply. Valid values include:
#'   - `NULL` (default): compute analysis or visuals without computing
#'   communities.
#'   - `"louvain"`
#'   - `"leiden"`
#'   - `"edge_betweenness"`
#'   - `"fast_greedy"`
#'   - `"fluid_communities"`
#'   - `"infomap"`
#'   - `"label_prop"`
#'   - `"leading_eigen"`
#'   - `"optimal"`
#'   - `"spinglass"`
#'   - `"walk_trap`
#'
#'  These values map to the community detection algorithms offered by `igraph`.
#'  For instance, `"leiden"` is based on `igraph::cluster_leiden()`. Please see
#'  the bottom of <https://igraph.org/r/html/1.3.0/cluster_leiden.html> on all
#'  applications and parameters of these algorithms.
#'   .
#' @param weight String to specify which column to use as weights for the
#'   network. To create a graph without weights, supply `NULL` to this argument.
#' @param comm_args list containing the arguments to be passed through to
#'   igraph's clustering algorithms. Arguments must be named. See examples
#'   section on how to supply arguments in a named list.
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
#' @param node_sizes Numeric vector of length two to specify the range of node
#' sizes to rescale to, when `centrality` is set to a non-null value.
#' @param seed Seed for the random number generator passed to either
#'   `set.seed()` when the louvain or leiden community detection algorithm is
#'   used, to ensure consistency. Only applicable when `community` is set to
#'   one of the valid non-null values.
#'
#' @return
#' A different output is returned depending on the value passed to the `return`
#' argument:
#'   - `'plot'`: return a network plot, interactively within R.
#'   - `'plot-pdf'`: save a network plot as PDF. This option is recommended when
#'   the graph is large, which make take a long time to run if `return = 'plot'`
#'   is selected. Use this together with `path` to control the save location.
#'   - `'sankey'`: return a sankey plot combining communities and HR attribute.
#'   This is only valid if a community detection method is selected at
#'   `community`.
#'   - `'table'`: return a vertex summary table with counts in communities and
#'   HR attribute.
#'   - `'data'`: return a vertex data file that matches vertices with
#'   communities and HR attributes.
#'   - `'network'`: return 'igraph' object.
#'
#' @family Network
#'
#' @examples
#' p2p_df <- p2p_data_sim(dim = 1, size = 100)
#'
#' # default - ggraph visual
#' network_p2p(data = p2p_df, style = "ggraph")
#'
#' # return vertex table
#' network_p2p(data = p2p_df, return = "table")
#'
#' # return vertex table with community detection
#' network_p2p(data = p2p_df, community = "leiden", return = "table")
#'
#' # leiden - igraph style
#' network_p2p(data = p2p_df, community = "leiden")
#'
#' # louvain - ggraph style
#' network_p2p(data = p2p_df, style = "ggraph", community = "louvain")
#'
#' # leiden - return a sankey visual with custom resolution parameters
#' network_p2p(
#'   data = p2p_df,
#'   community = "leiden",
#'   return = "sankey",
#'   comm_args = list("resolution" = 0.3)
#' )
#'
#' # using `fluid_communities` algorithm with custom parameters
#' network_p2p(
#'   data = p2p_df,
#'   community = "fluid_communities",
#'   comm_args = list("no.of.communities" = 5)
#' )
#'
#' # Calculate centrality measures and leiden communities, return at node level
#' network_p2p(
#'   data = p2p_df,
#'   centrality = TRUE,
#'   community = "leiden",
#'   return = "data"
#' ) %>%
#'   dplyr::glimpse()
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
    comm_args = NULL,
    algorithm = "mds",
    path = paste("p2p", NULL, sep = "_"),
    style = "igraph",
    bg_fill = "#FFFFFF",
    font_col = "grey20",
    legend_pos = "bottom",
    palette = "rainbow",
    node_alpha = 0.7,
    edge_alpha = 1,
    node_sizes = c(1, 20),
    seed = 1
    ){

    if(length(node_sizes) != 2){
      stop("`node_sizes` must be of length 2")
    }

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

    ## allowed `community` values
    valid_comm <- c(
      "leiden",
      "louvain",
      "edge_betweenness",
      "fast_greedy",
      "fluid_communities",
      "infomap",
      "label_prop",
      "leading_eigen",
      "optimal",
      "spinglass",
      "walk_trap"
    )

    ## Finalise `g` object
    ## If community detection is selected, this is where the communities are appended
    if(is.null(community)){ # no community detection

      g <- igraph::simplify(g_raw)
      v_attr <- hrvar # Name of vertex attribute

    } else if(community %in% valid_comm){

      set.seed(seed = seed)
      g_ud <- igraph::as.undirected(g_raw) # Convert to undirected

      alg_label <- paste0("igraph::cluster_", community)

      # combine arguments to clustering algorithm
      c_comm_args <- c(list("graph" = g_ud), comm_args)

      # output `communities` object
      comm_out <- do.call(eval(parse(text = alg_label)), c_comm_args)

      ## Add cluster
      g <-
        g_ud %>%
        # Add partitions to graph object
        # Return membership
        igraph::set_vertex_attr(
          "cluster",
          value = as.character(igraph::membership(comm_out))) %>%
        igraph::simplify()

      ## Name of vertex attribute
      v_attr <- "cluster"

    } else {

      stop("Please enter a valid input for `community`.")

    }


    # centrality calculations -------------------------------------------------
    # attach centrality calculations if `centrality` == TRUE`` is not NULL

    if(!is.null(centrality)){

      g <- network_summary(g, return = "network")

      igraph::V(g)$node_size <-
        igraph::get.vertex.attribute(
          g,
          name = centrality # from argument
          ) %>%
        scales::rescale(to = node_sizes) # min and max value

    } else {

      # all nodes with the same size if centrality is not calculated
      # adjust for plotting formats
      if(style == "igraph"){
        igraph::V(g)$node_size <- rep(3, igraph::vcount(g))
      } else if(style == "ggraph"){
        igraph::V(g)$node_size <- rep(2.5, igraph::vcount(g))
        node_sizes <- c(3, 3) # arbitrarily fix the node size
      }
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
    if(return %in% c("plot", "plot-pdf")){

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

          graphics::plot(
            g,
            layout = eval(parse(text = layout_text)),
            vertex.label = NA,
            # vertex.size = 3,
            vertex.size = igraph::V(g)$node_size,
            edge.arrow.mode = "-",
            edge.color = "#adadad"
          )

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
        if(return == "plot"){

          plot_basic_graph()

        } else if(return == "plot-pdf"){

          grDevices::pdf(out_path)

          plot_basic_graph()

          grDevices::dev.off()

          message(paste0("Saved to ", out_path, "."))

        }

      } else if(style == "ggraph"){

        plot_output <-
          g_layout +
          ggraph::geom_edge_link(colour = "lightgrey",
                                 edge_width = 0.05,
                                 alpha = edge_alpha)+
          ggraph::geom_node_point(aes(colour = !!sym(v_attr),
                                      size = node_size),
                                  alpha = node_alpha,
                                  pch = 16) +
          scale_size_continuous(range = node_sizes) +
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
               x = "") +
          guides(size = "none")

        # Default PDF output unless NULL supplied to path
        if(return == "plot"){

          plot_output

        } else if(return == "plot-pdf"){

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

    } else if(return == "sankey"){

      if(is.null(community)){

        message("Note: no sankey return option is available if `NULL` is selected at `community`.
      Please specify a valid community detection algorithm.")

      } else if(community %in% valid_comm){

        create_sankey(
          data = vertex_tb %>% count(!!sym(hrvar), cluster),
          var1 = hrvar,
          var2 = "cluster",
          count = "n"
        )

      }

    } else if(return == "table"){

      if(is.null(community)){

        vertex_tb %>% count(!!sym(hrvar))

      } else if(community %in% valid_comm){

        vertex_tb %>% count(!!sym(hrvar), cluster)

      }

    } else {

      stop("invalid input for `return`")

    }
}
