NHD Postgis Loader
==================

## Source Data

National Hydrography Dataset - [USGS](http://nhd.usgs.gov/)

__Download__

[ftp://nhdftp.usgs.gov/DataSets/Staged/SubRegions/FileGDB/HighResolution](ftp://nhdftp.usgs.gov/DataSets/Staged/SubRegions/FileGDB/HighResolution)

## Install

`$ npm install nhd-load`

## Testing

Download the test filegdb, unzip it, and place it in `./test/fixtures` directory

__Test Filegdb__

[ftp://nhdftp.usgs.gov/DataSets/Staged/SubRegions/FileGDB/HighResolution/NHDH1401_931v220.zip](ftp://nhdftp.usgs.gov/DataSets/Staged/SubRegions/FileGDB/HighResolution/NHDH1401_931v220.zip)

To run the tests

`$ npm test`

## API

#### nhd.loadFilegdb

```js
var nhd = require('nhd-load');
var nhdFilegdb = __dirname + './filegdbs/NHDData.gdb' // Path to filegdb;

var dbOptions = {
  dbname: 'test',
  user: 'postgres',
  password: 'password',
  host: 'localhost',
  port: '5432'
};

nhd.loadFilegdb(nhdFilegdb, dbOptions, function(err, result) {
  if (err) {
    // handle err
  }

  // Console Output = "finished"
  console.log(result);
});

```

## CLI

#### loadFilegdb

```bash
$ nhd-load loadFilegdb --dbname=nhdtest --port=5432 --host=localhost --user=postgres --password=password filegdbs/NHDData.gdb

nhd-load help

Usage:
 nhd-load gdb <src> [options]

Example:
  $ nhd-load loadFilegdb --dbname=nhdtest --port=5432 --host=localhost --user=postgres --password=password filegdbs/NHDData.gdb

Options:
  --format=[destination database]  Default: PostgreSQL
  --dbname=[string]
  --user=[string]
  --password=[string]
  --port=[number] Default: 5432
  --timeout=[number] Default: 300000 ms
```

## Contact
Andy B
