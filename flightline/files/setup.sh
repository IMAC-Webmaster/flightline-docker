#!/bin/bash

if [ $(whoami) != "root" ]; then
  echo "ERROR: This script must execute as the root user.   Pease call again using 'sudo'"
  exit
fi

checkDir() {
 dirToCheck=$1
 if [ -e "$dirToCheck" -a -d "$dirToCheck" ]; then
   echo "INFO: Dir $dirToCheck is OK."
 else
   echo "ERROR: Dir $dirToCheck is NOT OK.  Aborting."
   exit
 fi
}

[ ! -e /data ] && mkdir /data
[ ! -e /data/volumes/web ] && mkdir -p /data/volumes/web
[ ! -e /data/volumes/html ] && mkdir -p /data/volumes/html

checkDir /data
checkDir /data/volumes
checkDir /data/volumes/web
checkDir /data/volumes/html

if [ -e /data/composer/flightline/files/default.conf ]; then
  echo "INFO: copying web server config"
  cp /data/composer/flightline/files/default.conf /data/volumes/web/
fi

echo "INFO: cloning flightline web app."
git clone https://danny@git.dannysplace.net/scm/score/score-flightline-node.git /data/volumes/html

chown -r www-data:www-data /data/volumes/html/db /data/volumes/html/log
chmod 2775 /data/volumes/html/db /data/volumes/html/log
