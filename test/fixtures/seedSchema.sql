CREATE EXTENSION IF NOT EXISTS "postgis";
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

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

CREATE TABLE IF NOT EXISTS nhdflowline (
  ogc_fid serial NOT NULL,
  wkb_geometry geometry(MultiLineString,4269),
  permanent_identifier character varying,
  fdate timestamp with time zone,
  resolution integer,
  gnis_id character varying,
  gnis_name character varying,
  lengthkm double precision,
  reachcode character varying,
  flowdir integer,
  wbarea_permanent_identifier character varying,
  ftype integer,
  fcode integer,
  shape_length double precision,
  enabled integer
);

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

CREATE TABLE IF NOT EXISTS wbdhu4 (
  ogc_fid serial NOT NULL,
  wkb_geometry geometry(MultiPolygon,4269),
  tnmid character varying,
  metasourceid character varying,
  sourcedatadesc character varying,
  sourceoriginator character varying,
  sourcefeatureid character varying,
  loaddate timestamp with time zone,
  gnis_id integer,
  areaacres double precision,
  areasqkm double precision,
  states character varying,
  huc4 character varying,
  name character varying,
  shape_length double precision,
  shape_area double precision,
  CONSTRAINT wbdhu4_pkey PRIMARY KEY (ogc_fid)
);

CREATE TABLE IF NOT EXISTS wbdhu6 (
  ogc_fid serial NOT NULL,
  wkb_geometry geometry(MultiPolygon,4269),
  tnmid character varying,
  metasourceid character varying,
  sourcedatadesc character varying,
  sourceoriginator character varying,
  sourcefeatureid character varying,
  loaddate timestamp with time zone,
  gnis_id integer,
  areaacres double precision,
  areasqkm double precision,
  states character varying,
  huc6 character varying,
  name character varying,
  shape_length double precision,
  shape_area double precision,
  CONSTRAINT wbdhu6_pkey PRIMARY KEY (ogc_fid)
);

CREATE TABLE IF NOT EXISTS wbdhu8 (
  ogc_fid serial NOT NULL,
  wkb_geometry geometry(MultiPolygon,4269),
  tnmid character varying,
  metasourceid character varying,
  sourcedatadesc character varying,
  sourceoriginator character varying,
  sourcefeatureid character varying,
  loaddate timestamp with time zone,
  gnis_id integer,
  areaacres double precision,
  areasqkm double precision,
  states character varying,
  huc8 character varying,
  name character varying,
  shape_length double precision,
  shape_area double precision,
  CONSTRAINT wbdhu8_pkey PRIMARY KEY (ogc_fid)
);

CREATE TABLE IF NOT EXISTS wbdhu10 (
  ogc_fid serial NOT NULL,
  wkb_geometry geometry(MultiPolygon,4269),
  tnmid character varying,
  metasourceid character varying,
  sourcedatadesc character varying,
  sourceoriginator character varying,
  sourcefeatureid character varying,
  loaddate timestamp with time zone,
  gnis_id integer,
  areaacres double precision,
  areasqkm double precision,
  states character varying,
  huc10 character varying,
  name character varying,
  hutype character varying,
  humod character varying,
  shape_length double precision,
  shape_area double precision,
  CONSTRAINT wbdhu10_pkey PRIMARY KEY (ogc_fid)
);

CREATE TABLE IF NOT EXISTS wbdhu12 (
  ogc_fid serial NOT NULL,
  wkb_geometry geometry(MultiPolygon,4269),
  tnmid character varying,
  metasourceid character varying,
  sourcedatadesc character varying,
  sourceoriginator character varying,
  sourcefeatureid character varying,
  loaddate timestamp with time zone,
  gnis_id integer,
  areaacres double precision,
  areasqkm double precision,
  states character varying,
  huc12 character varying,
  name character varying,
  hutype character varying,
  humod character varying,
  tohuc character varying,
  noncontributingacres double precision,
  noncontributingsqkm double precision,
  shape_length double precision,
  shape_area double precision,
  CONSTRAINT wbdhu12_pkey PRIMARY KEY (ogc_fid)
);

INSERT INTO nhdflowline (
  ogc_fid,
  wkb_geometry,
  permanent_identifier,
  fdate,
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
  enabled
)
VALUES
  (74,ST_GeomFromText('MULTILINESTRING((-108.66099827511 38.6271120733763,-108.660667408444 38.6273780067093))', 4269),'75548337','2012-02-18 09:28:14-07',2,'','',0.041,'14020005000820',1,'75548125',558,55800,0.000424491800109763,1),
  (75,ST_GeomFromText('MULTILINESTRING((-108.659778275112 38.636302873362,-108.659461275112 38.6366208733616))', 4269),'75548331','2012-02-18 09:26:54-07',2,'','',0.045,'14020005000821',1,'75548119',558,55800,0.000449013362138657,1),
  (83,ST_GeomFromText('MULTILINESTRING((-108.65039340846 38.6701778733095,-108.65004520846 38.6705452733089,-108.649832275127 38.670684806642))', 4269),'75548297','2012-02-18 09:27:40-07',2,'','',0.075,'14020005000814',1,'75548077',558,55800,0.000760766098854261,1),
  (1042,ST_GeomFromText('MULTILINESTRING((-108.157106785267 38.4576246715561,-108.156046409227 38.4588514069708,-108.155145342562 38.4606586736347,-108.155227209228 38.4612851403004))', 4269),'167903696','2012-02-18 09:38:52-07',2,'','',0.453,'14020006005736',1,'',460,46007,0.00427273678962002,1),
  (1411,ST_GeomFromText('MULTILINESTRING((-108.000622276135 38.729749273217,-108.001005009468 38.7300520065498))', 4269),'75551869','2012-02-18 09:31:13-07',2,'','',0.047,'14020005002190',1,'',460,46003,0.000487987986326096,1);

