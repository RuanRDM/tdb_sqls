-- Tabela de países
CREATE TABLE paises (
    codigo integer NOT NULL PRIMARY KEY,
    descricao text NOT NULL
);

-- Tabela de estados
CREATE TABLE estados (
    codigo integer NOT NULL PRIMARY KEY,
    descricao text NOT NULL,
    pais integer NOT NULL REFERENCES paises(codigo)
);

-- Tabela de cidades
CREATE TABLE cidades (
    codigo integer NOT NULL PRIMARY KEY,
    descricao text NOT NULL,
    estado integer NOT NULL REFERENCES estados(codigo)
);

-- Tabela de organizações
CREATE TABLE organizacoes (
    codigo integer NOT NULL PRIMARY KEY,
    descricao text NOT NULL
);

-- Tabela de estações
CREATE TABLE estacoes (
    codigo integer NOT NULL PRIMARY KEY,
    descricao text NOT NULL,
    latitude double precision NOT NULL,
    longitude double precision NOT NULL,
    cidade integer NOT NULL REFERENCES cidades(codigo),
    organizacao integer NOT NULL REFERENCES organizacoes(codigo)
);

-- Tabela de variáveis
CREATE TABLE variaveis (
    codigo integer NOT NULL PRIMARY KEY,
    descricao text NOT NULL,
    tipo_dados integer NOT NULL,
    CHECK (tipo_dados IN (1, 2, 3, 4, 5))
);

-- Tabela de dados
CREATE TABLE dados (
    codigo bigint NOT NULL PRIMARY KEY,
    data date NOT NULL,
    hora time,
    estacao integer NOT NULL REFERENCES estacoes(codigo),
    variavel integer NOT NULL REFERENCES variaveis(codigo),
    valor text NOT NULL
);

-- Inserindo dados na tabela paises
INSERT INTO paises (codigo, descricao) VALUES
(1, 'Brasil'),
(2, 'Estados Unidos'),
(3, 'França');

-- Inserindo dados na tabela estados
INSERT INTO estados (codigo, descricao, pais) VALUES
(1, 'São Paulo', 1),
(2, 'Califórnia', 2),
(3, 'Île-de-France', 3);

-- Inserindo dados na tabela cidades
INSERT INTO cidades (codigo, descricao, estado) VALUES
(1, 'São Paulo', 1),
(2, 'Los Angeles', 2),
(3, 'Paris', 3);

-- Inserindo dados na tabela organizacoes
INSERT INTO organizacoes (codigo, descricao) VALUES
(1, 'Empresa A'),
(2, 'Empresa B');

-- Inserindo dados na tabela estacoes
INSERT INTO estacoes (codigo, descricao, latitude, longitude, cidade, organizacao) VALUES
(1, 'Estação 1', -23.550520, -46.633308, 1, 1),
(2, 'Estação 2', 34.052235, -118.243683, 2, 2);

-- Inserindo dados na tabela variaveis
INSERT INTO variaveis (codigo, descricao, tipo_dados) VALUES
(1, 'Temperatura', 1),
(2, 'Pressão', 2),
(3, 'Umidade', 1);

-- Inserindo dados na tabela dados
INSERT INTO dados (codigo, data, hora, estacao, variavel, valor) VALUES
(1, '2023-08-23', '12:00:00', 1, 1, '25.5'),
(2, '2023-08-23', '12:00:00', 2, 2, '1013'),
(3, '2023-08-23', '12:00:00', 1, 3, '60');


-- Select associando os dados climaticos com todos as tabelas
SELECT
    d.codigo AS dado_codigo,
    d.data,
    d.hora,
    e.codigo AS estacao_codigo,
    e.descricao AS estacao_descricao,
    e.latitude,
    e.longitude,
    c.codigo AS cidade_codigo,
    c.descricao AS cidade_descricao,
    es.codigo AS estado_codigo,
    es.descricao AS estado_descricao,
    p.codigo AS pais_codigo,
    p.descricao AS pais_descricao,
    v.codigo AS variavel_codigo,
    v.descricao AS variavel_descricao,
    CASE
        WHEN v.tipo_dados = 1 THEN 'Double'
        WHEN v.tipo_dados = 2 THEN 'Integer'
        WHEN v.tipo_dados = 3 THEN 'Text'
        WHEN v.tipo_dados = 4 THEN 'Date'
        WHEN v.tipo_dados = 5 THEN 'Time'
    END AS tipo_dados_descricao,
    d.valor
FROM
    dados d
JOIN
    estacoes e ON d.estacao = e.codigo
JOIN
    cidades c ON e.cidade = c.codigo
JOIN
    estados es ON c.estado = es.codigo
JOIN
    paises p ON es.pais = p.codigo
JOIN
    variaveis v ON d.variavel = v.codigo;
