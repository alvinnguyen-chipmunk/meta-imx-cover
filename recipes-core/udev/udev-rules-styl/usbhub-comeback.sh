#!/bin/sh

FILE="/tmp/udev-usbhub-comeback.log"
#FILE="/dev/null"

USBHUB="/sys/bus/platform/devices/gpio_reset/reset-usbhub/control"

echo "========================================" > ${FILE}
echo "Current environment list:"
env >> ${FILE}
echo "========================================" >> ${FILE}
echo "Reseting USB Hub ..."   >> ${FILE}
echo "echo reset > ${USBHUB}" >> ${FILE}
echo reset > ${USBHUB}
if [ $? != 0 ]; then
	echo "Reseting USB Hub FAIL."		>> ${FILE}
else
	echo "Reseting USB Hub SUCCESS."	>> ${FILE}
fi
