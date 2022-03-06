# componentes

library(tidyverse)
library(tsibble)
library(fable)
library(feasts)
library(tsibbledata)
library(fpp3)

dcmp = vic_elec %>%
  model(STL(Demand ~ season(window = 7))) %>%
  components()
dcmp

autoplot(dcmp) + xlab("Year") +
  theme(text = element_text(size = 14))

tourism %>% features(Trips, feat_stl)

tourism %>% features(Trips, feat_stl) %>%
  ggplot(aes(x = trend_strength, y = seasonal_strength_year, col = Purpose)) +
  geom_point(size = 3) + facet_wrap(vars(State)) +
  # theme_minimal() +
  theme(text = element_text(size = 20),
        legend.position = "top")
  
most_seasonal = tourism %>%
  features(Trips, feat_stl) %>%
  filter(seasonal_strength_year == max(seasonal_strength_year))

tourism %>%
  right_join(most_seasonal, by = c("State", "Region", "Purpose")) %>%
  ggplot(aes(x = Quarter, y = Trips)) + geom_line(size = 2) +
  facet_grid(vars(State, Region, Purpose)) +
  theme(text = element_text(size = 20))

most_trended = tourism %>%
  features(Trips, feat_stl) %>%
  filter(trend_strength == max(trend_strength))

tourism %>%
  right_join(most_trended, by = c("State", "Region", "Purpose")) %>%
  ggplot(aes(x = Quarter, y = Trips)) + geom_line(size = 2) +
  facet_grid(vars(State, Region, Purpose)) +
  theme(text = element_text(size = 20))
