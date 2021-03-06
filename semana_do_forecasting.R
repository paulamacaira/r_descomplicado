# Códigos dos posts Semana do Forecasting

library(fable)
library(feasts)
library(tsibbledata)
library(tidyverse)
library(tsibble)
library(lubridate)

# Decomposição STL

vic_elec %>%
  model(STL(Demand)) %>%
  components() %>%
  autoplot()

# Suavização Exponencial

aus_holidays = tourism %>%
  filter(Purpose == "Holiday") %>%  
  summarise(Trips = sum(Trips)/1e3)

aus_holidays %>%
  model(NN = ETS(Trips  ~ trend("N") + season("N")),
        AN = ETS(Trips  ~ trend("A") + season("N")),
        AdN = ETS(Trips ~ trend("Ad") + season("N")),
        AA = ETS(Trips  ~ trend("A") + season("A")),
        AM = ETS(Trips  ~ trend("A") + season("M")),
        AdM = ETS(Trips ~ trend("Ad") + season("M"))) %>% 
  forecast(h = "3 years") %>%
  autoplot(aus_holidays, level = NULL)

# Modelos ARIMA

aus_holidays = tourism %>%
  filter(Purpose == "Holiday") %>%  
  summarise(Trips = sum(Trips)/1e3)

aus_holidays %>%
  model(ar = ARIMA(Trips ~ pdq(1,0,0)),
        ma = ARIMA(Trips ~ pdq(0,0,1)),
        arma = ARIMA(Trips ~ pdq(1,0,1)),
        arima = ARIMA(Trips ~ pdq(1,1,1)),
        sarima = ARIMA(Trips ~ pdq(1,0,0)+PDQ(0,0,1))) %>% 
  forecast(h = "3 years") %>%
  autoplot(aus_holidays, level = NULL)

# Modelos Hierárquicos

tourism_x = tourism %>% 
  aggregate_key((State/Region)*Purpose, Trips=sum(Trips)) %>% 
  filter(year(Quarter) >= 2010)

tourism_x %>% 
  model(base = ETS(Trips)) %>%
  reconcile(bu = bottom_up(base),
            mint = min_trace(base)) %>%
  forecast(h = "2 years") %>%
  filter(is_aggregated(Region), is_aggregated(Purpose)) %>%
  autoplot(tourism_x, level = NULL,size=1) +
  facet_wrap(vars(State), scales = "free_y")

# Gráficos de Séries Temporais

vic_elec %>% 
  autoplot(Demand)  

vic_elec %>% 
  gg_season(Demand, period = "week") 

vic_elec %>%
  ggplot(aes(x=Temperature, y=Demand)) +
  geom_point()

vic_elec %>%
  ACF(Demand, lag_max = 50) %>% autoplot()