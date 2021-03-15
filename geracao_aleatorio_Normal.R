
library(ggplot2)
dados = data.frame(y = c(rnorm(10, mean = 30, sd = 2),
                         rnorm(100, mean = 30, sd = 2),
                         rnorm(1000, mean = 30, sd = 2),
                         rnorm(10000, mean = 30, sd = 2)), 
                   nome = c(rep("Normal[10]",10),
                            rep("Normal[100]",100),
                            rep("Normal[1000]",1000),
                            rep("Normal[10000]",10000)))
ggplot(dados,aes(y)) +
  geom_histogram(color = "white") +
  facet_wrap(~nome, scales = "free") +
  theme(axis.title = element_blank(),
        axis.)
