library(shiny)
setwd("C:/Users/20191pf.cc0202/Documents/tdb_sqls/scripts_shiny_completo_professor")
#inicializando os valores
estacao <- 49
variavel<-"tmin"
shinyUI(fluidPage(
titlePanel("Hello Shiny ex03!"),
sidebarLayout(
sidebarPanel(
uiOutput('selectLocais'),
uiOutput('selectVariavel'),
width = 3
),
mainPanel(
tabsetPanel(type = "tabs",
tabPanel("Plot", plotOutput("saidaPlot"))
)
)
)
))