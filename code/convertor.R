library(igraph)

graph_edges <- read.csv(file = "./csv/hep-ph/edges.csv", header = TRUE)

graph <- graph_from_data_frame(graph_edges, directed = FALSE)
graph <- simplify(graph, remove.multiple = TRUE, remove.loops = TRUE)
E(graph)$weight <- runif(n = length(E(graph)), min = 0, max = 1)

save(graph, file = "./graph/HepPh.RData")