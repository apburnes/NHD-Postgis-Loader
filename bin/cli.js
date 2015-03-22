#!/usr/bin/env node

var fs = require('fs');
var path = require('path');
var glob = require('glob');
var parseArgs = require('minimist');

var ogr2ogr = require('ogr2ogr');

var argv = parseArgs(process.argv.slice(2), {
  alias: {
    h: 'help',
    f: 'format',
    db: 'dbname',
    u: 'user',
    pw: 'password',
    p: 'port',
    h: 'host',
    t: 'timeout'
  }
});

var func = argv._[0];

if (!func || argv._[0] === 'help' || argv.help) {
  console.log('Usage:');
  console.log(' nhd-load gdb <src> [options]');
  console.log('');
  console.log(' nhd-load dir <src> [options]');
  console.log('');
  console.log('Example:');
  console.log('  nhd-load loadFilegbd nhd.gdb -db=nhd-db -u=postgres -pw=password -p=5432');
  console.log('');
  console.log('Options:');
  console.log('  --format=[destination database]  Default: PostgreSQL');
  console.log('  --dbname=[string]');
  console.log('  --user=[string]');
  console.log('  --password=[string]');
  console.log('  --port=[number] Default: 5432');
  console.log('  --timeout=[number] Default: 300000 ms');
  process.exit(1);
}

if (func) {
  console.log(func);
}


