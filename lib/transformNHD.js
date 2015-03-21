'use strict';

var path = require('path');
var readSql = require('../util/readSql');
var Q = require('../util/query');

var sqlTransform = path.join(__dirname, '../sql/transformNHD.sql');
var sqlCleanup = path.join(__dirname, '../sql/removeLoadSchema.sql');

function transform(query, callback) {
  readSql(sqlTransform, function(err, sql) {
    if (err) {
      return err;
    }

    query.exec(sql, function(error, result) {
      if (error) {
        return callback(error);
      }

      return callback(null, result);
    });
  });
}

function clean(query, callback) {
  readSql(sqlCleanup, function(err, sql) {
    if (err) {
      return err;
    }

    query.exec(sql, function(error, result) {
      if (error) {
        return callback(error);
      }

      return callback(null, result);
    });
  });
}

function transformNHD(opts, callback) {
  if (typeof opts === 'function') {
    throw new Error('Database opts must be set.');
  }

  var query = new Q(opts);

  transform(query, function(err) {
    if (err) {
      return callback(err);
    }

    clean(query, function(error) {
      if (error) {
        return callback(error);
      }

      return callback(null, 'Finished');
    });
  });
}

module.exports = transformNHD;
