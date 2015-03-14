'use strict';

var path = require('path');
var chai = require('chai');
var expect = chai.expect;
var readSql = require('../util/readSql');

var sqlFile = path.join(__dirname, './fixtures/test.sql');
var sqlFileNoExt = path.join(__dirname, './fixtures/test');
var notSqlFile = path.join(__dirname, './fixtures/notafile.sql');
var sqlString = 'SELECT version();';

describe('readSql Utility', function() {
  it('should successfully read the sql file', function(done) {
    readSql(sqlFile, function(err, sql) {
      var sqlStatement = sql.replace(/\n$/, '');
      expect(sqlStatement).to.equal(sqlString);
      done(err);
    });
  });

  it('should successfully append and read the sql file if file ext is not provided', function(done) {
    readSql(sqlFileNoExt, function(err, sql) {
      var sqlStatement = sql.replace(/\n$/, '');
      expect(sqlStatement).to.equal(sqlString);
      done(err);
    });
  });

  it('should reject non existant files', function(done) {
    readSql(notSqlFile, function(err, sql) {
      expect(sql).to.equal(undefined);
      expect(err).to.be.an.Error;
      done();
    });
  });
});
