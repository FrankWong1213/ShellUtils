#!/bin/sh
#增加当前访问主机ip到允许访问8080端口
ip=`echo $SSH_CLIENT | awk '{ print $1}'`
sed -i "20s/.*/-A INPUT -p tcp -m tcp --dport 8080 -j ACCEPT -s $ip/" /etc/sysconfig/iptables
/sbin/service iptables reload