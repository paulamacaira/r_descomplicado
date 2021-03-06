library(dplyr)

# primeiras linhas do dataset starwars
head(starwars)

# filtrando apenas humanos que residem em Tatooine e selecionando apenas o nome a cor do cabelo
starwars %>%
  filter(species == "Human",
         homeworld == "Tatooine")  %>% 
  select(name,hair_color)

# calculando a média da altura com o filtro anterior
starwars %>%
  filter(species == "Human",
         homeworld == "Tatooine") %>% 
  summarise(mean(height))

# calculando a média da altura para residentes de Tatooine por espécie
starwars %>%
  filter(homeworld == "Tatooine") %>% 
  group_by(species) %>% 
  summarise(mean(height))

# transformando a altura para metros e organizando em ordem decrescente
starwars %>%
  mutate(height = height/100) %>% 
  arrange(desc(height))
