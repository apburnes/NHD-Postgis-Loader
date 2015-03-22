'use strict';

var path = require('path');
var chai = require('chai');
var expect = chai.expect;
var loadFilegdb = require('../lib/loadFilegdb');
var readSql = require('../util/readSql');
var Q = require('../util/query');

var dropSchema = path.join(__dirname, './fixtures/dropSchema.sql');

var filegdb = path.join(__dirname, './fixtures/NHDH1401.gdb');

var dbOpts = {
  dbname: 'test',
  user: 'postgres',
  password: 'password',
  host: 'localhost',
  port: '5432'
};

var query = new Q(dbOpts);

describe('Load Filegdb', function() {
  afterEach(function(done) {
    readSql(dropSchema, function(err, sql) {
      if (err) {
        return done(err);
      }

      query.exec(sql, function(error) {
        if (error) {
          return done(error);
        }

        done();
      });
    });
  });

  it('should successfully extract load and transform the NHD data from the filegdb', function(done) {
    loadFilegdb(filegdb, dbOpts, function(err, result) {
      if (err) {
        return done(err);
      }

      query.exec('SELECT * FROM flowlines;', function(error, rows) {
        expect(rows.length).to.be.above(70000);
        expect(result).to.equal('finished');
        done(error);
      });
    });
  });
});
