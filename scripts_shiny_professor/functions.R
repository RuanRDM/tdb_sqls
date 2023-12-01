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
gerarMapa<- function(nome,limit){
  # Execute uma consulta para obter os dados do banco de dados
  query <- sprintf("SELECT x,y,val,st_X(geom) as longitude,st_Y(geom) as latitude
FROM
(select(st_pixelaspoints((    SELECT(ST_Union(ST_Clip(rast,
ST_Transform((select geom from municipios_ibge where nome='%s'),
ST_SRID(rast) ) ) ) ) AS rast from state_raster2	   
WHERE
ST_Intersects(rast, (select geom from municipios_ibge where nome='%s'))),1)).*) r1
LIMIT %s",nome,nome,limit)

  dados <- executaConsulta(query)
  return(dados)
}
gerarMunicipios<- function(gid,limit){
  # Execute uma consulta para obter os dados do banco de dados
  query <- "select gid,nome from municipios_ibge"

  dados <- executaConsulta(query)
  return(dados)
}