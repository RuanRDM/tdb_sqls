library(shiny)
setwd("C:/Users/20191pf.cc0202/Documents/tdb_sqls/scripts_shiny_professor")
source("functions.R")
shinyServer(function(input, output) {
      
  output$saidaMunicipios <- renderDataTable({
    dados <- gerarMunicipios() # chamada a fun????o dados
    dados
  })

  output$saidaTabela <- renderDataTable({
    gid <- input$gid
    limit <- input$limit
    dados <- gerarMapa(gid,limit) # chamada a fun????o dados
    dados
  })

  output$saidaMapa <- renderLeaflet({
    gid <- input$gid
    limit <- input$limit
    dados <- gerarMapa(gid,limit)
    mapa <- leaflet(data = dados) %>%
      setView(lng = mean(dados$longitude), lat = mean(dados$latitude), zoom = 13) %>%
      addTiles() %>%
      addMarkers(lat = ~latitude, lng = ~longitude, popup = ~val)
    mapa
  })  
})

