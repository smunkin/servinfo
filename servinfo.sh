#!/bin/bash
# Server Info script

# Vars
RED='\033[5m\033[31m'
BLACK='\033[0m'
GREEN='\033[0;33m'
TITLE=$(hostname)
HOSTIP=$(hostname -i | awk {'print $1'})

# Services vars. Change the serv1, serv2 and etc. variables to the name of your services
serv1="zabbix_agentd"
serv2="zabbix_server"
serv3="apache2"
serv4="postgres"
serv5="fail2ban"
#docker_serv1="librespeed"

# OS info
[ -f /usr/bin/toilet ] && toilet -f mono12 -F metal $TITLE || echo -e "$GREEN====== $TITLE ($HOSTIP) ======$BLACK"
free -m | awk 'NR==2{printf "Memory Usage: %sMB / %sMB (%.2f%%)\n", $3,$2,$3*100/$2}'
df -h / | grep "G" | awk {'print "Disk Usage: ",$3,"/",$2,"("$5")"'}

# Check services status
echo -e "\nServices Status: "
[ "$(pidof $serv1)" ] && echo -e "[$GREEN  OK  $BLACK] $serv1" || echo -e "[$RED FAIL $BLACK] $serv1"
[ "$(pidof $serv2)" ] && echo -e "[$GREEN  OK  $BLACK] $serv2" || echo -e "[$RED FAIL $BLACK] $serv2"
[ "$(pidof $serv3)" ] && echo -e "[$GREEN  OK  $BLACK] $serv3" || echo -e "[$RED FAIL $BLACK] $serv3"
[ "$(pidof $serv4)" ] && echo -e "[$GREEN  OK  $BLACK] $serv4" || echo -e "[$RED FAIL $BLACK] $serv4"
[ $(pgrep $serv5) ] && echo -e "[$GREEN  OK  $BLACK] $serv5" || echo -e "[$RED FAIL $BLACK] $serv5"
# if docker containers
#[ "$(docker ps | grep $docker_serv1)" ] && echo -e "$[$GREEN OK $BLACK] $docker_serv1" || echo -e "[$RED FAIL $BLACK] $docker_serv1"
echo -e "\n"
