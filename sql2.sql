SELECT *, st_X(geom) AS longitude, st_Y(geom) AS latitude
FROM (SELECT (ST_PixelAsPoints(rast, 1)).* FROM state_raster) foo
WHERE val <> 0;