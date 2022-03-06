# Gráficos de Séries Temporais

library(tidyverse)
library(tsibble)
library(fable)
library(feasts)
library(tsibbledata)
library(fpp3)

aus_production %>% 
  filter(year(Quarter) >= 1992) %>% 
  autoplot(Beer) +
  theme_minimal() +
  theme(text = element_text(size = 20))

aus_production %>% 
  filter(year(Quarter) >= 1992) %>% 
  gg_season(Beer, labels = "right") +
  theme_minimal() +
  theme(text = element_text(size = 20))

aus_production %>% 
  filter(year(Quarter) >= 1992) %>% 
  gg_subseries(Beer) +
  # theme_minimal() +
  theme(text = element_text(size = 20))

aus_production %>% 
  filter(year(Quarter) >= 1992) %>% 
  ACF(Beer, lag_max = 50) %>% 
  autoplot() +
  theme_minimal() +
  theme(text = element_text(size = 20))

# Bônus

library(ggplot2)
library(plyr)
library(scales)
library(zoo)
library(lubridate)

gafa_stock %>%
  autoplot(Temperature) +
  xlab("Week") + ylab("Max temperature")

df <- read.csv("https://raw.githubusercontent.com/selva86/datasets/master/yahoo.csv")
df$date <- as.Date(df$date)  # format date
df <- df[df$year >= 2012, ]  # filter reqd years

# Create Month Week
df$yearmonth <- as.yearmon(df$date)
df$yearmonthf <- factor(df$yearmonth)
df <- ddply(df,.(yearmonthf), transform, monthweek=1+week-min(week))  # compute week number of month
df <- df[, c("year", "yearmonthf", "monthf", "week", "monthweek", "weekdayf", "VIX.Close")]
head(df)
#>   year yearmonthf monthf week monthweek weekdayf VIX.Close
#> 1 2012   Jan 2012    Jan    1         1      Tue     22.97
#> 2 2012   Jan 2012    Jan    1         1      Wed     22.22
#> 3 2012   Jan 2012    Jan    1         1      Thu     21.48
#> 4 2012   Jan 2012    Jan    1         1      Fri     20.63
#> 5 2012   Jan 2012    Jan    2         2      Mon     21.07
#> 6 2012   Jan 2012    Jan    2         2      Tue     20.69


# Plot
ggplot(df, aes(monthweek, weekdayf, fill = VIX.Close)) + 
  geom_tile(colour = "white") + 
  facet_grid(year~monthf) + 
  scale_fill_gradient(low="red", high="green") +
  labs(x="Week of Month",
       y="",
       title = "Time-Series Calendar Heatmap", 
       subtitle="Yahoo Closing Price", 
       fill="Close")
