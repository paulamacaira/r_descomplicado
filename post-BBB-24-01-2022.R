library(ggplot2)
library(network)
library(ggnetwork)

todos_participantes = c("Arthur","Bárbara","Brunna","Douglas","Eliezer","Eslovênia","Jade","Jessilane","Laís","Linn","Lucas","Luciano","Maria","Naiara","Natália","P.A.","Scooby","Rodrigo","Tiago","Vinicius")

matriz_auxiliar = matrix(NA, nrow = length(todos_participantes), ncol = length(todos_participantes),
                         dimnames = list(todos_participantes, todos_participantes))

links = data.frame(participante=c("Rodrigo","Bárbara","Laís","Arthur","Brunna","Eliezer","Eslovênia","Jade","Jessilane","Linn","Lucas","Luciano","Maria","Naiara","Natália","P.A.","Scooby","Tiago","Vinicius","Rodrigo","Bárbara","Laís","Arthur","Brunna","Eliezer","Eslovênia","Jade","Jessilane","Linn","Lucas","Luciano","Maria","Naiara","Natália","P.A.","Scooby","Tiago","Vinicius","Douglas","Naiara"),
                   voto = c("Scooby","Natália","Scooby","Natália","Lucas","Scooby","Jessilane","Lucas","Scooby","Lucas","Brunna","Jade","Jade","Lucas","Jade","Jessilane","Jessilane","Lucas","Jade","P.A.","Jessilane","P.A.","Brunna","Natália","Natália","Natália","Vinicius","P.A.","Jade","Scooby","Natália","Natália","Jade","Scooby","Brunna","Eliezer","Jade","Scooby", "Naiara", "Luciano"))

for(i in 1:nrow(matriz_auxiliar)){
  for(j in 1:ncol(matriz_auxiliar)){
    matriz_auxiliar[i,j] = sum(links$participante == rownames(matriz_auxiliar)[i] & links$voto == rownames(matriz_auxiliar)[j])
  }
}

rowSums(matriz_auxiliar)
colSums(matriz_auxiliar)

pipoca = c("Rodrigo", "Bárbara", "Laís", "Eliezer", "Eslovênia", "Jessilane", "Lucas", "Luciano", "Natália", "Vinicius")

n = network(matriz_auxiliar, directed = TRUE)

n %v% "num_votos" = colSums(matriz_auxiliar)
n %v% "phono" = ifelse(network.vertex.names(n) %in% pipoca, "Pipoca", "Camarote")

ggplot(n, aes(x = x, y = y, xend = xend, yend = yend)) +
  geom_nodes(aes(color = phono, size = num_votos), alpha = 0.3) +
  geom_edges(color = "grey50", alpha = 0.6,
             arrow = arrow(length = unit(6, "pt"), type = "closed")) +
  geom_nodetext_repel(aes(color = phono, label = vertex.names),
                      fontface = "bold", show.legend = FALSE) +
  scale_size_continuous(name = "Votos recebidos", range = c(0, 10), breaks = 0:7, labels = 0:7) +
  scale_color_manual(name = "Origem", values = c("Camarote" = "tomato", "Pipoca" = "steelblue"),
                     aesthetics = c("colour", "fill")) +
  theme_blank()

ggsave(filename = "rplot.png", units = "px", width = 1080*2+1000, height = 1080*2, dpi = 300, limitsize = FALSE)
