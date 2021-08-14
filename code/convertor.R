library(igraph)

graph_edges <- read.csv(file = "./csv/P2P/edges.csv", header = TRUE)

graph <- graph_from_data_frame(graph_edges, directed = TRUE)
graph <- simplify(graph, remove.multiple = TRUE, remove.loops = TRUE)

if (is.directed(graph)) {
    graph <- as.undirected(graph)
}

if (!is.connected(graph)) {
    com <- components(graph)
    gr <- groups(com)
    graph <- induced_subgraph(graph, gr[[1]])
}

E(graph)$weight <- runif(n = length(E(graph)), min = 0.2, max = 0.8)

cat(sprintf("Nodes: %s\nEdges: %s\n", length(V(graph)), length(E(graph))))

save(graph, file = "./graphs/P2P.RData")

# E-R Random
# graph <- sample_gnp(5000, 1/1050)
# V(graph)$name <- as.character(V(graph))
# E(graph)$weight <- runif(n = length(E(graph)), min = 0.2, max = 0.8)
# cat(sprintf("Nodes: %s\nEdges: %s\n", length(V(graph)), length(E(graph))))
# save(graph, file = "./graphs/Random.RData")