INSERT INTO flowlines (
  permanent_identifier,
  created_date,
  resolution,
  gnis_id,
  gnis_name,
  lengthkm,
  reachcode,
  flowdir,
  wbarea_permanent_identifier,
  ftype,
  fcode,
  shape_length,
  enabled,
  the_geom
) (
  SELECT
    fl.permanent_identifier,
    fl.fdate,
    fl.resolution,
    fl.gnis_id,
    fl.gnis_name,
    fl.lengthkm,
    fl.reachcode,
    fl.flowdir,
    fl.wbarea_permanent_identifier,
    fl.ftype,
    fl.fcode,
    fl.shape_length,
    fl.enabled,
    ST_Transform(fl.wkb_geometry, 900913)
  FROM
    nhdflowline fl
);
