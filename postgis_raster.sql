CREATE EXTENSION postgis_topology;

SET postgis.gdal_enabled_drivers =
'ENABLE_ALL';

raster2pgsql -s 4326 -I -M *.tif -F -t
200x200 -a public.raster_data | psql -U
postgres -d agrogis_v01