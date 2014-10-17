#!/bin/sh
#php自动下载部署
Project_Name=sht-website
rm -rf $Project_Name
echo "============================== clean local code =============================="
echo "============================== begin  checkout code =============================="
svn co https://github.com/FrankWong1213/GRM-Website/trunk  $Project_Name
echo "============================== finish checkout code =============================="
rm -rf /home/wwwroot/$Project_Name
echo "--------------------clean web server files---------------"
mv  $Project_Name  /home/wwwroot/
cd /home/wwwroot/$Project_Name
echo "--------------------clean .svn---------------"
find . -type d -name ".svn"|xargs rm -rf
echo "--------------------finish copy files to webroot---------------"                                                         
