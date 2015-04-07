'use strict';

var path = require('path');
var glob = require('glob');
var ogr2ogr = require('ogr2ogr');
var createSchema = require('./createSchema');
var transformNHD = require('./transformNHD');
var dbSettings = require('../util/dbSettings');

function loadFilegdb(gdbPath, opts, callback) {
  var settings = dbSettings(opts);
  var timeout = opts.timeout || 300000;

  var ogr = ogr2ogr(gdbPath)
    .format('PostgreSQL')
    .destination(settings)
    .timeout(timeout);

  createSchema(opts, function(err) {
    if (err) {
      return callback(err);
    }

    ogr.exec(function(error) {
      if (error) {
        return callback(error);
      }

      transformNHD(opts, function(er) {
        if (er) {
          return callback(er);
        }

        return callback(null, 'finished');
      });
    });
  });
}

module.exports = loadFilegdb;
