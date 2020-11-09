#!/bin/sh
cp -R /sources/config/* /fabric/
cp -R /sources/base /fabric/base
cp -R /sources/buildpack /fabric/buildpack
chmod -R 777 /fabric/buildpack/bin
cp -R /sources/cc-pkg-config /fabric/cc-pkg-config
exit 0
