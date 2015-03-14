'use strict';

var chai = require('chai');
var expect = chai.expect;
var assert = chai.assert;
var _ = require('lodash');
var dbSettings = require('../util/dbSettings');

var defaultSettings = 'PG:host=localhost dbname=test user=postgres password=password port=5432';
var noPortSettings = 'PG:host=localhost dbname=test user=postgres password=password';
var noPwSettings = 'PG:host=localhost dbname=test user=postgres port=5432';
var noHostSettings = 'PG:dbname=test user=postgres password=password port=5432';

describe('DB Settings', function() {
  var dbOpts;

  beforeEach(function() {
    dbOpts = {
      dbname: 'test',
      user: 'postgres',
      password: 'password',
      host: 'localhost',
      port: '5432'
    };
  });

  afterEach(function() {
    dbOpts = null;
  });

  it('should create the pg settings with all of the keys', function() {
    var settings = dbSettings(dbOpts);
    return expect(settings).to.equal(defaultSettings);
  });

  it('should create the pg settings with missing port', function() {
    var opts = _.omit(dbOpts, 'port');
    var settings = dbSettings(opts);
    return expect(settings).to.equal(noPortSettings);
  });

  it('should create the pg settings with missing password', function() {
    var opts = _.omit(dbOpts, 'password');
    var settings = dbSettings(opts);
    return expect(settings).to.equal(noPwSettings);
  });

  it('should create the pg settings with missing host', function() {
    var opts = _.omit(dbOpts, 'host');
    var settings = dbSettings(opts);
    return expect(settings).to.equal(noHostSettings);
  });

  it('should fail with a missing dbname', function() {
    var opts = _.omit(dbOpts, 'dbname');
    return assert.throw(function() {
      dbSettings(opts);
    }, Error);
  });
});
