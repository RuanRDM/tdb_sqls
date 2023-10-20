setwd("C:/Users/20191pf.cc0202/Downloads")
dados<-read.table("dados.csv",header=TRUE,sep=";")
dados

# Definir o diretório de trabalho
setwd("C:/Users/20191pf.cc0202/Downloads")

# Ler os dados do arquivo "dados.csv"
dados <- read.table("dados.csv", header=TRUE, sep=";")

# Criar subsets para tmin, tmax e precip para estação 49
subset_tmin_estacao49 <- subset(dados, estacao %in% c(49) & !is.na(tmin), select=c(estacao, data, tmin))
subset_tmax_estacao49 <- subset(dados, estacao %in% c(49) & !is.na(tmax), select=c(estacao, data, tmax))
subset_precip_estacao49 <- subset(dados, estacao %in% c(49) & precip > 0, select=c(estacao, data, precip))

# Criar subsets para tmin, tmax e precip para estação 213
subset_tmin_estacao213 <- subset(dados, estacao %in% c(213) & !is.na(tmin), select=c(estacao, data, tmin))
subset_tmax_estacao213 <- subset(dados, estacao %in% c(213) & !is.na(tmax), select=c(estacao, data, tmax))
subset_precip_estacao213 <- subset(dados, estacao %in% c(213) & precip > 0, select=c(estacao, data, precip))

plot (subset_tmin_estacao213$tmin,type="p", xlab='Dias', ylab='Tmin', main="Passo
Fundo")

hist(subset_tmin_estacao213$tmin,xlab='Temperatura mínima(oC)', main='Passo Fundo')
hist(subset_tmin_estacao49$tmin,xlab='Temperatura mínima(oC)', main='Passo Fundo')

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

#comando para limpar os graficos
dev.off()

## Grafico Bloxplot
boxplot(dados$tmin~dados$estacao,ylab="TMin
",xlab="Estacoes")

boxplot(dados$tmax ~ dados$estacao, ylab = "TMax", xlab = "Estações", col = "lightblue")
