# carregando pacotes
library(dplyr)
library(ggplot2)
library(readr)
library(lubridate)

# importanto o dataset do Github como um tibble (pacote tibble)
dados = read_csv("https://raw.githubusercontent.com/wcota/covid19br/master/cases-brazil-states.csv")
dados

# gerando o gráfico com o {ggplot2}
dados %>%
  mutate(newDeaths=case_when(newDeaths<0~0,TRUE~newDeaths),
         newCases=case_when(newCases<0~0,TRUE~newCases))%>%
  filter(state=="TOTAL") %>%
  group_by(date) %>%
  summarise(newDeaths=sum(newDeaths),
            newCases=sum(newCases),
            deaths_by_cases=newDeaths/newCases) -> dados_novo
  
ggplot(dados_novo, aes(x=date,y=deaths_by_cases)) +
  geom_line(color="tomato",alpha=0.4) +
  geom_vline(xintercept=as_date("2021-01-17") ,
             linetype="dashed",color="gray50") +
  geom_text(aes(x=as_date("2021-01-10"),y=0.07),
            label="1º dia de vacinação",angle=90,
            color="gray50") +
  geom_smooth(color="tomato",se=FALSE) +
  theme_minimal() +
  theme(axis.title.x=element_blank()) +
  labs(y="Óbitos/Casos",
       title="Letalidade COVID-19 no Brasil")

ggsave("grafico_anatomia_29_01_2022.png", units = "px", width = 1080+1000, height = 1080, dpi = 300, limitsize = FALSE)
