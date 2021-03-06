library(dplyr)
library(tidyverse)
library(lubridate)
library(ggplot2)
library(zoo)

dados = read.csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv")

colnames(dados)[-c(1:4)] = seq(as.Date("2020-01-22"), today()-1, by="days")

dados %>% 
  select(!c(Province.State,Lat,Long)) %>% 
  pivot_longer(!Country.Region, names_to = "Data", values_to = "Casos") %>% 
  group_by(Country.Region,Data) %>% 
  summarise(Casos = sum(Casos)) %>% 
  mutate(Data = as_date(as.numeric(Data)),
         Novos_Casos = Casos - lag(Casos),
         MM7dias = rollmean(Novos_Casos, k = 7, fill = NA)) %>% 
  filter(Country.Region %in% c("Israel","US","United Kingdom","Brazil")) %>% 
  ggplot(aes(x = Data, y = MM7dias, color = Country.Region)) +
  geom_line() +
  facet_wrap(~Country.Region, scales = "free") +
  theme_bw() +
  labs(title = "Casos Novos, média móvel 7 dias") +
  theme(legend.position = "none", 
        axis.title = element_blank(),
        title = element_text(size = 20),
        strip.text.x = element_text(size = 18),
        axis.text = element_text(size = 15))