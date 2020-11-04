library(igraph)

graph_edges <- read.csv(file = "./csv/deezer/edges.csv", header = TRUE)

graph <- graph_from_data_frame(graph_edges, directed = FALSE)
graph <- simplify(graph, remove.multiple = TRUE, remove.loops = TRUE)

if (!is.connected(graph)) {
    com <- components(graph)
    gr <- groups(com)
    graph <- induced_subgraph(graph, gr[[1]])
}

E(graph)$weight <- runif(n = length(E(graph)), min = 0, max = 1)

cat(sprintf("Nodes: %s\nEdges: %s\n", length(V(graph)), length(E(graph))))

save(graph, file = "./graphs/Deezer.RData")