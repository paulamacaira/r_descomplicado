installed.packages("ggplot2")
library(ggplot2)

ggplot(midwest, aes(x=area, y=poptotal))

ggplot(midwest, aes(x=area, y=poptotal)) +
  geom_point()

ggplot(midwest, aes(x=area, y=poptotal)) +
  geom_point() +
  geom_smooth(method = "lm")

ggplot(midwest, aes(x=area, y=poptotal)) +
  geom_point() +
  geom_smooth(method = "lm") +
  coord_cartesian(xlim=c(0,0.1), ylim=c(0, 1000000))

# EXERCÍCIO
# Utilizando a base de dados txhousing, obtenha um gráfico de linha e pontos,
# onde no eixo x encontram-se os anos (year) de vendas e no eixo y o número de vendas (sales) de casas.
# Um detalhe é que essas vendas serão TOTAIS e não por cidade. Dica: use os comandos já aprendidos do tidyverse.