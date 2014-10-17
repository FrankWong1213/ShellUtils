#!/bin/sh

DATE=`date +%Y%m%d`
TAR_FILE_PATH="/home/mongodb_backup/$DATE"
DB_USER=admin
DB_PASS=123456
DB_NAME=sht
mongodump -h 127.0.0.1 -u $DB_USER  -p $DB_PASS  -d $DB_NAME -o $TAR_FILE_PATH
