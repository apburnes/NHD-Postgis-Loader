CREATE EXTENSION IF NOT EXISTS "postgis";
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

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
