'use strict';

var glob = require('glob');
var ogr2ogr = require('ogr2ogr');
var createSchema = require('./createSchema');
var dbSettings = require('../util/dbSettings');

function loadFilegdb(gdbPath, opts, callback) {
  var settings = dbSettings(opts);

  var ogr = ogr2ogr(gdbPath)
    .format('PostgreSQL')
    .destination(settings);

}

module.exports = loadFilegdb;
