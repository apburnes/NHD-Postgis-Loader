DROP EXTENSION IF EXISTS "postgis" CASCADE;
DROP EXTENSION IF EXISTS "uuid-ossp" CASCADE;

DROP SEQUENCE IF EXISTS "nhdline_ogc_fid_seq" CASCADE;
DROP SEQUENCE IF EXISTS "nhdpoint_ogc_fid_seq" CASCADE;
DROP SEQUENCE IF EXISTS "nhdflowline_ogc_fid_seq" CASCADE;
DROP SEQUENCE IF EXISTS "nhdlineeventfc_ogc_fid_seq" CASCADE;
DROP SEQUENCE IF EXISTS "nhdareaeventfc_ogc_fid_seq" CASCADE;
DROP SEQUENCE IF EXISTS "nhdwaterbody_ogc_fid_seq" CASCADE;
DROP SEQUENCE IF EXISTS "nhdarea_ogc_fid_seq" CASCADE;
DROP SEQUENCE IF EXISTS "nhdpointeventfc_ogc_fid_seq" CASCADE;
DROP SEQUENCE IF EXISTS "nwisdrainagearea_ogc_fid_seq" CASCADE;
DROP SEQUENCE IF EXISTS "nwisboundary_ogc_fid_seq" CASCADE;
DROP SEQUENCE IF EXISTS "wbdline_ogc_fid_seq" CASCADE;
DROP SEQUENCE IF EXISTS "noncontributingdrainagearea_ogc_fid_seq" CASCADE;
DROP SEQUENCE IF EXISTS "wbdhu14_ogc_fid_seq" CASCADE;
DROP SEQUENCE IF EXISTS "wbdhu8_ogc_fid_seq" CASCADE;
DROP SEQUENCE IF EXISTS "wbdhu2_ogc_fid_seq" CASCADE;
DROP SEQUENCE IF EXISTS "wbdhu16_ogc_fid_seq" CASCADE;
DROP SEQUENCE IF EXISTS "hydro_net_junctions_ogc_fid_seq" CASCADE;
DROP SEQUENCE IF EXISTS "wbdhu4_ogc_fid_seq" CASCADE;
DROP SEQUENCE IF EXISTS "wbdhu12_ogc_fid_seq" CASCADE;
DROP SEQUENCE IF EXISTS "wbdhu10_ogc_fid_seq" CASCADE;
DROP SEQUENCE IF EXISTS "wbdhu6_ogc_fid_seq" CASCADE;

DROP TABLE IF EXISTS "flowlines" CASCADE;
DROP TABLE IF EXISTS "hydro_unit_boundaries" CASCADE;
DROP FUNCTION IF EXISTS hu_classify(huc varchar) CASCADE;

DROP TABLE IF EXISTS "hydro_net_junctions" CASCADE;
DROP TABLE IF EXISTS "nhdarea" CASCADE;
DROP TABLE IF EXISTS "nhdareaeventfc" CASCADE;
DROP TABLE IF EXISTS "nhdflowline" CASCADE;
DROP TABLE IF EXISTS "nhdline" CASCADE;
DROP TABLE IF EXISTS "nhdlineeventfc" CASCADE;
DROP TABLE IF EXISTS "nhdpoint" CASCADE;
DROP TABLE IF EXISTS "nhdpointeventfc" CASCADE;
DROP TABLE IF EXISTS "nhdwaterbody" CASCADE;
DROP TABLE IF EXISTS "noncontributingdrainagearea" CASCADE;
DROP TABLE IF EXISTS "nwisboundary" CASCADE;
DROP TABLE IF EXISTS "nwisdrainagearea" CASCADE;
DROP TABLE IF EXISTS "wbdhu10" CASCADE;
DROP TABLE IF EXISTS "wbdhu12" CASCADE;
DROP TABLE IF EXISTS "wbdhu14" CASCADE;
DROP TABLE IF EXISTS "wbdhu16" CASCADE;
DROP TABLE IF EXISTS "wbdhu2" CASCADE;
DROP TABLE IF EXISTS "wbdhu4" CASCADE;
DROP TABLE IF EXISTS "wbdhu6" CASCADE;
DROP TABLE IF EXISTS "wbdhu8" CASCADE;
DROP TABLE IF EXISTS "wbdline" CASCADE;

