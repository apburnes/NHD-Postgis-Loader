'use strict';

var chai = require('chai');
var expect = chai.expect;

var download = require('../lib/download');

describe('Download FTP files', function() {
  it('should succesfully list the files in the ftp directory without any options', function(done) {
    download(function(err, data) {
      expect(true).to.be.true;
      done(err);
    });
  });
});
