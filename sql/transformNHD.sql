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
    nhdflowline AS fl
);

-- Insert from wbdhu4
INSERT INTO hydro_unit_boundaries (
  tnm_id,
  meta_src_id,
  src_data_desc,
  src_originator,
  src_feature_id,
  load_date,
  gnis_id,
  area_acres,
  area_sqkm,
  states,
  hu_code,
  hu_class,
  name,
  the_geom
) (
  SELECT
    hu.tnmid,
    hu.metasourceid,
    hu.sourcedatadesc,
    hu.sourceoriginator,
    hu.sourcefeatureid,
    hu.loaddate,
    hu.gnis_id,
    hu.areaacres,
    hu.areasqkm,
    hu.states,
    hu.huc4,
    hu_classify(hu.huc4),
    hu.name,
    ST_Transform(hu.wkb_geometry, 900913)
  FROM
    wbdhu4 as hu
  WHERE hu.huc4 NOT IN (
    SELECT hu_code
    FROM hydro_unit_boundaries
  )
);

-- Insert from wbdhu6
INSERT INTO hydro_unit_boundaries (
  tnm_id,
  meta_src_id,
  src_data_desc,
  src_originator,
  src_feature_id,
  load_date,
  gnis_id,
  area_acres,
  area_sqkm,
  states,
  hu_code,
  hu_class,
  name,
  the_geom
) (
  SELECT
    hu.tnmid,
    hu.metasourceid,
    hu.sourcedatadesc,
    hu.sourceoriginator,
    hu.sourcefeatureid,
    hu.loaddate,
    hu.gnis_id,
    hu.areaacres,
    hu.areasqkm,
    hu.states,
    hu.huc6,
    hu_classify(hu.huc6),
    hu.name,
    ST_Transform(hu.wkb_geometry, 900913)
  FROM
    wbdhu6 as hu
  WHERE hu.huc6 NOT IN (
    SELECT hu_code
    FROM hydro_unit_boundaries
  )
);

-- Insert from wbdhu8
INSERT INTO hydro_unit_boundaries (
  tnm_id,
  meta_src_id,
  src_data_desc,
  src_originator,
  src_feature_id,
  load_date,
  gnis_id,
  area_acres,
  area_sqkm,
  states,
  hu_code,
  hu_class,
  name,
  the_geom
) (
  SELECT
    hu.tnmid,
    hu.metasourceid,
    hu.sourcedatadesc,
    hu.sourceoriginator,
    hu.sourcefeatureid,
    hu.loaddate,
    hu.gnis_id,
    hu.areaacres,
    hu.areasqkm,
    hu.states,
    hu.huc8,
    hu_classify(hu.huc8),
    hu.name,
    ST_Transform(hu.wkb_geometry, 900913)
  FROM
    wbdhu8 as hu
  WHERE hu.huc8 NOT IN (
    SELECT hu_code
    FROM hydro_unit_boundaries
  )
);

-- Insert from wbdhu10
INSERT INTO hydro_unit_boundaries (
  tnm_id,
  meta_src_id,
  src_data_desc,
  src_originator,
  src_feature_id,
  load_date,
  gnis_id,
  area_acres,
  area_sqkm,
  states,
  hu_code,
  hu_class,
  name,
  hu_type,
  hu_mod,
  the_geom
) (
  SELECT
    hu.tnmid,
    hu.metasourceid,
    hu.sourcedatadesc,
    hu.sourceoriginator,
    hu.sourcefeatureid,
    hu.loaddate,
    hu.gnis_id,
    hu.areaacres,
    hu.areasqkm,
    hu.states,
    hu.huc10,
    hu_classify(hu.huc10),
    hu.name,
    hu.hutype,
    hu.humod,
    ST_Transform(hu.wkb_geometry, 900913)
  FROM
    wbdhu10 as hu
  WHERE hu.huc10 NOT IN (
    SELECT hu_code
    FROM hydro_unit_boundaries
  )
);

-- Insert from wbdhu12
INSERT INTO hydro_unit_boundaries (
  tnm_id,
  meta_src_id,
  src_data_desc,
  src_originator,
  src_feature_id,
  load_date,
  gnis_id,
  area_acres,
  area_sqkm,
  states,
  hu_code,
  hu_class,
  name,
  hu_type,
  hu_mod,
  to_huc,
  non_contrib_acres,
  non_contrib_sqkm,
  the_geom
) (
  SELECT
    hu.tnmid,
    hu.metasourceid,
    hu.sourcedatadesc,
    hu.sourceoriginator,
    hu.sourcefeatureid,
    hu.loaddate,
    hu.gnis_id,
    hu.areaacres,
    hu.areasqkm,
    hu.states,
    hu.huc12,
    hu_classify(hu.huc12),
    hu.name,
    hu.hutype,
    hu.humod,
    hu.tohuc,
    hu.noncontributingacres,
    hu.noncontributingsqkm,
    ST_Transform(hu.wkb_geometry, 900913)
  FROM
    wbdhu12 as hu
  WHERE hu.huc12 NOT IN (
    SELECT hu_code
    FROM hydro_unit_boundaries
  )
);
