library(RPostgres)
library(leaflet)
library(sf)
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
  query <- "SELECT
    x,
    y,
    val,
    ST_X(ST_Transform(geom, 4326))::numeric(10, 5) AS latitude,
    ST_Y(ST_Transform(geom, 4326))::numeric(10, 5) AS longitude
FROM
(select(st_pixelaspoints((    SELECT(ST_Union(ST_Clip(rast,
ST_Transform((select geom from municipios where codigo=2),
ST_SRID(rast) ) ) ) ) AS rast from state_raster	   
WHERE
ST_Intersects(rast, (select geom from municipios where codigo=2))),1)).*) r1"
  dados <- executaConsulta(query)
  return(dados)
}