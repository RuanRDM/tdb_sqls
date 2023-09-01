-- Instalando extenção dblink
CREATE EXTENSION dblink;

-- Crie uma conexão persistente
DO $$
BEGIN
  PERFORM dblink_connect('conexao', 'host=localhost user=postgres password=postgres dbname=tdb');
END $$;

-- Crie a tabela "paises"
CREATE TABLE paises AS
SELECT * FROM dblink('conexao', 'SELECT * FROM paises') 
AS linktable(codigo integer, descricao text);

-- Crie a tabela "estados"
CREATE TABLE estados AS
SELECT * FROM dblink('conexao', 'SELECT * FROM estados') 
AS linktable(codigo integer, descricao text, pais integer);

-- Crie a tabela "cidades"
CREATE TABLE cidades AS
SELECT * FROM dblink('conexao', 'SELECT * FROM cidades') 
AS linktable(codigo integer, descricao text, estado integer);

-- Crie a tabela "organizacoes"
CREATE TABLE organizacoes AS
SELECT * FROM dblink('conexao', 'SELECT * FROM organizacoes') 
AS linktable(codigo integer, descricao text);

-- Crie a tabela "estacoes"
CREATE TABLE estacoes AS
SELECT * FROM dblink('conexao', 'SELECT * FROM estacoes') 
AS linktable(codigo integer, descricao text, latitude double precision, longitude double precision, cidade integer, organizacao integer);

-- Crie a tabela "variaveis"
CREATE TABLE variaveis AS
SELECT * FROM dblink('conexao', 'SELECT * FROM variaveis') 
AS linktable(codigo integer, descricao text, tipo_dados integer);

-- Crie a tabela "dados"
CREATE TABLE dados AS
SELECT * FROM dblink('conexao', 'SELECT * FROM dados') 
AS linktable(codigo bigint, data date, hora time, estacao integer, variavel integer, valor text);

-- Feche a conexão persistente quando não for mais necessária
DO $$
BEGIN
  PERFORM dblink_disconnect('conexao');
END $$;