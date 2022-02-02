library(ggplot2)
midwest

ggplot(data=midwest, aes(x=percollege, y=percbelowpoverty)) +
  geom_point(aes(color=state), size=3) +
  labs(x="Percent college educated", 
       y="Percent of people below poverty line",
       title="Demographic information of midwest counties from 2000 US census") +
  facet_wrap(~state) +
  theme(legend.position="bottom",
        title=element_text(size = 15)) +
  scale_color_discrete(name="State")
