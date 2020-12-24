library(igraph)

ego_vertexs <- c("12831", "78813", "356963", "428333", "612473", "613313", "623623", "629863", "734493")

graph <- graph.empty(n = 0, directed = FALSE)

for (v in ego_vertexs) {
    temp_edges <- read.csv(file = paste("./csv/ego/", v, ".csv", sep = ""), header = TRUE)
    temp_graph <- graph_from_data_frame(temp_edges, directed = FALSE)
    temp_graph <- temp_graph + vertex(n)

    vertex_names <- V(temp_graph)$name
    vertex_names <- vertex_names[-which(vertex_names == n)]
    edge_ids <- vector(mode = "character", length = 0)
    temp <- sapply(vertex_names, function(x) {
        edge_ids <<- c(edge_ids, n, x)
    })
    temp_graph <- add_edges(temp_graph, edge_ids)

    temp_graph <- simplify(temp_graph, remove.multiple = TRUE, remove.loops = TRUE)

    graph <- graph %u% temp_graph
}

edgelist <- as_edgelist(graph, names = F)
write.csv(edgelist, "Ego.csv")