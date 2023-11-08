library(shiny)
setwd("C:/Users/20191pf.cc0202/Documents/tdb_sqls/scripts_shiny_professor")
source("functions.R")
shinyServer(function(input, output) {  
  ## fun????o chamada cada vez que ocorre uma mudan??a na tela
  dados <- reactive({
    elementos <- input$elementos
    valorInicial <- input$valorInicial
    valorFinal <- input$valorFinal
    
    gerarDados_1(elementos,valorInicial,valorFinal)
  })    
  output$saidaPlot <- renderPlot({
    tipoPlot <- input$tipoPlot
    dados <- dados() # chamada a fun????o dados
    plot(dados$y~dados$x, xlab = "Elementos", ylab = "Valores",
         main="Grafico com geracao de dados aleatorios",type=tipoPlot)    
  })  
  output$saidaTabela <- renderDataTable({
    dados <- dados() # chamada a fun????o dados
    dados
  })

  output$saidaMapa <- renderLeaflet({
    a=gerarMapa()
    a
  })  
})