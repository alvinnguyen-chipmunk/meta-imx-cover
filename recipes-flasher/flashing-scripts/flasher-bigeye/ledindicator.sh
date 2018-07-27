#!/bin/bash
# Description: Show the LED status
# Usage: ledindication.sh [FLASHING|SUCCESS|FAILED_SAM|FAILED_ANTENNA|FAILED_EMMC]

LED_R_PIN="/sys/class/leds/led-red"
LED_G_PIN="/sys/class/leds/led-green"
LED_B_PIN="/sys/class/leds/led-blue"

function control_gpio() {
	if [ ! -d ${1} ]; then 
		echo "${1} was not found!"
	else
		echo ${2} > ${1}/brightness
	fi
}

case ${1} in
FLASHING)
	control_gpio ${LED_R_PIN} 0
	control_gpio ${LED_G_PIN} 1
	control_gpio ${LED_B_PIN} 0;;
SUCCESS)
	control_gpio ${LED_R_PIN} 0
	control_gpio ${LED_G_PIN} 0
	control_gpio ${LED_B_PIN} 1;;
FAILED_EMMC)
	while true
	do
		control_gpio ${LED_R_PIN} 1
		control_gpio ${LED_G_PIN} 0
		control_gpio ${LED_B_PIN} 0
		sleep 1
		control_gpio ${LED_R_PIN} 0
		control_gpio ${LED_G_PIN} 0
		control_gpio ${LED_B_PIN} 0
		sleep 1
	done;;
*)
	echo "Unsupported status ${1}";;
esac
