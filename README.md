# ef-hb [![Build Status](https://travis-ci.org/hendriklammers/ef-hb.svg?branch=master)](https://travis-ci.org/hendriklammers/ef-hb)

Elm frontend with Haskell backend


## Server

Make sure you have [Stack](http://haskellstack.org) installed and run the
following commands to build and start the server

```
$ stack setup
$ stack build
$ stack exec server
```

## Client

Make sure you have a recent version of node and npm installed.
All commands for the client should be run from the `client` directory.

```
$ npm install
$ npm start
```

To build a production bundle use

```
$ npm build
```

## License

MIT
