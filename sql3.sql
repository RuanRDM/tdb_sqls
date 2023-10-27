select * from raster_data where id=1;
select * from shape_file;
select * from shape_file where id=6

select * from municipios_ibge where gid=109
select * from municipios where codigo=2
-- CONSULTA QUE RETORNA OS DADOS DE UMA FORMA
SELECT x,y,val,st_X(geom) as latitude,st_Y(geom) as longitude
FROM
(select(st_pixelaspoints((    SELECT(ST_Union(ST_Clip(rast,
ST_Transform((select geom from municipios where codigo=2),
ST_SRID(rast) ) ) ) ) AS rast from state_raster	   
WHERE
ST_Intersects(rast, (select geom from municipios where codigo=2))),1)).*) r1

-- CONSULTA QUE RETORNA OS DADOS DE UMA COORDENANA
SELECT st_value(rast,st_setsrid(st_makepoint(-52,-28),4326))
FROM state_raster
WHERE ST_Intersects(rast,
st_setsrid(st_makepoint(-52,-28),4326));