'use strict';

var path = require('path');
var expect = require('chai').expect;
var transformNHD = require('../lib/transformNHD');
var dropSchema = require('../lib/dropSchema');

var readSql = require('../util/readSql');
var Q = require('../util/query');

var sqlSeedSchema = path.join(__dirname, './fixtures/seedSchema.sql');
var sqlDropSchema = path.join(__dirname, './fixtures/dropSchema.sql');

var sqlSelectFlowlines = 'SELECT * FROM flowlines;';
var sqlSelectHydroUnits = 'SELECT * FROM hydro_unit_boundaries;';
var sqlSelectHuClassify = 'SELECT p.proname FROM pg_catalog.pg_namespace AS n \
  JOIN pg_catalog.pg_proc AS p ON p.pronamespace = n.oid \
  WHERE p.proname = \'hu_classify\';'

var dbOpts = {
  dbname: 'test',
  user: 'postgres',
  password: 'password',
  host: 'localhost',
  port: '5432'
};

var query = new Q(dbOpts);

describe('dropSchema', function() {
  beforeEach(function(done) {
    readSql(sqlSeedSchema, function(err, sql) {
      if (err) {
        return done(err);
      }

      query.exec(sql, function(error) {
        if (error) {
          return done(error);
        }

        transformNHD(dbOpts, function(er) {
          done(er);
        });
      });
    });
  });

  afterEach(function(done) {
    readSql(sqlDropSchema, function(err, sql) {
      if (err) {
        return done(err);
      }

      query.exec(sql, function(error) {
        done(error);
      });
    });
  });

  it('should successfully drop the flowlines table', function(done) {
    dropSchema(dbOpts, function(error, result) {
      if (error) {
        return done(error);
      }

      expect(result.command).to.equal('DROP');

      query.exec(sqlSelectFlowlines, function(err) {
        expect(err).to.be.an.instanceof(Error);
        done();
      });
    });
  });

  it('should successfully drop the hydro_unit_boundaries table', function(done) {
    dropSchema(dbOpts, function(error, result) {
      if (error) {
        return done(error);
      }

      expect(result.command).to.equal('DROP');

      query.exec(sqlSelectHydroUnits, function(err) {
        expect(err).to.be.an.instanceof(Error);
        done();
      });
    });
  });

  it('should successfully drop the hu_classify function', function(done) {
    dropSchema(dbOpts, function(error, result) {
      if (error) {
        return done(error);
      }

      expect(result.command).to.equal('DROP');

      query.exec(sqlSelectHuClassify, function(err, rows) {
        expect(rows.length).to.equal(0);
        done(err);
      });
    });
  });
});
