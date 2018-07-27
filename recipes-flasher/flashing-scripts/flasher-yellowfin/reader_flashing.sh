#!/bin/bash

INFO="[\e[0;32mINFO\e[0m]"
ERROR="[\e[0;31mERROR\e[0m]"
MAXIM_RST_GPIO=81
antennaID="1"

function resetMaxim() {
	echo "Going to enable GPIO${MAXIM_RST_GPIO} of iMX6"
	if [ ! -d /sys/class/gpio/gpio${MAXIM_RST_GPIO} ]; then
		echo "Export gpio${MAXIM_RST_GPIO} for manually usage"
		echo ${MAXIM_RST_GPIO} > /sys/class/gpio/export
	fi
	echo "Pull the GPIO_Reset pin high"
	echo high > /sys/class/gpio/gpio${MAXIM_RST_GPIO}/direction
	sleep 1
	echo "Pull the GPIO_Reset pin low again"
	echo low > /sys/class/gpio/gpio${MAXIM_RST_GPIO}/direction
}

function retry {
	local n=1
	local max=$1
	local delay=$2
	local cmd="${@:3}"
	local retVal=0
	echo "$cmd"
	while true; do
		$cmd && break || {
		if [[ $n -lt $max ]]; then
			((n++))
			echo "Command failed. Attempt $n/$max:"
			for (( i = delay; i > 0; i-- )); do
				printf "Sleep: %02d\r" "${i}"
				sleep 1
			done
		else
			echo "The command has failed after $n attempts."
			retVal=1
			break
		fi
		}
	done

	return "$retVal"
}

function update_mcu_bootloader() {
	echo -e "${INFO} Updating MCU's bootloader..."
	/boot/A9Bootup-FwUpgrade.sh
	if [ "$?" -ne 0 ]; then
		echo -e "${ERROR} Failed to update MCU's bootloader!!!"
		return 1
	fi
	echo -e "${INFO} Updating MCU's bootloader OK"
}

function start_serial_service() {
	echo -e "${INFO} Starting serial service..."
	/home/root/svc > /dev/null 2>&1 &
	sleep 5
}

function download_firmware_to_RF_processor() {
	local n=1
	local max=3
	local delay=5
	local cmd="/home/root/readerutils/rfp_fwupgrade /home/root/surisdk.bin"
	local retVal=0

	echo -e "${INFO} Downloading firmware to RF processor..."
	while true; do
		#Load surisdk to RF processor
		$cmd && break || {
		if [[ $n -lt $max ]]; then
			((n++))
			echo "Command failed. Attempt $n/$max:"
			#Hard reset RF processor
			resetMaxim
			for (( i = delay; i > 0; i-- )); do
				printf "Sleep: %02d\r" "${i}"
				sleep 1
			done
		else
			echo -e "${ERROR} Failed to download main firmware to RF processor after $n attempts!!!"
			retVal=1
			break
		fi
		}
	done

	sleep 5
	echo -e "${INFO} Downloading firmware to RF processor OK"
	return "$retVal"
}

function upgrade_pn5180_firmware() {
	echo -e "${INFO} Download PN5180 firmware"
	retry 5 10 /home/root/readerutils/pn5180UpgradeApp 0 $antennaID /home/root/readerutils/pn5180fw305.bin
	if [ "$?" -ne 0 ]; then
		echo -e "${ERROR} Failed to download PN5180 firmware!!!"
		return 1
	fi
	echo -e "${INFO} Upgrading PN5810 firmware OK"

	echo -e "${INFO} Load factory configuration data to PN5180 at antenna ID = ${antennaID}"
	retry 5 1 /home/root/readerutils/pn5180config w /home/root/readerutils/pn5180CfgDefault.cfg ${antennaID}
	if [ "$?" -ne 0 ]; then
		echo -e "${ERROR} Failed to load default configuration in EPPROM of PN5180!!!"
		return 1
	fi
	echo -e "${INFO} Load factory configuration data to PN5810 OK"

	return 0
}
function emv_load_config() {
	cd /home/root/emv
	retry 5 1 ./emv_load_config.sh
	if [ "$?" -ne 0 ]; then
		echo "Failed to load default EMV configuration!!!"	
		return 1
	fi
	cd /home/root
	echo -e "${INFO} Load EMV config OK"
	return 0
}
function main() {
	systemctl stop styl-readerd.service
	systemctl stop styl-readersvcd.service
	killall svc
	update_mcu_bootloader
	if [ "$?" -ne 0 ]; then
		return 1;
	fi
	start_serial_service
	download_firmware_to_RF_processor
	if [ "$?" -ne 0 ]; then
		return 1;
	fi

	# __Workaround__: start
	# Purpose: take time for EMVL2 configuration before NOR flash
	# Skype message:
	# I just checked and confirmed the issue "need to flash BV 2 time
	# in order to program the PN5180", it is the same problem as Sirius
	# flasher. Because up and from version 2.1.x of RF processor
	# firmware, when running, at initial step, it will check and take
	# time to write the EMVL2 configuration, version... to NOR flash
	# connected to RF processor when the NOR flash is blank or has the
	# different EMVL2 version, so please help to add the delay
	# 20 seconds (sleep 20) in flasher script after loading firmware
	# to RF processor to fix this issue.
	# printf "${INFO} Workaround: reserve 20s for EMVL2 conf\n"
	# for (( i = 20; i > 0; i-- )); do
	# 	printf "Sleep for 20s: %02d\r" "${i}"
	# 	sleep 1
	# done
	#
	# __Workaround__: Bao/Tam updated, we will retry 5 times
	# if fail, wait for 10s until next try
	# all of the logic is moved to upgrade_pn5180_firmware function
	upgrade_pn5180_firmware
	if [ "$?" -ne 0 ]; then
		return 2;
	fi
	# __Workaround__: end
	emv_load_config
	if [ "$?" -ne 0 ]; then
		return 3;
	fi
}

main
