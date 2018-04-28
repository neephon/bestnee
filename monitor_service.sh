#!/bin/bash

clear
# Define Variable tecreset
tecreset=$(tput sgr0)


#check base service
check_baseservice(){
	base_svc=(mysqld elasticsearch nginx)
	for svc in ${base_svc[@]}
	do
		systemctl status $svc >/dev/null
		sts=$(echo $?) 
		if [ $sts -eq 0 ];then
			echo -e '\E[32m'"$svc服务: $tecreset 服务正常"
		else
			echo -e '\E[32m'"$svc服务:" "$tecreset\033[31m服务异常\033[0m"
		fi
	done
}

#check components
check_componentsvc(){
	components_svc=(eureka Kafka rbac gateway summer QuorumPeerMain es-sql-engine scheduler-admin galaxy-boot collect-agent)
	for cpns in ${components_svc[@]}
	do
		jps |grep $cpns >/dev/null
		stat=$(echo $?)
		if [ $stat -eq 0 ];then
                	echo -e '\E[32m'"$cpns服务: $tecreset 服务正常"
        	else
                	echo -e '\E[32m'"$cpns服务:" "$tecreset\033[31m服务异常\033[0m"
		fi

	done
}

check_baseservice
check_componentsvc

unset tecreset 
