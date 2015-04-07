'use strict';

var path = require('path');
var readSql = require('../util/readSql');
var Q = require('../util/query');

var sqlDrop = path.join(__dirname, '../sql/dropSchema.sql');

function dropSchema(opts, callback) {
  if (typeof opts === 'function') {
    throw new Error('Database opts must be set.');
  }

  var query = new Q(opts);

  readSql(sqlDrop, function(err, sql) {
    if (err) {
      return callback(err)
    }

    query.exec(sql, function(error, rows, result) {
      if (error) {
        return  callback(err);
      }

      return callback(null, result);
    });
  });
}

module.exports = dropSchema;
