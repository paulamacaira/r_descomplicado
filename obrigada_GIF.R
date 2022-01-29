library(ggplot2)
library(gganimate)

df = dplyr::tibble(x = 1:10, frase = "Obrigada!", y = x + runif(1))

ggplot(df, aes(x, y, frame = x, label = frase)) +
  geom_text(size = 20, color = "steelblue") + 
  xlim(-5,15) + ylim(0,10.5) +
  transition_states(x) +
  theme(legend.position = "none",
        axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank())
anim_save("teste.gif", animation = last_animation())
