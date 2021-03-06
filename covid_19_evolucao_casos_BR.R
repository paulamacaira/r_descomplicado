library(geobr)
library(dplyr)
library(ggplot2)
library(zoo)

covid = read.csv("https://raw.githubusercontent.com/wcota/covid19br/master/cases-brazil-states.csv")

casos = covid %>% 
  group_by(state) %>% 
  mutate(casos_atual = max(totalCases)) %>%  
  filter(state != "TOTAL") %>% 
  mutate(mes_ano = as.yearmon(date),
         abbrev_state = state) %>% 
  group_by(mes_ano, abbrev_state) %>% 
  summarise(casos_mes = sum(newCases),
            percent = casos_mes/max(casos_atual)*100) %>% 
  select(mes_ano, abbrev_state,casos_mes,percent)

estados = read_state(year=2019) %>% 
  left_join(casos)

estados %>% 
  filter(mes_ano > "fev 2020",
         mes_ano < "mar 2021") %>% 
  mutate(mes_ano = as.factor(mes_ano)) %>% 
  ggplot() +
  geom_sf(aes(fill = percent)) +
  facet_wrap(~mes_ano) +
  labs(title = "Evolução dos casos por COVID-19") +
  scale_fill_distiller(palette = "Reds", name="Casos/Total Casos", direction = 1) +
  theme_minimal() +
  theme(legend.position = "bottom",
        title = element_text(size = 20),
        legend.text = element_text(size = 10),
        axis.title=element_blank(),
        axis.text=element_blank(),
        axis.ticks=element_blank(),
        legend.key.width = unit(2.5, 'cm'))