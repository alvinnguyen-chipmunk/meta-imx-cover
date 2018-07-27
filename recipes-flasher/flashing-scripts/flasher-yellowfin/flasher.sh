#!/bin/sh


BV_MACHINE="yellowfinsd_bv"
BC_MACHINE="yellowfinsd_bc"
DEBUG_CONSOLE="/dev/ttymxc0"

RED_COLOR='\033[0;31m'
GREEN_COLOR='\033[0;32m'
NO_COLOR='\033[0m'

function showfailed() {
 echo -e "${RED_COLOR} $1"
 echo -e "${RED_COLOR}****************************************"
 echo -e "${RED_COLOR} ______      _____ _      ______ _____  "  
 echo -e "${RED_COLOR}|  ____/\   |_   _| |    |  ____|  __ \ " 
 echo -e "${RED_COLOR}| |__ /  \    | | | |    | |__  | |  | |"
 echo -e "${RED_COLOR}|  __/ /\ \   | | | |    |  __| | |  | |"
 echo -e "${RED_COLOR}| | / ____ \ _| |_| |____| |____| |__| |"
 echo -e "${RED_COLOR}|_|/_/    \_\_____|______|______|_____/ "
 echo -e "${RED_COLOR}****************************************${NO_COLOR}"
}
function showpass() {

 echo -e "${GREEN_COLOR}****************************"
 echo -e "${GREEN_COLOR} _____         _____ _____  "
 echo -e "${GREEN_COLOR}|  __ \ /\    / ____/ ____| "
 echo -e "${GREEN_COLOR}| |__) /  \  | (___| (___   "
 echo -e "${GREEN_COLOR}|  ___/ /\ \  \___ \\___ \  "
 echo -e "${GREEN_COLOR}| |  / ____ \ ____) |___) | "
 echo -e "${GREEN_COLOR}|_| /_/    \_\_____/_____/  "
 echo -e "${GREEN_COLOR}****************************${NO_COLOR}"
}

function showsuccess() {

echo -e "${GREEN_COLOR}*************************************************"
echo -e "${GREEN_COLOR}   _____ _    _  _____ _____ ______  _____ _____ "
echo -e "${GREEN_COLOR}  / ____| |  | |/ ____/ ____|  ____|/ ____/ ____|"
echo -e "${GREEN_COLOR} | (___ | |  | | |   | |    | |__  | (___| (___  "
echo -e "${GREEN_COLOR}  \___ \| |  | | |   | |    |  __|  \___ \\___ \ "
echo -e "${GREEN_COLOR}  ____) | |__| | |___| |____| |____ ____) |___) |"
echo -e "${GREEN_COLOR} |_____/ \____/ \_____\_____|______|_____/_____/ "
echo -e "${GREEN_COLOR}*************************************************${NO_COLOR}"
}

LED_IND=/boot/ledindicator.sh
EMMC_FLASHER="/boot/emmc_flashing.sh"
READER_FLASHER="/boot/reader_flashing.sh"
SCANNER_FLASHER="/boot/scanner_setting.sh"
COLOR_FILTER="/boot/mlsColorFilter.sh"
BOARD=$(uname -n)

TTY=$(tty)

if [ "${TTY}" != "${DEBUG_CONSOLE}" ]; then

	echo "**************************************"
	echo "   Flashing for ${BOARD} board."
	echo "**************************************"

	# Set FLASHING state for main's led
	eval "${LED_IND} FLASHING"

	# Flashing rootfs, uImage and uboot
	eval "${EMMC_FLASHER}"


	if [ ${?} -eq 0 ]; then
		if [ "${BOARD}" = "${BV_MACHINE}" ]; then
			eval "${COLOR_FILTER} ${READER_FLASHER}"
			READER_FLASHING_RESULT=${?}	
			case ${READER_FLASHING_RESULT} in
			0)
				showsuccess
				eval "${LED_IND} SUCCESS &";;
			1)
				showfailed "FAILED SAM"
				eval "${LED_IND} FAILED_SAM &";;
			2)
				showfailed "FAILED ANTENNA"
				eval "${LED_IND} FAILED_ANTENNA &";;
			3) 	
				showfailed "FAILED EMVCONF"
				eval "${LED_IND} FAILED_EMVCONF &";;
			esac	
		else
			showsuccess
			eval "${LED_IND} SUCCESS &" 
		fi
	else
		showfailed "FAILED EMMC"
		eval "${LED_IND} FAILED_EMMC &"
	fi
fi

: exit 0
