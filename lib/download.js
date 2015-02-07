'use strict';

var _ = require('lodash');
var fs = require('fs');
var path = require('path');
var jsftp = require('jsftp');

var NHDFTP = 'nhdftp.usgs.gov';
var folder = 'DataSets/Staged/SubRegions/FileGDB/HighResolution';

var options = {
  host: NHDFTP
};

var ftp = new jsftp(options);

function buildFilePaths(files, callback) {
  var downloads = [];

  var done = _.after(files.length, function() {
    return callback(downloads);
  });

  _.map(files, function(obj) {
    var name = obj.name;
    var file = path.join(folder, name);

    downloads.push(file);
    return done();
  });
}

function listFiles(folderPath, callback) {
  ftp.ls(folderPath, function(err, res) {
    if (err) {
      return callback(err);
    }

    buildFilePaths(res, function(downloads) {
      return callback(null, downloads);
    });
  });
}

function downloadEach(opts, callback) {

  listFiles(folder, function(err, data) {
    if (err) {
      return callback(err);
    }

    var done = _.after(fileList.length, function() {
      return callback(null, 'Completed download.');
    });

    _.map(fileList, function(file) {
      ftp.get(file, opts.outputDir, function(err) {
        if (err) {
          return callback(err);
        }

        return;
      });
    });
  });
}

function download(opts, callback) {
  if (typeof opts === 'function') {
    callback = opts;
    opts = {};
  }

  var options = {
    outputDir: opts.outputDir || './'
  };

  downloadEach(options, function(err, msg) {
    if (err) {
      return callback(err);
    }

    return  callback(null, msg);
  });
}

module.exports = download;
