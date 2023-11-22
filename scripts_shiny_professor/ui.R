library(shiny)
library(shinyWidgets)
#inicializando os valores
gid <- 109
limit <- 100
shinyUI(fluidPage(
  titlePanel("Mapa - Passo Fundo"),
  sidebarLayout(
    sidebarPanel(    
      radioButtons("tipoPlot", "Tipo do Plot",
                   c("Ponto"="p", "Linha"="l")
      ),       
      numericInput("gid", "GID", value = gid),
      numericInput("limit", "LIMIT", value = limit)
    ),     
    mainPanel(      
      tabsetPanel(type = "tabs",                    
                  tabPanel("Tabela", dataTableOutput("saidaTabela")),
                  tabPanel("Municipios", dataTableOutput("saidaMunicipios")),
                  tabPanel("Mapa", leafletOutput("saidaMapa"))
      )            
    )
  )   
)
)