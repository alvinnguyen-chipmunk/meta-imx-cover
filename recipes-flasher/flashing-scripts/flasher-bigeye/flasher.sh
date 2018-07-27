#!/bin/sh

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

BOARD=$(uname -n)

echo -e "${BOLDYELLOW} *** [FLASHER]: We will (re)flashing eMMC. Press Ctrl+C to break it in 5 seconds.${CLEAN}"
read -t 5 tmp

echo "**************************************"
echo "   Flashing for ${BOARD} board."
echo "**************************************"

# Set FLASHING state for main's led
eval "${LED_IND} FLASHING"

# Flashing rootfs, uImage and uboot
eval "${EMMC_FLASHER}"
if [ ${?} -eq 0 ]; then
	showsuccess
	eval "${LED_IND} SUCCESS &" 
else
	showfailed "FAILED EMMC"
	eval "${LED_IND} FAILED_EMMC &"
fi

: exit 0
