-- Tabela estacao
CREATE TABLE estacao (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    data DATE NOT NULL,
    municipio VARCHAR(50) NOT NULL,
    estado VARCHAR(2) NOT NULL,
    pais VARCHAR(50) NOT NULL,
    latitude DECIMAL(9, 6) NOT NULL,
    longitude DECIMAL(9, 6) NOT NULL,
    organizacao VARCHAR(50) NOT NULL
);

-- Tabela dados_climaticos
CREATE TABLE dados_climaticos (
    id SERIAL PRIMARY KEY,
    estacao_id INT NOT NULL,
    hora TIME NOT NULL,
    temperatura DECIMAL(4, 1) NOT NULL,
    chuva INT NOT NULL,
    direcao_vento VARCHAR(10) NOT NULL,
    umidade INT NOT NULL,
    pressao INT NOT NULL,
    FOREIGN KEY (estacao_id) REFERENCES estacao(id)
);

-- Inserir valores para a primeira estação
INSERT INTO estacao (nome, data, municipio, estado, pais, latitude, longitude, organizacao)
VALUES ('A0067', '2021-02-12', 'Passo Fundo', 'RS', 'Brasil', -28.6759, -58.7908, 'INPE');

INSERT INTO dados_climaticos (estacao_id, hora, temperatura, chuva, direcao_vento, umidade, pressao)
VALUES
    (1, '01:00', 25.0, 0, 'Norte', 70, 40),
    (1, '02:00', 26.0, 0, 'Norte', 65, 45),
    (1, '03:00', 26.0, 0, 'Sul', 70, 50),
    (1, '04:00', 27.0, 0, 'Norte', 60, 60);

-- Inserir valores para a segunda estação
INSERT INTO estacao (nome, data, municipio, estado, pais, latitude, longitude, organizacao)
VALUES ('A0089', '2021-02-12', 'Marau', 'RS', 'Brasil', -29.7894, -60.7896, 'EMBRAPA');

INSERT INTO dados_climaticos (estacao_id, hora, temperatura, chuva, direcao_vento, umidade, pressao)
VALUES
    (2, '01:00', 25.9, 0, 'Norte', 70, 40),
    (2, '02:00', 26.1, 0, 'Norte', 65, 45),
    (2, '03:00', 26.1, 0, 'Sul', 70, 50),
    (2, '04:00', 27.5, 0, 'Norte', 60, 60);
	
select * from estacao
select * from dados_climaticos

-- Select associando os dados climaticos com a respectiva estação
SELECT
    e.nome AS estacao_nome,
    e.data AS data,
    e.municipio AS municipio,
    e.estado AS estado,
    e.pais AS pais,
    e.latitude AS latitude,
    e.longitude AS longitude,
    e.organizacao AS organizacao,
    dc.hora AS hora,
    dc.temperatura AS temperatura,
    dc.chuva AS chuva,
    dc.direcao_vento AS direcao_vento,
    dc.umidade AS umidade,
    dc.pressao AS pressao
FROM
    estacao e
JOIN
    dados_climaticos dc ON e.id = dc.estacao_id;
