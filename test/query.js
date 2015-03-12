'use strict';

var chai = require('chai');
var expect = chai.expect;
var assert = chai.assert;
var _ = require('lodash');
var Query = require('../util/query');

var connString = 'postgres://postgres:password@localhost:5433/test';
var connStringNoPw = 'postgres://postgres@localhost:5433/test';
var connStringNoPort = 'postgres://postgres:password@localhost:5432/test';

var sqlVersion = 'SELECT version();';

describe('Query Constructor', function() {
  var dbOpts;

  beforeEach(function() {
    dbOpts = {
      dbname: 'test',
      user: 'postgres',
      password: 'password',
      host: 'localhost',
      port: '5433'
    };
  });

  it('should successfully create the connection string', function() {
    var pg = new Query(dbOpts);
    return expect(pg.connectionParameters).to.equal(connString);
  });

  it('should successfully create the connection string without a password', function() {
    var opts = _.omit(dbOpts, 'password');
    var pg = new Query(opts);
    return expect(pg.connectionParameters).to.equal(connStringNoPw);
  });

  it('should successfully create the connection string to default to localhost', function() {
    var opts = _.omit(dbOpts, 'host');
    var pg = new Query(opts);
    return expect(pg.connectionParameters).to.equal(connString);
  });

  it('should successfully create the connection string to default to port 5432', function() {
    var opts = _.omit(dbOpts, 'port');
    var pg = new Query(opts);
    return expect(pg.connectionParameters).to.equal(connStringNoPort);
  });

  it('should successfully create the connection string with a port as an int', function() {
    var opts = _.assign(dbOpts, {
      port: 5433
    });

    var pg = new Query(opts);
    return expect(pg.connectionParameters).to.equal(connString);
  });

  it('should throw an error without a dbname option', function() {
    var opts = _.omit(dbOpts, 'dbname');

    return assert.throw(function() {
      new Query(opts);
    }, Error);
  });

  it('should throw an error without a user option', function() {
    var opts = _.omit(dbOpts, 'user');

    return assert.throw(function() {
      new Query(opts);
    }, Error);
  });
});

describe('Query Exec', function() {
  var dbOpts;

  beforeEach(function() {
    dbOpts = {
      dbname: 'test',
      user: 'postgres',
      password: 'password',
      port: '5432'
    };
  });

  it('should successfully query the database with a callback', function(done) {
    var pg = new Query(dbOpts);

    pg.exec(sqlVersion, function(err, rows, result) {
      expect(rows).to.have.length(1);
      done(err);
    });
  });

  it('should successfully query the database with a promise', function() {
    var pg = new Query(dbOpts);

    return pg.exec(sqlVersion)
      .spread(function(rows) {
        return expect(rows).to.have.length(1);
      });
  });
});
