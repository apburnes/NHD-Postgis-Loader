'use strict';

var path = require('path');
var readSql = require('../util/readSql');
var Q = require('../util/query');

var sqlFile = path.join(__dirname, '../sql/createSchema.sql');

function createSchema(sqlFile, opts, callback) {
  if (typeof opts === 'function') {
    throw new Error('Database opts must be set.');
  }

  var query = new Q(opts);
  var params = opts.params || [];

  readSql(sqlFile, function(err, sql) {
    if (err) {
      return callback(err);
    }

    query.exec(sql, params, function(err, rows, result) {
      if (err) {
        return callback(err);
      }

      return callback(null, result);
    });
  });
}

module.exports = createSchema;
