#!/usr/bin/env node

var fs = require('fs');
var path = require('path');
var glob = require('glob');
var parseArgs = require('minimist');

var nhd = require('../');

var argv = parseArgs(process.argv.slice(2), {
  alias: {
    f: 'format',
    db: 'dbname',
    u: 'user',
    pw: 'password',
    p: 'port',
    h: 'host',
    t: 'timeout'
  }
});

var func = nhd[argv._[0]];
var filegdb = path.resolve(argv._[1] || '');

if (!func || argv._[0] === 'help' || argv.help) {
  console.log('Usage:');
  console.log(' nhd-load loadFilegdb [options] <src>');
  console.log('');
  console.log('Example:');
  console.log('  $ nhd-load loadFilegdb --dbname=nhdtest --port=5432 --host=localhost --user=postgres --password=password filegdbs/NHDData.gdb');
  console.log('');
  console.log('Options:');
  console.log('  --dbname=[string]');
  console.log('  --user=[string]');
  console.log('  --password=[string]');
  console.log('  --host=[string] Default: "localhost"');
  console.log('  --port=[number] Default: 5432');
  console.log('  --timeout=[number] Default: 300000 ms');
  process.exit(0);
}

if (func) {
  func(filegdb, argv, function(err, result) {
    if (err) {
      processExit(err);
    }

    processExit();
  });
}

function processExit(msg) {
  process.on('exit', function(code) {
    if (code === 0) {
      console.log('Success');
    }

    if (code === 1) {
      console.log('Error: ' + msg)
    }
  });

  if (msg) {
    process.exit(1);
  }
  else {
    process.exit(0);
  }
}
