
library(shiny)

ui <- fluidPage(
    titlePanel("Evolução dos Novos Casos de COVID-19 no Brasil"),
    fluidRow(
        column(12,
            sliderInput("media_movel",
                        "Número de dias para média móvel:",
                        min = 0,
                        max = 50,
                        value = 14)
        ),
        hr(),
        plotOutput("distPlot")
    )
)

server <- function(input, output) {
    library(dplyr)
    library(tidyverse)
    library(lubridate)
    library(ggplot2)
    library(zoo)
    dados = read.csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv")
    colnames(dados)[-c(1:4)] = seq(as.Date("2020-01-22"), today()-1, by="days")
    dados_novos = dados %>% 
        select(!c(Province.State,Lat,Long)) %>% 
        pivot_longer(!Country.Region, names_to = "Data", values_to = "Casos") %>% 
        group_by(Country.Region,Data) %>% 
        summarise(Casos = sum(Casos)) %>% 
        filter(Country.Region == "Brazil")
    
    output$distPlot <- renderPlot({
        dados_novos %>% 
            mutate(Data = as_date(as.numeric(Data)),
                   Novos_Casos = Casos - lag(Casos),
                   MM7dias = rollmean(Novos_Casos, k = input$media_movel, fill = NA, align = "right")) %>%
            ggplot(aes(x = Data)) +
            geom_line(aes(y = Novos_Casos),color="grey70") +
            geom_line(aes(y = MM7dias),color="red") +
            theme_classic() +
            theme(axis.title.y = element_blank(),
                  axis.title.x = element_blank(),
                  axis.text = element_text(size = 15))
    })
}

shinyApp(ui = ui, server = server)
