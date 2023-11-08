library(RPostgres)
library(leaflet)
pdbbanco <- "tdb"
pdbuser <- "postgres"
pdbpassword <- "postgres"
pdbhost <- "localhost"
pdbport <- "5432"
executaConsulta <- function(sql){
con <- dbConnect(RPostgres::Postgres(), user=pdbuser,
dbname=pdbbanco,
password=pdbpassword,
host=pdbhost,port=pdbport)
rs = dbSendQuery(con,sql)
df <- dbFetch(rs)
dbClearResult(rs)
dbDisconnect(con)
return (df)
}
gerarDados_1<- function(elementos, valorInicial, valorFinal){
  x <- seq(1:elementos)
  y <- runif(elementos, valorInicial, valorFinal)  
  df <- data.frame(y,x)
  return (df)
}
gerarMapa<- function(){
  # Execute uma consulta para obter os dados do banco de dados
  query <- "SELECT *, st_X(geom) AS longitude, st_Y(geom) AS latitude
FROM (SELECT (ST_PixelAsPoints(rast, 1)).* FROM state_raster) foo
WHERE val <> 0;"
  dados <- executaConsulta(query)
  mapa <- leaflet()
  mapa <- addMarkers(map = mapa, data = dados, lat = ~latitude, lng = ~longitude, popup = ~val)
  return(dados)
}
