CREATE EXTENSION IF NOT EXISTS postgis;

CREATE TABLE municipios (
    codigo INTEGER NOT NULL,
    nome VARCHAR(100) NOT NULL,
    uf CHAR(2) NOT NULL,
    latitude DOUBLE PRECISION,
    longitude DOUBLE PRECISION,
    PRIMARY KEY (codigo)
);
Latitude: -28.445, Longitude: -52.209

insert into municipios values
(1,'Alegrete','RS',-29.7116,-55.5261),
(2,'Passo Fundo','RS',-28.2294,-52.4039);

insert into municipios values
(3,'Marau','RS',-28.4493,-52.1968);

select * from municipios

SELECT AddGeometryColumn( 'municipios',
'geom', 4326, 'POINT', 2);

update municipios set geom =
ST_SetSRID(ST_MakePoint(longitude,
latitude), 4326);

select st_distance
((select geom::geometry from municipios where codigo=2),
(select geom::geometry from municipios where codigo=3))