## definindo o diretório de trabalho
setwd("C:/Users/20191pf.cc0202/Documents/tdb_sqls")
## referenciando o arquivo com funções
source("functions.r")

## CSV
## gerando um data.frame com dados aleatórios
dados <- gerarDados(10,3.5,128.9)
## plotando um gráfico
plot(dados$y~dados$x, xlab='X', ylab='Y',
     main="Dados aleatórios gerados com funções")
## gravando os dados gerados em um arquivo
gravarTabela(dados,"dados.csv")

## IMAGEM
dados <- gerarDados(10,3.5,128.9)
## Criando a imagem
png(filename="plot.png",width = 1024, height = 768)
## plotando um gráfico
plot(dados$y~dados$x, xlab='X', ylab='Y',
main="Dados aletatórios gerados com funções")
## liberando o arquivo criado
dev.off()


## Consultar SQL
setwd("C:/Users/20191pf.cc0202/Documents/tdb_sqls")
## referenciando o arquivo com funções
source("functions.r")
consultaMunicipios(2)