#!/bin/bash
# Server Info script

# Vars
RED='\033[5m\033[31m'
BLACK='\033[0m'
GREEN='\033[0;33m'
TITLE=$(hostname)
HOSTIP=$(hostname -I | awk {'print $1'})
load_average=$(uptime | awk -F 'load average: ' '{print $2}')
time_since_reboot=$(uptime | awk -F'( |,|:)+' '{d=h=m=0; if ($7=="min") m=$6; else {if ($7~/^day/) {d=$6;h=$8;m=$9} else {h=$6;m=$7}}} {print d+0,"days",h+0,"hours"}')
free_memory=$(free -m | awk 'NR==2{printf "Memory Usage: %sMB / %sMB (%.2f%%)\n", $3,$2,$3*100/$2}')
disk_usage=$(df -h / | grep "G" | awk {'print "Disk Usage: ",$3,"/",$2,"("$5")"'})

# Services vars. Change the serv1, serv2 and etc. variables to the name of your services
serv1="confluence"
serv2="zabbix_agentd"
serv3="postgres"
# docker_serv1="librespeed"

# OS info
[ -f /usr/bin/toilet ] && toilet -f mono12 -F metal -w 140 $TITLE || echo -e "$GREEN====== $TITLE ($HOSTIP) ======$BLACK"
echo "Uptime: $time_since_reboot"
echo "Load Average: $load_average"
echo "Free Memory: $free_memory"
echo "Disk Usage: $disk_usage"

# Check services status
echo -e "\nServices Status: "
[ "$(systemctl list-units --type=service --state=running | grep $serv1)" ] && echo -e "[$GREEN OK $BLACK] $serv1" || echo -e "[$RED FAIL $BLACK] $serv1"
[ "$(pidof $serv2)" ] && echo -e "[$GREEN OK $BLACK] $serv2" || echo -e "[$RED FAIL $BLACK] $serv2"
[ "$(pidof $serv3)" ] && echo -e "[$GREEN OK $BLACK] $serv3" || echo -e "[$RED FAIL $BLACK] $serv3"

# if docker containers
#[ "$(docker ps | grep $docker_serv1)" ] && echo -e "$[$GREEN OK $BLACK] $docker_serv1" || echo -e "[$RED FAIL $BLACK] $docker_serv1"
#echo -e "\n"
