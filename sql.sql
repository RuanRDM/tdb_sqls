-- CREATE EXTENSIONS
create extension postgis;
CREATE EXTENSION postgis_topology;
Create extension postgis_raster;

SET postgis.gdal_enabled_drivers = 'ENABLE_ALL';


-- CREATE TABLE
create table state_raster(
	id bigserial primary key,
	date date default current_date,
	rast raster,
	filename text);

select * from state_raster;

-- IMPORT DATA - IN FOLDER /Library/PostgreSQL/10/bin
--./raster2pgsql -s 4326 -I -M /Users/alexandretagliarilazzaretti/Lazzaretti/lixo/*.tif -F -t 200x200 -a public.state_raster | ./psql -U postgres -d BD_TBD3

select * from state_raster;


-- SELECT VALUE OF ONE POINT LAT/LON

select *, st_X(geom) as longitude, st_Y(geom) as latitude
from (SELECT (ST_PixelAsPoints(rast, 1)).* FROM state_raster WHERE id = 1) foo;

SELECT *, st_X(geom) AS longitude, st_Y(geom) AS latitude
FROM (SELECT (ST_PixelAsPoints(rast, 1)).* FROM state_raster2) foo
WHERE val <> 0;
