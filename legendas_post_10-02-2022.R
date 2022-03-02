library(ggplot2)
ToothGrowth$dose = as.factor(ToothGrowth$dose)
p = ggplot(ToothGrowth, aes(x = dose, y = len))+ 
  geom_boxplot(aes(fill = dose)) # mudando a cor de preenchimento por grupo
p
p + labs(fill = "Dose (mg)")
p + theme(legend.position = "top")
p + theme(legend.position = c(0.7, 0.2), legend.direction = "horizontal")
p + scale_fill_discrete(guide = guide_legend(reverse=TRUE))
p + theme(legend.title = element_text(color = "blue", size = 20), legend.text = element_text(color = "red", size = 15))
p + scale_x_discrete(limits=c("2", "0.5", "1"))
p + scale_fill_discrete(name = "Dose", labels = c("A", "B", "C"))
p + scale_fill_manual(values = c("#d8b365", "#f5f5f5", "#5ab4ac"))
