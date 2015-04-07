'use strict';

var fs = require('fs');
var path = require('path');
var expect = require('chai').expect;
var assert = require('chai').assert;
var createSchema = require('../lib/createSchema');

var query = require('pg-query');
var connString = 'postgres://postgres:password@localhost:5432/test'
query.connectionParameters = connString;

var flowlinesCheck = 'SELECT COUNT(*) FROM flowlines;'
var extCheck = 'SELECT extname FROM pg_extension;'
var dropSchema = fs.readFileSync(path.join(__dirname, './fixtures/dropSchema.sql'), 'utf-8');

var dbOpts = {
  dbname: 'test',
  user: 'postgres',
  password: 'password',
  port: 5432,
  host: 'localhost'
};

describe('createSchema', function() {

  afterEach(function(done) {
    query(dropSchema, function(err) {
      done(err);
    });
  });

  it('should successfully create the flowlines table', function(done) {
    createSchema(dbOpts, function(err, result) {
      expect(result.command).to.equal('CREATE');
      done(err);
    });
  });

  it('should successfully create the postgis/uuid-ossp extensions', function(done) {
    createSchema(dbOpts, function(err, result) {
      query(extCheck, function(err, rows) {
        expect(rows).to.deep.include.members([{extname: 'postgis'},{extname: 'uuid-ossp'}]);
        done();
      });
    });
  });

  it('should reject when not passed db options', function() {
    return assert.throw(function() {
      createSchema(function(){});
    }, Error);
  });
});
