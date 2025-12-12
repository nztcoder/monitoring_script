#!/bin/bash

ARCH=$(uname -a)
CPU_physical=$(grep "physical id" /proc/cpuinfo | sort -u | wc -l)
CPU_virtual=$(grep "^processor" /proc/cpuinfo | wc -l)

Memory_used=$(free -m | awk '/^Mem:/ {print $3}')
Memory_total=$(free -m | awk '/^Mem:/ {print $2}')
Memory_percent=$(free -m | awk '/^Mem:/ {printf "%.2f", $3/$2*100}')

Disk_used=$(df -BM --total | awk '/^total/ {print $3}' | tr -d 'M' )
Disk_total=$(df -BM --total | awk '/^total/ {print $2}' | tr -d 'M')
Disk_total_GB=$(awk "BEGIN {printf \"%.0f\", ${Disk_total}/1024}")
Disk_percent=$(df -BM --total | awk '/^total/ {print $5}')

CPU_idle=$(vmstat 1 2 | tail -1 | awk '{print $15}')
CPU_load=$(awk "BEGIN {printf \"%.1f\", 100 - ${CPU_idle}}")

Last_boot=$(who -b | awk '{print $3 " " $4}')
LVM_use=$(lsblk | awk '$6=="lvm" {f=1} END {print (f ? "yes" : "no")}')
TCP_connections=$(ss -tan | grep ESTAB | wc -l)
User_log=$(who | awk '{print $1}' | sort -u | wc -l)
IP_address=$(hostname -I | awk '{print $1}')
MAC_address=$(ip link | awk '/link\/ether/ {print $2; exit}')

if [ -f /var/log/sudo/sudo_config ]; then
        Sudo_cmd=$(grep -c "COMMAND=" /var/log/sudo/sudo_config)
else
        Sudo_cmd=0
fi
wall << EOF
#Architecture: $ARCH
#CPU physical : $CPU_physical
#vCPU : $CPU_virtual
#Memory usage: ${Memory_used}/${Memory_total}MB (${Memory_percent}%)
#Disk Usage: ${Disk_used}/${Disk_total_GB}Gb (${Disk_percent})
#CPU load: ${CPU_load}%
#Last boot: $Last_boot
#LVM use: $LVM_use
#Connections TCP : $TCP_connections ESTABLISHED
#User log: $User_log
#Network: IP $IP_address ($MAC_address)
#Sudo : ${Sudo_cmd} cmd
EOF
