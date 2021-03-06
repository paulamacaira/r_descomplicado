install.packages("tidyverse")
library(tidyverse)

as_tibble(iris)

tibble(
  x=1:5,
  y=1,
  z=x^2+y
)

starwars %>% 
  filter(species == "Human") %>% 
  group_by(gender) %>% 
  summarise(AlturaMedia = mean(height, na.rm = T))