CREATE EXTENSION IF NOT EXISTS "postgis";
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Tables and geometry from the NHD file.gdb upload using ogr2ogr

  -- ogc_fid serial NOT NULL,
  -- wkb_geometry geometry(MultiLineString,4269),
  -- permanent_identifier character varying,
  -- fdate timestamp with time zone,
  -- resolution integer,
  -- gnis_id character varying,
  -- gnis_name character varying,
  -- lengthkm double precision,
  -- reachcode character varying,
  -- flowdir integer,
  -- wbarea_permanent_identifier charVARCHARr varying,
  -- ftype integer,
  -- fcode integer,
  -- shape_length double precision,
  -- enabled integer,
  -- CONSTRAINT nhdflowline_pkey PRIMARY KEY (ogc_fid)

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
