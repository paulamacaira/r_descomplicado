llibrary(geobr)
library(ggplot2)
library(sf)
library(dplyr)

covid = read.csv("https://raw.githubusercontent.com/wcota/covid19br/master/cases-brazil-cities.csv") %>% 
  filter(state == "RJ") %>% 
  select(code_muni = ibgeID, deaths_by_totalCases)

rj = read_municipality(code_muni = "RJ", year= 2019) %>% 
  left_join(covid)

ggplot() +
  geom_sf(data = rj, aes(fill = deaths_by_totalCases)) +
  labs(title = "Municípios do Rio de Janeiro") +
  scale_fill_distiller(palette = "Greys", name="Mortes/Total Casos", direction = 1) +
  theme_minimal() +
  theme(legend.position = "bottom",
        title = element_text(size = 20),
        legend.text = element_text(size = 20),
        axis.title=element_blank(),
        axis.text=element_blank(),
        axis.ticks=element_blank(),
        legend.key.width = unit(2.5, 'cm'))