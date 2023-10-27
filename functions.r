## função que gera um data.frame com dados aleatórios
gerarDados<- function(elementos, valorInicial, valorFinal){
x <- seq(1:elementos)
y <- runif(elementos, valorInicial, valorFinal)
df <- data.frame(y,x)
return (df)
}

## função que grava um data.frame em um arquivo texto
gravarTabela<-function(df,nomeArquivo){
write.table(x=df, file=nomeArquivo, quote=FALSE,
sep=";",row.names = FALSE)
}


### Função sql
consultaMunicipios<-function(id){
    library(DBI)
    library(RPostgres)
    con <- dbConnect(RPostgres::Postgres(),
                    user="postgres",password="postgres",dbname="tdb",
                     host='localhost', port=5432)
    sql = paste("select * from municipios where codigo =", id, ";")
    rs = dbSendQuery(con,sql)
    df = dbFetch(rs)
    dbClearResult(rs)
    dbDisconnect(con)
    df
}


criaGraficos<-function(){
    # Ler os dados
    dados <- read.table("dados_estacoes.csv", header=TRUE, sep=";")
    # Criar subsets para tmin, tmax e precip para estação 49

    subset_tmin_estacao49 <- subset(dados, estacao %in% c(49) & !is.na(tmin), select=c(estacao, data, tmin))
    subset_tmax_estacao49 <- subset(dados, estacao %in% c(49) & !is.na(tmax), select=c(estacao, data, tmax))
    subset_precip_estacao49 <- subset(dados, estacao %in% c(49) & precip > 0, select=c(estacao, data, precip))
    
    # Criar subsets para tmin, tmax e precip para estação 213
    subset_tmin_estacao213 <- subset(dados, estacao %in% c(213) & !is.na(tmin), select=c(estacao, data, tmin))
    subset_tmax_estacao213 <- subset(dados, estacao %in% c(213) & !is.na(tmax), select=c(estacao, data, tmax))
    subset_precip_estacao213 <- subset(dados, estacao %in% c(213) & precip > 0, select=c(estacao, data, precip))

    png(filename="graficos.png",width = 1024, height = 768)
    ### Grafico 213
    x<-seq(1:40)
    y<-seq(1:40)
    plot (x,y,type='n', xlab='Dias',
          ylab='Temperatura (oC)/Precipitação', main="Passo Fundo")
    points(subset_tmax_estacao213$tmax, col='blue', pch=19, lwd=8)
    points(subset_tmin_estacao213$tmin, col='red', pch=19, lwd=8)
    points(subset_precip_estacao213$precip , col='green', pch=19, lwd=8)
    
    # Adiciona legenda ao gráfico
    legend("topright", legend = c("Temperatura
    Máxima","Temperatura Mínima", "Precipitação"),cex=0.5,
           pch=c(19,19), col=c('blue','red', 'green'))
    
    ### Grafico 49
    x<-seq(1:40)
    y<-seq(1:40)
    plot (x,y,type='n', xlab='Dias',
          ylab='Temperatura (oC)/Precipitação', main="Passo Fundo")
    points(subset_tmax_estacao49$tmax, col='blue', pch=19, lwd=8)
    points(subset_tmin_estacao49$tmin, col='red', pch=19, lwd=8)
    points(subset_precip_estacao49$precip , col='green', pch=19, lwd=8)
    
    # Adiciona legenda ao gráfico
    legend("topright", legend = c("Temperatura
    Máxima","Temperatura Mínima", "Precipitação"),cex=0.5,
           pch=c(19,19), col=c('blue','red', 'green'))

    # Configurando o layout da janela gráfica
    par(mfrow = c(linhas, colunas))
    ## liberando o arquivo criado
    dev.off()  
}