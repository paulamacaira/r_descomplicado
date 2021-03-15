
library(shiny)

ui <- fluidPage(
    titlePanel("Previsão dos Novos Casos de COVID-19 no Brasil"),
    fluidRow(
        column(4,
               sliderInput("previsao",
                           "Número de dias para previsão:",
                           min = 1,
                           max = 28,
                           value = 14)
        ),
        column(6, 
               checkboxGroupInput("ic", 
                                  h3("Intervalo de Confiança"), 
                                  choices = list("80%" = 80, 
                                                 "90%" = 90, 
                                                 "95%" = 95),
                                  selected = 95)),
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
    library(fable)
    library(tsibble)
    dados = read.csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv")
    colnames(dados)[-c(1:4)] = seq(as.Date("2020-01-22"), today()-1, by="days")
    dados_novos = dados %>% 
        select(!c(Province.State,Lat,Long)) %>% 
        pivot_longer(!Country.Region, names_to = "Data", values_to = "Casos") %>% 
        group_by(Country.Region,Data) %>% 
        summarise(Casos = sum(Casos)) %>% 
        filter(Country.Region == "Brazil") %>% 
        mutate(Data = as_date(as.numeric(Data)),
               Novos_Casos = Casos - lag(Casos)) %>%
        filter(Data > (today()-200)) %>% 
        as_tsibble(index = Data)
    
    output$distPlot <- renderPlot({
        fc = dados_novos  %>% 
            model(ets = ETS(Novos_Casos)) %>% 
            forecast(h = input$previsao) 
        fc %>% autoplot(dados_novos, color = "red", level = as.numeric(input$ic)) +
            theme_classic() +
            theme(legend.position = "none",
                  axis.title.y = element_blank(),
                  axis.title.x = element_blank(),
                  axis.text = element_text(size = 15))
    })
}

shinyApp(ui = ui, server = server)