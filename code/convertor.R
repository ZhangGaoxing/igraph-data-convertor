library(igraph)

graph_edges <- read.csv(file = "./csv/MathOverflow/edges.csv", header = TRUE)

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

save(graph, file = "./graphs/MathOverflow.RData")

# E-R Random
graph <- sample_gnp(10000, 1/500)
E(graph)$weight <- runif(n = length(E(graph)), min = 0.2, max = 0.8)
save(graph, file = "./graphs/Random.RData")
