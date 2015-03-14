'use strict';

var fs = require('fs');
var path = require('path');

function readSql(filePath, callback) {
  if (!path.extname(filePath)) {
    filePath = filePath.concat('.sql');
  }

  fs.readFile(filePath, 'utf-8', function(err, sql) {
    if (err) {
      return callback(err);
    }

    return callback(null, sql);
  });
}

module.exports = readSql;
