library(tidyverse)
library(treemap)

dados = readxl::read_excel("bbb_jogo_da_discordia_01022022.xlsx")
dados
df = data.frame(table(dados$Indicado,dados$Adjetivo))
df
colnames(df) = c("participantes","adjetivo","frequencia")
df

treemap(df, index = c("adjetivo","participantes"),
        vSize = "frequencia", type = "index",
        border.col = "white", title = "Jogo da Discórdia BBB 2022 (31/01)")
