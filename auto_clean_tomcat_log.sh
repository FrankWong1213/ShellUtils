#!/bin/sh
DATE=`date +%Y%m%d`
TomcatLogPath=/opt/apache-tomcat-8.5.14/logs
cd $TomcatLogPath
cp catalina.out   catalina.out_$DATE.bak
echo "" > catalina.out
#自动清理15天前日志
find $TomcatLogPath -mtime +15 -name "*.log" -exec rm -rf {} \;
find $TomcatLogPath -mtime +15 -name "*.txt" -exec rm -rf {} \;
find $TomcatLogPath -mtime +15 -name "*.bak" -exec rm -rf {} \;