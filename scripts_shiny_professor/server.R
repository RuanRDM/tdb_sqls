library(shiny)
setwd("C:/Users/20191pf.cc0202/Documents/tdb_sqls-1/scripts_shiny_professor")
source("functions.R")
shinyServer(function(input, output) {
      
  output$saidaMunicipios <- renderDataTable({
    dados <- gerarMunicipios() # chamada a fun????o dados
    dados
  })

  output$saidaTabela <- renderDataTable({
    nome <- input$nome
    limit <- input$limit
    dados <- gerarMapa(nome,limit) # chamada a fun????o dados
    dados
  })

  output$saidaMapa <- renderLeaflet({
    nome <- input$nome
    limit <- input$limit
    dados <- gerarMapa(nome,limit)
    mapa <- leaflet(data = dados) %>%
      setView(lng = mean(dados$longitude), lat = mean(dados$latitude), zoom = 13) %>%
      addTiles() %>%
      addCircleMarkers(lat = ~latitude, lng = ~longitude, label = ~val, radius = 5)
    mapa
  })  
})

