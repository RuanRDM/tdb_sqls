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


## Gera graficos plot
plot (subset_tmin_estacao213$tmin,type="p", xlab='Dias', ylab='Tmin', main="Passo
Fundo")

## Gera graficos colunas
hist(subset_tmin_estacao213$tmin,xlab='Temperatura mínima(oC)', main='Passo Fundo')