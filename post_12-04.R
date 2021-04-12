# post 12/04

install.packages("tidyverse")
library(tidyverse)

starwars %>%
  filter(height > 160 |
           eye_color == "blue")
starwars %>%
  arrange(height, -mass)

starwars %>%
  select(name, hair_color)

starwars %>%
  mutate(Pes = height*0.0328084)

starwars %>%
  summarise(n_distinct(species))

starwars %>% 
  group_by(gender) %>%
  summarise(Media = mean(height))

# EXERCICIO
# Obtenha como resultado um conjunto de dados, em ordem decrescente,
# que contenha os valores máximos por cor de olho (eye_color) dos
# moradores do mundo (homeworld) Tatooine.