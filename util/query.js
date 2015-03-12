'use strict';

var pgQuery = require('pg-query');
var _ = require('lodash');

var connStringTemplate = _.template('postgres://<%= userInfo %>@<%= dbInfo %>');

function createUserInfo() {
  var user = this.user;
  var password = this.password;

  if (!user) {
    throw new Error('A database user must be supplied');
  }

  if (!password) {
    return this.user;
  }

  return user.concat(':', password);
}

function createDbInfo() {
  var dbname = this.dbname;
  var host = this.host || 'localhost';
  var port;

  if (!this.port) {
    port = '5432';
  }
  else {
    port = this.port.toString();
  }

  if (!dbname) {
    throw new Error('A database name must be supplied');
  }

  return host.concat(':', port, '/', dbname);
}

function createConnectionString() {
  var self = this;
  var userInfo = createUserInfo.apply(self);
  var dbInfo = createDbInfo.apply(self);

  return connStringTemplate({
    userInfo: userInfo,
    dbInfo: dbInfo
  });
};

function Query(opts) {
  if (!(this instanceof Query)) {
    return new Query(opts);
  }

  this.options = opts;
  this.connectionParameters = createConnectionString.apply(opts);
}

Query.prototype.exec = function exec(sql, params, callback) {
  pgQuery.connectionParameters = this.connectionParameters;

  if (typeof params === 'function') {
    callback = params;
    params = [];
  }

  if (!params) {
    params = [];
  }

  if (!callback) {
    return pgQuery(sql, params);
  }
  else {
    return pgQuery(sql, params, callback);
  }
};

module.exports = Query;
