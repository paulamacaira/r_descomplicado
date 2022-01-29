library(dplyr)

#select

starwars %>% 
  select(name, height, mass)

#mutate
starwars %>% 
  mutate(peso_kg = height/100,
         IMC = mass/peso_kg^2) %>% 
  select(name, IMC)

#filter
starwars %>% 
  filter(species == "Human") %>% 
  select(name, height, mass)

#arrange
starwars %>% 
  filter(species == "Human") %>%
  arrange(height) %>% 
  select(name, height, mass)

#summarise
starwars %>% 
  filter(species == "Human") %>%
  summarise(mean(height, na.rm = T))

#group_by
starwars %>%
  group_by(species) %>%
  summarise(mean(height, na.rm = T))
