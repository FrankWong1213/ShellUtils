#!/bin/sh
Project_Name=myproject
rm -rf $Project_Name
git clone ssh://git@github.com/frankwong1213/$Project_Name
cd $Project_Name
go build -o $Project_Name
pgrep $Project_Name | xargs kill -9
echo "======start new progress====="
nohup ./$Project_Name > $Project_Name.log 2>&1 &