INSERT INTO wbdhu4 (
  ogc_fid,
  wkb_geometry,
  tnmid,
  metasourceid,
  sourcedatadesc,
  sourceoriginator,
  sourcefeatureid,
  loaddate,
  areaacres,
  areasqkm,
  states,
  huc4,
  name,
  shape_length,
  shape_area
)
VALUES
  (3,ST_GeomFromText('MULTIPOLYGON(((-105.845363645106 40.4826511840378,-105.844728296148 40.4826452798711,-105.843969985733 40.4827457277876,-105.843625286775 40.4827904246626,-105.842605268026 40.4829454954957,-105.842151403444 40.4830964423704,-105.845363645106 40.4826511840378)))', 4269),'{30AA0342-4EDA-487D-90D0-DE39A38E1313}','','','','','2012-06-11 07:54:59-06',6297628,25485.62,'CO','1401','Colorado Headwaters',13.2936424215745,2.67165955758456);

INSERT INTO wbdhu6 (
  ogc_fid,
  wkb_geometry,
  tnmid,
  metasourceid,
  sourcedatadesc,
  sourceoriginator,
  sourcefeatureid,
  loaddate,
  areaacres,
  areasqkm,
  states,
  huc6,
  name,
  shape_length,
  shape_area
)
VALUES
  (4,ST_GeomFromText('MULTIPOLYGON(((-105.845363645106 40.4826511840378,-105.844728296148 40.4826452798711,-105.843969985733 40.4827457277876,-105.843625286775 40.4827904246626,-105.842605268026 40.4829454954957,-105.842151403444 40.4830964423704,-105.845363645106 40.4826511840378)))', 4269),'{30AA0342-4EDA-487D-90D0-DE39A38E1313}','','','','','2012-06-11 07:54:59-06',6297628,25485.62,'CO','140101','Colorado Headwaters',13.2936424215745,2.67165955758456);

INSERT INTO wbdhu8 (
  ogc_fid,
  wkb_geometry,
  tnmid,
  metasourceid,
  sourcedatadesc,
  sourceoriginator,
  sourcefeatureid,
  loaddate,
  areaacres,
  areasqkm,
  states,
  huc8,
  name,
  shape_length,
  shape_area
)
VALUES
  (5,ST_GeomFromText('MULTIPOLYGON(((-105.845363645106 40.4826511840378,-105.844728296148 40.4826452798711,-105.843969985733 40.4827457277876,-105.843625286775 40.4827904246626,-105.842605268026 40.4829454954957,-105.842151403444 40.4830964423704,-105.845363645106 40.4826511840378)))', 4269),'{30AA0342-4EDA-487D-90D0-DE39A38E1313}','','','','','2012-06-11 07:54:59-06',6297628,25485.62,'CO','14010101','Colorado Headwaters',13.2936424215745,2.67165955758456);

INSERT INTO wbdhu10 (
  ogc_fid,
  wkb_geometry,
  tnmid,
  metasourceid,
  sourcedatadesc,
  sourceoriginator,
  sourcefeatureid,
  loaddate,
  areaacres,
  areasqkm,
  states,
  huc10,
  name,
  shape_length,
  shape_area
)
VALUES
  (6,ST_GeomFromText('MULTIPOLYGON(((-105.845363645106 40.4826511840378,-105.844728296148 40.4826452798711,-105.843969985733 40.4827457277876,-105.843625286775 40.4827904246626,-105.842605268026 40.4829454954957,-105.842151403444 40.4830964423704,-105.845363645106 40.4826511840378)))', 4269),'{30AA0342-4EDA-487D-90D0-DE39A38E1313}','','','','','2012-06-11 07:54:59-06',6297628,25485.62,'CO','1401010101','Colorado Headwaters',13.2936424215745,2.67165955758456),
  (9,ST_GeomFromText('MULTIPOLYGON(((-105.845363645106 40.4826511840378,-105.844728296148 40.4826452798711,-105.843969985733 40.4827457277876,-105.843625286775 40.4827904246626,-105.842605268026 40.4829454954957,-105.842151403444 40.4830964423704,-105.845363645106 40.4826511840378)))', 4269),'{30AA0342-4EDA-487D-90D0-DE39A38E1313}','','','','','2012-06-11 07:54:59-06',6297628,25485.62,'CO','140101010101','Colorado Extra',13.2936424215745,2.67165955758456);

INSERT INTO wbdhu12 (
  ogc_fid,
  wkb_geometry,
  tnmid,
  metasourceid,
  sourcedatadesc,
  sourceoriginator,
  sourcefeatureid,
  loaddate,
  areaacres,
  areasqkm,
  states,
  huc12,
  name,
  shape_length,
  shape_area
)
VALUES
  (8,ST_GeomFromText('MULTIPOLYGON(((-105.845363645106 40.4826511840378,-105.844728296148 40.4826452798711,-105.843969985733 40.4827457277876,-105.843625286775 40.4827904246626,-105.842605268026 40.4829454954957,-105.842151403444 40.4830964423704,-105.845363645106 40.4826511840378)))', 4269),'{30AA0342-4EDA-487D-90D0-DE39A38E1313}','','','','','2012-06-11 07:54:59-06',6297628,25485.62,'CO','140101010101','Colorado Headwaters',13.2936424215745,2.67165955758456);
