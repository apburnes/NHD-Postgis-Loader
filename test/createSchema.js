'use strict';

var path = require('path');
var chai = require('chai');
var expect = chai.expect;
var assert = chai.assert;
var createSchema = require('../lib/createSchema');

var query = require('pg-query');
var connString = 'postgres://postgres:password@localhost:5432/test'
query.connectionParameters = connString;
var flowlinesCheck = 'SELECT * FROM flowlines;'
var extCheck = 'SELECT extname FROM pg_extension;'

var cleanUp = 'DROP TABLE IF EXISTS flowlines; DROP EXTENSION IF EXISTS "postgis"; DROP EXTENSION IF EXISTS "uuid-ossp";'

var sqlFile = path.join(__dirname, '../sql/createSchema');
var dbOpts = {
  dbname: 'test',
  user: 'postgres',
  password: 'password',
  port: 5432,
  host: 'localhost'
};

describe('createSchema', function() {

  afterEach(function(done) {
    query(cleanUp, function(err) {
      done(err);
    });
  });

  it('should successfully create the flowlines table', function(done) {
    createSchema(sqlFile, dbOpts, function(err, result) {
      query(flowlinesCheck, function(err, rows) {
        expect(rows).to.have.length(0);
        done(err);
      });
    });
  });

  it('should successfully create the postgis/uuid-ossp extensions', function(done) {
    createSchema(sqlFile, dbOpts, function(err, result) {
      query(extCheck, function(err, rows) {
        expect(rows).to.deep.include.members([{extname: 'postgis'},{extname: 'uuid-ossp'}]);
        done();
      });
    });
  });

  it('should reject when not passed db options', function() {
    return assert.throw(function() {
      createSchema(sqlFile, function(){});
    }, Error);
  });
});
