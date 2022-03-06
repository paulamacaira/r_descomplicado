library(tidyverse)
library(tsibble)
library(fable)
library(feasts)
library(tsibbledata)
library(fpp3)
library(patchwork)

p1 = aus_production %>% 
  filter(year(Quarter) < 2001) %>% 
  select(Bricks) %>% 
  autoplot(Bricks)

p2 = aus_production %>% 
  filter(year(Quarter) < 2001) %>% 
  select(Bricks) %>% 
  ACF(Bricks, lag_max = 50) %>% 
  autoplot()
p1 / p2



p1 = aus_production %>% 
  filter(year(Quarter) < 2001) %>% 
  select(Bricks) %>% 
  mutate(Bricks = difference(Bricks, order_by = Quarter)) %>% 
  autoplot(Bricks)

p2 = aus_production %>% 
  filter(year(Quarter) < 2001) %>% 
  select(Bricks) %>% 
  mutate(Bricks = difference(Bricks, order_by = Quarter)) %>% 
  ACF(Bricks, lag_max = 50) %>% autoplot()
p1 / p2
