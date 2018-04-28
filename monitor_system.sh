#!/bin/bash

clear
# Define Variable tecreset
tecreset=$(tput sgr0)

# Check if connected to Internet or not
ping -c 1 114.114.114.114 &> /dev/null && echo -e '\E[32m'"网络: $tecreset 已连接" || echo -e '\E[32m'"网络: $tecreset 未连接"

# Check OS Type
os=$(uname -o)
echo -e '\E[32m'"操作系统 :" $tecreset $os

# Check OS Release Version and Name
cat /etc/os-release | grep 'NAME\|VERSION' | grep -v 'VERSION_ID' | grep -v 'PRETTY_NAME' > /tmp/osrelease

echo -n -e '\E[32m'"系统名称 :" $tecreset  && cat /tmp/osrelease | grep -v "VERSION" | cut -f2 -d\"
echo -n -e '\E[32m'"系统版本 :" $tecreset && cat /tmp/osrelease | grep -v "NAME" | cut -f2 -d\"
# Check Architecture
architecture=$(uname -m)
echo -e '\E[32m'"架构 :" $tecreset $architecture

# Check Kernel Release
kernelrelease=$(uname -r)
echo -e '\E[32m'"内核版本 :" $tecreset $kernelrelease

# Check hostname
echo -e '\E[32m'"主机名 :" $tecreset $HOSTNAME

# Check Internal IP
internalip=$(hostname -I)
echo -e '\E[32m'"内网IP :" $tecreset $internalip

# Check External IP
externalip=$(curl -s ipecho.net/plain;echo)
echo -e '\E[32m'"外网IP : $tecreset "$externalip

# Check DNS
nameservers=$(cat /etc/resolv.conf | sed '1 d' | awk '{print $2}')
echo -e '\E[32m'"DNS服务器 :" $tecreset $nameservers 

# Check Logged In Users
who>/tmp/who
echo -e '\E[32m'"已登陆用户 :" $tecreset && cat /tmp/who 

# Check RAM and SWAP Usages
free -h | grep -v + > /tmp/ramcache
echo -e '\E[32m'"内存使用 :" $tecreset
cat /tmp/ramcache | grep -v "Swap"
echo -e '\E[32m'"交换空间使用  :" $tecreset
cat /tmp/ramcache | grep -v "Mem"

# Check Disk Usages
df -H | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5 " " $1 }' > /tmp/diskusage
echo -e '\E[32m'"磁盘使用 :" $tecreset 
cat /tmp/diskusage

# Check Load Average
loadaverage=$(top -n 1 -b | grep "load average:" | awk '{print $10 $11 $12}')
echo -e '\E[32m'"平均负载 :" $tecreset $loadaverage

#check cpu
cpuload=$(top -n 1 -b|grep "%Cpu"|cut -d, -f1,2)
echo -e '\E[32m'"CPU负载 :" $tecreset $cpuload


# Check System Uptime
tecuptime=$(uptime | awk '{print $3,$4}' | cut -f1 -d,)
echo -e '\E[32m'"已开机时长/(HH:MM) :" $tecreset $tecuptime

# Unset Variables
unset tecreset os architecture kernelrelease internalip externalip nameserver loadaverage

# Remove Temporary Files
rm /tmp/osrelease /tmp/who /tmp/ramcache /tmp/diskusage
