install.packages("fable")
library(fable)

library(tsibbledata)
aus_retail

aus_retail %>%
  filter(State == "Victoria",
         Industry == "Food retailing") %>%
  model(ets = ETS(Turnover)) %>% 
  forecast(h = "1 year")

aus_retail %>%
  filter(State == "Victoria",
         Industry == "Food retailing") %>%
  model(arima = ARIMA(Turnover)) %>% 
  forecast(h = "1 year") %>% 
  autoplot(aus_retail)

vic_elec %>% 
  model(regdin = ARIMA(Demand ~ Temperature))

tsibble::tourism %>% 
  aggregate_key(Purpose * (State / Region),
                Trips = sum(Trips)) %>% 
  model(ets = ETS(Trips)) %>%
  reconcile(ets_adjusted = min_trace(ets)) %>%
  forecast(h = "2 years")

