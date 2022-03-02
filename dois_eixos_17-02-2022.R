library(tidyverse)

data = data.frame(day = as.Date("2019-01-01") + 0:99,
  temperature = runif(100) + seq(1,100)^2.5 / 10000,
  price = runif(100) + seq(100,1)^1.5 / 10)
data

ggplot(data, aes(x=day, y=temperature)) +
  geom_line(color="darkgreen", size=2) +
  ggtitle("Temperature: range 1-10") +
  theme_bw()

ggplot(data, aes(x=day, y=price)) +
  geom_line(color="tomato",size=2) +
  ggtitle("Price: range 1-100") +
  theme_bw()

ggplot(data, aes(x=day, y=temperature)) +
  scale_y_continuous(name = "First Axis",
    sec.axis = sec_axis(trans=~.*10, name="Second Axis")) +
  theme_bw()

coeff = 10

ggplot(data, aes(x=day)) +
  geom_line(aes(y=temperature),color="darkgreen", size=2) + 
  geom_line(aes(y=price / coeff),color="tomato",size=2) +
  scale_y_continuous(name = "Temperature: range 1-10",
                     sec.axis = sec_axis(~.*coeff, name="Price: range 1-100")) +
  theme_bw()+
  theme(axis.title.y = element_text(color = "darkgreen"),
        axis.title.y.right = element_text(color = "tomato"))