
library(srvyr)

dados = read.csv("PNAD_COVID_112020\\PNAD_COVID_112020.csv")

dados_novos = dados %>%
  as_survey_design(ids = UPA, strata = Estrato, weights = V1032, nest = TRUE)

# Estimando Totais

dados_novos %>% 
  group_by(UF) %>%
  summarise(Testes = survey_total(B008 == 1))

# Estimando Médias

dados_novos %>% 
  group_by(UF) %>% 
  summarise(Idade = survey_mean(A002))

# Estimando Proporções

dados_novos %>% 
  group_by(UF) %>% 
  summarise(Mulher = survey_mean(A003 == 2))

# Estimação para domínios

dados_novos %>% 
  group_by(UF) %>% 
  filter(A003 == 2) %>% 
  summarise(Idade_Mulher = survey_mean(A002))

# Estimando Totais

dados_novos %>% 
  group_by(UF) %>% 
  summarise(Testes = survey_total(B008 == 1, vartype = c("ci")))
