#!/bin/sh
RED_COLOR='\e[1;31m' #红色
GREEN_COLOR='\e[1;32m' #绿色
RES='\e[0m' #尾

# 查找目录
for ((i = 1; i <= 16; i++)) 
do
if [ -d "/volume${i}/docker/alist" ];then
dir="/volume${i}/alist"
break;
fi
done


#设置GitHub加速下载
ip_info=$(curl -sk https://ip.cooluc.com)
country_code=$(echo $ip_info | sed -r 's/.*country_code":"([^"]*).*/\1/')
if [ $country_code = "CN" ]; then
	google_status=$(curl -I -4 -m 3 -o /dev/null -s -w %{http_code} http://www.google.com/generate_204)
	if [ ! $google_status = "204" ];then
		mirror="https://github.cooluc.com/"
	fi
fi

# 检查
function Check() (
	echo -e "\r\n${GREEN_COLOR}正在检查可用空间 ...${RES}"
	ROOT_SPACE=$(df -m /opt | awk 'END{print $4}')
	if [ $ROOT_SPACE -lt 20 ]; then
		echo -e "\r\n${RED_COLOR}错误! 系统存储空间小于20MB.${RES}\r\n"
		exit 1;
	fi
)
#下载
function Download()  (
	echo -e "\r\n${GREEN_COLOR}安装 <AList> 数据${RES}\r\n"
	data_db="https://raw.githubusercontent.com/3wking/AList/main/data/data.db"
	data_db_shm="https://raw.githubusercontent.com/3wking/AList/main/data/data.db-shm"
	data_db_wal="https://raw.githubusercontent.com/3wking/AList/main/data/data.db-wal"
	echo -e "${GREEN_COLOR}正在下载 $data_db ...${RES}"
	curl --connect-timeout 30 -m 600 -#kLO $mirror$data_db
	if [ $? -ne 0 ]; then
		echo -e "${RED_COLOR}下载 $data_db失败.${RES}\r\n"
		exit 1
	fi	
	echo -e "${GREEN_COLOR}正在下载 $data_db_shm ...${RES}"
	curl --connect-timeout 30 -m 600 -#kLO $mirror$data_db_shm
	if [ $? -ne 0 ]; then
		echo -e "${RED_COLOR}下载 $data_db_shm 失败.${RES}\r\n"
		exit 1
	fi	
	echo -e "${GREEN_COLOR}正在下载 $data_db_wal ...${RES}"
	curl --connect-timeout 30 -m 600 -#kLO $mirror$data_db_wal
	if [ $? -ne 0 ]; then
			echo -e "${RED_COLOR}下载 $data_db_wal 失败.${RES}\r\n"
			exit 1
	fi	
	echo -e "\r\n${GREEN_COLOR}安装 <AList数据> 完成${RES}\r\n"
)

#初始目录
if [$dir != ""]; then
echo "目录:"$dir && cd $dir || exit 1
Check
if [ $? -eq 0 ]; then
	Download
fi
fi