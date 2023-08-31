-- Instalando CrossTab
CREATE EXTENSION IF NOT EXISTS tablefunc;

-- Select com CrossTab
SELECT * FROM crosstab(
  'SELECT
	 d.data + d.hora,
     d.variavel,
     d.valor
   FROM 
     dados d
   ORDER BY 
     d.data + d.hora, d.variavel'
) AS ct (datahora timestamp, "Temperatura" text, "Chuva" text, "Direcao Vento" text, "Umidade" text, "Pressao" text);


-- Select com CrossTab full
SELECT * FROM crosstab(
    'SELECT 
	     d.data + d.hora,
         e.codigo AS estacao_codigo,
         e.descricao AS estacao_descricao,
         e.latitude,
         e.longitude,
         o.descricao AS organizacao_descricao,
         c.descricao AS cidade_descricao,
         es.descricao AS estado_descricao,
         p.descricao AS pais_descricao,
	 	 d.variavel,
         d.valor
       FROM 
         dados d
         JOIN estacoes e ON d.estacao = e.codigo
         JOIN cidades c ON e.cidade = c.codigo
         JOIN estados es ON c.estado = es.codigo
         JOIN paises p ON es.pais = p.codigo
         JOIN organizacoes o ON e.organizacao = o.codigo
       ORDER BY 
         d.data + d.hora',
	  'SELECT DISTINCT d.variavel FROM dados d ORDER BY d.variavel'
) AS ct (
	datahora timestamp,
    estacao_codigo int, 
    estacao_descricao text, 
    latitude double precision, 
    longitude double precision, 
    organizacao_descricao text, 
    cidade_descricao text, 
    estado_descricao text, 
    pais_descricao text, 
    "Temperatura" text, 
    "Chuva" text, 
    "Direcao Vento" text, 
    "Umidade" text, 
    "Pressao" text
);