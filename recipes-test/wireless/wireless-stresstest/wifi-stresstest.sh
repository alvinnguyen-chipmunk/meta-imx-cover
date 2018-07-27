#!/bin/bash

TRUE="0"
FAIL="1"
RED='\033[1m\033[31m'
YEL='\033[1m\033[33m'
BLU='\033[1m\033[34m'
RST='\033[0m'

ORI_MD5CODE="9017804333c820e3b4249130fc989e00"
DL_FILE="http://ipv4.download.thinkbroadband.com/20MB.zip"

MYSELF=$(basename ${0})
TIME="`date +"%Y%m%d-%T"`"
LOG_DIR="/home/testing/wifi/test-results"
TEST_FILE="20MB.zip"

reboot_system()
{
	sync
	echo -e "${YEL} *** [${MYSELF}]: I will reboot system in 5 seconds. Press Ctrl+C to break it.${RST}"
	read -t 5 tmp
	reboot
}

mkdir -p ${LOG_DIR} && cd ${LOG_DIR} && touch ${LOG_DIR}/${TIME}.txt
if [ $? != 0 ]; then
	echo -e "${RED}Can not creating log files. Exit!!!${RST}"
fi

echo -e "${YEL} *** [${MYSELF}]: I will start wifi stresstest in 5 seconds. Press Ctrl+C to break it.${RST}"
read -t 60 tmp

CONTINUE=${FAIL}
MAX_LOOP=10
for i in `seq 1 ${MAX_LOOP}`
do
	echo -e "${YEL}[${MYSELF}]: Detecting Device #${i} ...${RST}"
	echo "[${MYSELF}]: Detecting Device #${i} ..." 	>> ${LOG_DIR}/${TIME}.txt
	echo "nmcli dev | grep \"wifi\"" 		>> ${LOG_DIR}/${TIME}.txt
	nmcli dev | grep "wifi"	&& CONTINUE=${TRUE} && break
	sleep 5
done

if [ "${CONTINUE}" != "${TRUE}" ]; then
	echo -e "${RED}Wifi device was not found! Exit!${RST}" 
	echo "Wifi device was not found! Exit!"		>> ${LOG_DIR}/${TIME}.txt
	echo "[${MYSELF}]: *** EXIT with error." >> ${LOG_DIR}/${TIME}.txt
	reboot_system
fi

echo -e "${YEL}[${MYSELF}]: Checking wireless connection ...${RST}"
echo "[${MYSELF}]: Checking wireless connection ..."	>> ${LOG_DIR}/${TIME}.txt
nmcli con | grep "802-11-wireless"
if [ $? != 0 ]; then
        echo -e "${RED}Wireless connnection was not found. Exit!!!${RST}"
        echo "Wireless connnection was not found. Exit!!!" 	>> ${LOG_DIR}/${TIME}.txt
	echo "[${MYSELF}]: *** EXIT with error." 		>> ${LOG_DIR}/${TIME}.txt
	reboot_system
fi

echo -e "${YEL}[${MYSELF}]: Scanning SSID ...${RST}"				&& \
echo "[${MYSELF}]: Scanning SSID ..."		>> ${LOG_DIR}/${TIME}.txt	&& \
echo "nmcli dev wifi list"			>> ${LOG_DIR}/${TIME}.txt	&& \
nmcli dev wifi list 				>> ${LOG_DIR}/${TIME}.txt	&& \
echo -e "${YEL}[${MYSELF}]: PING command ...${RST}"				&& \
echo "[${MYSELF}]: PING command ..."		>> ${LOG_DIR}/${TIME}.txt	&& \
echo "ping google.com.vn -c 4 -I wlan0"		>> ${LOG_DIR}/${TIME}.txt	&& \
ping google.com.vn -c 4 -I wlan0		>> ${LOG_DIR}/${TIME}.txt	&& \
echo -e "${YEL}[${MYSELF}]: WGET command ...${RST}"				&& \
echo "[${MYSELF}]: WGET command ..." 		>> ${LOG_DIR}/${TIME}.txt	&& \
echo "wget ${DL_FILE} --output-file=${LOG_DIR}/wget-${TIME}.txt" --output-document=${LOG_DIR}/${TEST_FILE} >> ${LOG_DIR}/${TIME}.txt 	&& \
wget ${DL_FILE} --output-file=${LOG_DIR}/wget-${TIME}.txt  --output-document=${LOG_DIR}/${TEST_FILE}					&& \
echo -e "${YEL}[${MYSELF}]: Checksum downloaded file ...${RST}"			&& \
echo "[${MYSELF}]: Checksum downloaded file ..."		>> ${LOG_DIR}/${TIME}.txt	&& \
MD5CODE=$(md5sum ${LOG_DIR}/${TEST_FILE} | awk '{print $1}')			&& \
echo "ORI_CODE: ${ORI_MD5CODE}"			>> ${LOG_DIR}/${TIME}.txt	&& \
echo "NEW_CODE: ${MD5CODE}"			>> ${LOG_DIR}/${TIME}.txt	&& \
if [ "${ORI_MD5CODE}" = "${MD5CODE}" ]; then
	echo -e "${BLU}Corectly download!!!${RST}"
	echo "Corectly download!!!"		>> ${LOG_DIR}/${TIME}.txt
else
	echo -e "${RED}Download got issue. Exit!!!${RST}"
	echo "Download got issue. Exit!!!"	 >> ${LOG_DIR}/${TIME}.txt
	echo "[${MYSELF}]: *** EXIT with error." >> ${LOG_DIR}/${TIME}.txt
	reboot_system
fi
rm -rf ${LOG_DIR}/${TEST_FILE}							
echo -e "${BLU}[${MYSELF}]: *** DONE without error.${RST}"
echo "[${MYSELF}]: *** DONE without error."			>> ${LOG_DIR}/${TIME}.txt
reboot_system
