#!/bin/bash

OHOME=$(pwd)
SCRIPT=$0

SHOME=$(dirname $SCRIPT)
cd "$SHOME"
SHOME=$(pwd)
DATENOW=$(date '+%Y%m%d.%H%M%S')

if [ $(whoami) != "root" ]; then
  echo "ERROR: This script must execute as the root user.   Pease call again using 'sudo'"
  exit
fi

usage() {
  echo "Usage: $(basename $SCRIPT)"
  echo " --basedir <dir>"
  echo " --sql <empty | skel | testdata | custom <filename>>"
  echo " * --sql empty    - Just create the bare database with empty tables."
  echo " * --sql skel     - Include the sequence definitions for the current year's knowns and alternate knowns."
  echo " * --sql testdata - Also include some test data with pilots, rounds and some results."
}


checkDir() {
 dirToCheck=$1
 if [ -e "$dirToCheck" -a -d "$dirToCheck" ]; then
   echo "INFO: Dir $dirToCheck is OK."
 else
   echo "ERROR: Dir $dirToCheck is NOT OK.  Aborting."
   exit
 fi
}

# Transform long options to short ones
for arg in "$@"; do
  shift
  case "$arg" in
    "--basedir")    set -- "$@" "-d";;
    "--sql")        set -- "$@" "-s";;
    *)              set -- "$@" "$arg"
  esac
done

# Parse short options
OPTIND=1
while getopts "d:s:" opt
do
  case "$opt" in
    "d")
         BASEDIR=${OPTARG}
         ;;
    "s")
         SQLOPT=${OPTARG}
         ;;
    *) usage >&2; cd $OHOME; exit 1 ;;
  esac
done
shift $(expr $OPTIND - 1)

if [ -z "$BASEDIR" -o -z "$SQLOPT" ]; then
  usage >&2
  cd $OHOME
  exit 1
fi

case "$SQLOPT" in
  "empty")
    ;;
  "skel")
    ;;
  "testdata")
    ;;
  *)
    usage >&2; cd $OHOME; exit 1
    ;;
esac


[ ! -e "$BASEDIR" ] && mkdir "$BASEDIR"
[ ! -e "$BASEDIR"/volumes/web ] && mkdir -p "$BASEDIR"/volumes/web
[ ! -e "$BASEDIR"/volumes/html ] && mkdir -p "$BASEDIR"/volumes/html

checkDir "$BASEDIR"
checkDir "$BASEDIR"/volumes
checkDir "$BASEDIR"/volumes/web
checkDir "$BASEDIR"/volumes/html

if [ -e "$BASEDIR"/composer/flightline/files/default.conf ]; then
  echo "INFO: copying web server config"
  cp "$BASEDIR"/composer/flightline/files/default.conf "$BASEDIR"/volumes/web/
fi

echo "INFO: cloning flightline web app."
git clone https://danny@git.dannysplace.net/scm/score/score-flightline-node.git "$BASEDIR"/volumes/html

if [ -e "$BASEDIR/volumes/html/db/flightline.db" ]; then
  mv "$BASEDIR/volumes/html/db/flightline.db" "$BASEDIR/volumes/html/db/flightline_backup_${DATENOW}.db"
fi

cat flightline-empty.sql | sqlite3 "$BASEDIR"/volumes/html/db/flightline.db
case "$SQLOPT" in
  "testdata")
    cat flightline-add-test-data.sql | sqlite3 "$BASEDIR"/volumes/html/db/flightline.db
    echo "INFO: Created database for flightline with test data included.."
    ;;
  "skel")
    cat flightline-*-schedules-no-extra-data.sql | sqlite3 "$BASEDIR"/volumes/html/db/flightline.db
    echo "INFO: Created database for flightline with recent known schedules included."
    ;;
  "empty")
    echo "INFO: Created empty database for flightline."
    ;;
  *)
    echo "ERROR: Not sure how to initalise the DB.   Skipping."
    ;;
esac

chown -R www-data:www-data "$BASEDIR"/volumes/html/db "$BASEDIR"/volumes/html/log
chmod 2775 "$BASEDIR"/volumes/html/db "$BASEDIR"/volumes/html/log


cd "$BASEDIR"/composer/flightline
docker-compose up -d
docker-compose logs
