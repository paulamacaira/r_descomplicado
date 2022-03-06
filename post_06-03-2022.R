library(tidyverse)
library(tsibble)
library(fable)
library(feasts)
library(tsibbledata)
library(fpp3)


aus_retail %>%
  filter(State == "Victoria",
         Industry == "Food retailing") %>%
  model(ets = ETS(Turnover)) %>% 
  forecast(h = 3)

aus_retail %>%
  filter(State == "Victoria",
         Industry == "Food retailing") %>%
  model(arima = ARIMA(Turnover)) %>% 
  forecast(h = "1 year") %>% 
  autoplot(aus_retail %>% 
             filter(year(Month) > 2015)) +
  theme(text = element_text(size = 20))

vic_elec %>% 
  model(regdin = ARIMA(Demand ~ Temperature))

tourism %>% 
  aggregate_key(Purpose * (State / Region),
                Trips = sum(Trips)) %>% 
  model(ets = ETS(Trips)) %>%
  reconcile(ets_adjusted = min_trace(ets)) %>%
  forecast(h = "2 years")