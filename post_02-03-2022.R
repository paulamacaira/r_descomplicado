# Introdução a tsibble e alguns gráficos úteis

library(tidyverse)
library(tsibble)
library(fable)
library(feasts)
library(tsibbledata)
library(fpp3)

global_economy
mydata = tsibble(year = 1990:2021,
                 y = rnorm(32),
                 index = year)
mydata

usando_df = data.frame(year = 1990:2021,
                       y = rnorm(32))
as_tsibble(usando_df, index = year)

AirPassengers
as_tsibble(AirPassengers)
