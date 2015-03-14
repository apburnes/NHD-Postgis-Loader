'use strict';

var _ = require('lodash');
var pgSettings = _.template('PG:<%= settings %>');

function dbSettings(opts) {
  if (!opts.dbname || !opts.user) {
    throw new Error('Set dbname and user to complete load.');
  }

  var options = {
    host: opts.host || '',
    dbname: opts.dbname,
    user: opts.user,
    password: opts.password || '',
    port: opts.port || ''
  };

  var params = _.map(options, function(value, key, obj) {
    if (!(_.isEmpty(value))) {
      var concated = key.concat('=', value);
      return concated;
    }
  });

  var settings = _.filter(params, undefined).join(' ');

  var compiled = pgSettings({
    settings: settings
  });

  return compiled;
}

module.exports = dbSettings;
