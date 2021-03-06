
library(ggplot2)

ggplot(data=diamonds, aes(x=carat, y=price)) +
  geom_point() +
  labs(title="Gráfico de Dispersão", x="Característica", y="Preço")+
  theme_minimal() +
  facet_wrap(~cut, ncol=3) +
  ggsave("meu_grafico.png")

