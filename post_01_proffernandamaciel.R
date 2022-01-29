x = -100:100
y1 = x + rnorm(201, sd = 5)
y2 = -x + rnorm(201, sd = 5)
y3 = x + rnorm(201, sd = 1000)
y4 = x^2 + rnorm(201, sd = 5)

df = data.frame(x,y1,y2,y3,y4)

library(ggplot2)
library(tidyverse)

df %>% 
  pivot_longer(!x, names_to = "y", 
               values_to = "valores") %>% 
  ggplot(aes(x,valores)) +
  geom_point() +
  facet_wrap(~y, scales = "free",
             labeller = as_labeller(c(
               y1 = "Correlação Linear Positiva",
               y2 = "Correlação Linear Negativa",
               y3 = "Não Há Correlação",
               y4 = "Correção Não Linear")))

options(scipen = 100)
round(cor(df)[1,],4)
