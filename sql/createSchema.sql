CREATE EXTENSION IF NOT EXISTS "postgis";
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Tables and geometry from the NHD file.gdb upload using ogr2ogr
-- Table: nhdflowlines

CREATE TABLE IF NOT EXISTS flowlines (
  id uuid DEFAULT uuid_generate_v4() NOT NULL,
  permanent_identifier TEXT,
  created_date TIMESTAMP WITH TIME ZONE,
  resolution INT,
  gnis_id VARCHAR,
  gnis_name TEXT,
  lengthkm DOUBLE PRECISION,
  reachcode VARCHAR,
  flowdir INT,
  wbarea_permanent_identifier VARCHAR,
  ftype INT,
  fcode INT,
  shape_length DOUBLE PRECISION,
  enabled INT,
  the_geom geometry(MultiLineString, 900913)
);

CREATE INDEX flowlines_geom_idx ON flowlines USING gist (the_geom);

-- Table: All wbdhuc polygons
CREATE TABLE IF NOT EXISTS hydro_unit_boundaries (
  id uuid DEFAULT uuid_generate_v4() NOT NULL,
  tnm_id VARCHAR,
  meta_src_id VARCHAR,
  src_data_desc VARCHAR,
  src_originator VARCHAR,
  src_feature_id VARCHAR,
  load_date TIMESTAMP WITH TIME ZONE,
  gnis_id INT,
  area_acres DOUBLE PRECISION,
  area_sqkm DOUBLE PRECISION,
  states VARCHAR,
  hu_code VARCHAR(12),
  hu_class TEXT,
  name VARCHAR,
  hu_type VARCHAR,
  hu_mod VARCHAR,
  to_huc VARCHAR(12),
  non_contrib_acres DOUBLE PRECISION,
  non_contrib_sqkm DOUBLE PRECISION,
  the_geom geometry(MultiPolygon, 900913),
  CONSTRAINT hydro_unit_boundaries_pkey PRIMARY KEY (id)
);

CREATE INDEX hydro_unit_geom_idx ON hydro_unit_boundaries USING gist (the_geom);

-- Function: classify wdbhuc
CREATE OR REPLACE FUNCTION hu_classify(huc varchar)
  RETURNS text AS
$$
  BEGIN
    RETURN CASE
      WHEN char_length(huc) = 2 THEN 'Region'
      WHEN char_length(huc) = 4 THEN 'Subregion'
      WHEN char_length(huc) = 6 THEN 'Basin'
      WHEN char_length(huc) = 8 THEN 'Subbasin'
      WHEN char_length(huc) = 10 THEN 'Watershed'
      WHEN char_length(huc) >= 12 THEN 'Subwatershed'
      ELSE NULL
    END;
  END;
$$
LANGUAGE 'plpgsql';
