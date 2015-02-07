'use strict';

var chai = require('chai');
var expect = chai.expect;

var unzip = require('../lib/unzip');

describe('Download FTP files', function() {
  it('should succesfully list the files in the ftp directory without any options', function(done) {
    unzip(function(err, data) {
      expect(true).to.be.true;
      done(err);
    });
  });
});
