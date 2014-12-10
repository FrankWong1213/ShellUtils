#!/bin/sh
#自动下载代码，并用maven编译，成功之后部署到tomcat,脚本后面可以跟编译属性ID
Project_Name=dianshang
Deploy_Path=/root/.m2/repository/com/viway/project/
Tomcat_Home=/opt/apache-tomcat-7.0.56/
echo "============================== clean local code =============================="
rm -rf $Project_Name
echo "============================== begin  checkout  code =============================="
svn co https://github.com/FrankWong1213/dianshang/trunk  dianshang

# svn co https://github.com/FrankWong1213/dianshang/trunk -r  20  dianshang

# git clone https://username:password@github.com/FrankWong1213/dianshang.git  $Project_Name
# cd $Project_Name
# git reset --hard 7e0304f
# cd ..
echo "============================== finish  checkout source code =============================="
Deploy_Version=$(awk '/<version>/,/<\/version>/ {print $0}'  $Project_Name/pom.xml | awk -v FS="<version>" -v OFS=" " '{print $2}' | awk -v FS="</version>" -v OFS=" " '{print $1;exit}')
echo "==============================the deploy version is $Deploy_Version =============================="
Profile_ID=$1
if [ "$Profile_ID" = "" ]
then
  Profile_ID=staging
  echo "set default profile id is staging"
else
  echo "set profile id $Profile_ID"
fi
cd $Project_Name
mvn clean install -P $Profile_ID
echo "============================== finish mvn compile ============================="
sudo $Tomcat_Home/bin/shutdown.sh
sleep 5
cd $Tomcat_Home/webapps
rm -rf $Project_Name*
cd $Tomcat_Home/work
rm -rf Catalina*
cd $Deploy_Path/$Project_Name/$Deploy_Version
mv -f  $Project_Name-$Deploy_Version.war $Project_Name.war
cp $Project_Name.war $Tomcat_Home/webapps
sudo $Tomcat_Home/bin/startup.sh
