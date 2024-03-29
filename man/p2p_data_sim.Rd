% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/p2p_data_sim.R
\name{p2p_data_sim}
\alias{p2p_data_sim}
\title{Simulate a person-to-person query using a Watts-Strogatz model}
\usage{
p2p_data_sim(dim = 1, size = 300, nei = 5, p = 0.05)
}
\arguments{
\item{dim}{Integer constant, the dimension of the starting lattice.}

\item{size}{Integer constant, the size of the lattice along each dimension.}

\item{nei}{Integer constant, the neighborhood within which the vertices of
the lattice will be connected.}

\item{p}{Real constant between zero and one, the rewiring probability.}
}
\value{
data frame with the same column structure as a person-to-person flexible
query. This has an edgelist structure and can be used directly as an input
to \code{network_p2p()}.
}
\description{
Generate an person-to-person query / edgelist based on the graph
according to the Watts-Strogatz small-world network model. Organizational
data fields are also simulated for \code{Organization}, \code{LevelDesignation}, and
\code{City}.
}
\details{
This is a wrapper around \code{igraph::watts.strogatz.game()}. See igraph
documentation for details on methodology. Loop edges and multiple edges are
disabled. Size of the network can be changing the arguments \code{size} and \code{nei}.
}
\examples{
# Simulate a p2p dataset with 800 edges
p2p_data_sim(size = 200, nei = 4)

}
\seealso{
Other Data: 
\code{\link{g2g_data}},
\code{\link{mt_data}},
\code{\link{p2p_data}},
\code{\link{pq_data}}

Other Network: 
\code{\link{g2g_data}},
\code{\link{network_g2g}()},
\code{\link{network_p2p}()},
\code{\link{network_summary}()},
\code{\link{p2p_data}}
}
\concept{Data}
\concept{Network}
