#!/bin/sh
DUMP=/usr/bin/mysqldump
OUT_DIR=/home/mysql_data_backup_path
LINUX_USER=root
DB_NAME=test
DB_USER=root
DB_PASS=123456
cd $OUT_DIR
DATE=`date +%Y%m%d`
OUT_SQL="$DATE.sql"
TAR_SQL="data_bak_$DATE.tar.gz"
$DUMP -u $DB_USER -p$DB_PASS $DB_NAME --default-character-set=utf8 --opt -Q -R --skip-lock-tables > $OUT_SQL
#$DUMP -u $DB_USER -p$DB_PASS --databases db1 db2 --default-character-set=utf8 --opt -Q -R --skip-lock-tables > $OUT_SQL
tar -czf $TAR_SQL ./$OUT_SQL
/usr/bin/aliyuncli oss Config --host oss-cn-hangzhou-internal.aliyuncs.com --accessid ******* --accesskey *******
/usr/bin/aliyuncli oss Put $TAR_SQL oss://letusgo-db-backup
rm $OUT_SQL
