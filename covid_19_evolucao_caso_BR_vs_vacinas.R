library(tidyverse)
library(lubridate)
library(zoo)

options(scipen=10000)

corona = read_csv("https://raw.githubusercontent.com/wcota/covid19br/master/cases-brazil-states.csv") %>% 
  filter(date < today() - 1)

corona$newCases[which(corona$newCases < 0)] = 0

corona = corona %>%
  group_by(state) %>% 
  mutate(MM7casos = rollmean(newCases, k = 7, fill = NA,align = "right"),
         populacao = totalCases*100000/totalCases_per_100k_inhabitants,
         vaccinated1st_per_population = vaccinated/populacao*100)

corona %>% 
  filter(state == "TOTAL") %>% 
  mutate(vaccinated1st_per_population = vaccinated1st_per_population*2000,
         vaccinated_second_per_100_inhabitants = vaccinated_second_per_100_inhabitants*2000) %>%
  ggplot(aes(x = date)) +
  geom_vline(xintercept = date("2021-06-22"), color = "black", alpha=0.9, linetype = "dashed") +
  geom_line(aes(y = newCases), color = "grey", alpha=0.9) +
  geom_line(aes(y = MM7casos), color = "black", size = 1) +
  geom_line(aes(y = vaccinated1st_per_population), color = "#00BA38", size = 1) +
  geom_line(aes(y = vaccinated_second_per_100_inhabitants), color = "tomato", size = 1) +
  scale_y_continuous(name = "Daily cases (moving average)",
                     sec.axis = sec_axis(~./2000, name="Vaccinated 1st and 2nd dose (% population)")) +
  theme_bw() + 
  annotate(geom = "text", x = date("2020-02-01"), y = 125000, label = "Vaccinated 1st dose (% population)", hjust = "left", color = "#00BA38") +
  annotate(geom = "text", x = date("2020-02-01"), y = 120000, label = "Vaccinated 2nd dose (% population)", hjust = "left", color = "tomato") +
  theme(axis.title.x = element_blank()) +
  labs(title = "Daily cases vs population vaccinated with 1st and 2nd dose", subtitle = "Brazil") +
  geom_text(aes(x = date("2021-06-22"), y = 120000, angle = 90, vjust = -0.5, hjust = 0.5, label = "2021-06-22"), size = 4) +
  annotate(geom = "curve", x = date("2021-08-15"), y = 75000, 
           xend = date("2021-06-25"), yend = 31.26*2000,
           curvature = 0, arrow = arrow(length = unit(2, "mm")), 
           size = .1, color = "#00BA38", alpha = 0.8) +
  annotate(geom = "text", x = date("2021-08-18"), y = 75000, label = "31.26%", hjust = "left", color = "#00BA38") +
  annotate(geom = "point", x = date("2021-06-22"), y = 31.26*2000, color = "#00BA38", size = 2) +
  annotate(geom = "curve", x = date("2021-08-15"), y = 10000, 
           xend = date("2021-06-25"), yend = 11.59*2000,
           curvature = 0, arrow = arrow(length = unit(2, "mm")), 
           size = .1, color = "tomato", alpha = 0.8) +
  annotate(geom = "text", x = date("2021-08-18"), y = 10000, label = "11.59%", hjust = "left", color = "tomato") +
  annotate(geom = "point", x = date("2021-06-22"), y = 11.59*2000, color = "tomato", size = 2)
