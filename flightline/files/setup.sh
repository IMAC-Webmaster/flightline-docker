#!/bin/bash

[ ! -e /data ] && mkdir /data
[ ! -e /data/volumes/web ] && mkdir -p /data/volumes/web
[ ! -e /data/volumes/html ] && mkdir -p /data/volumes/html

checkDir /data
checkDir /data/volumes
checkDir /data/volumes/web
checkDir /data/volumes/html


