#!/bin/bash
# Description: 
# Usage: 

export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin

RED_COLOR='\033[1;31m'
GRN_COLOR='\033[1;32m'
YEL_COLOR='\033[1;33m'
BLU_COLOR='\033[!1;34m'
RST_COLOR='\033[0m'


function init_env() {
	BOOT_PAR="mmcblk1boot0"
	EMMC_PAR="mmcblk1"
	EMMC_IMAGE="/boot/bigeye-image.sdcard"
	EMMC_UBOOT="/boot/u-boot.imx"
	EMMC_DEV="/dev/${EMMC_PAR}"
	NULL_DEV="/dev/zero"
	BOOT_DEV="/dev/${BOOT_PAR}"
}

function flash_emmc_image() {
	echo -e "${YEL_COLOR}[Flasher] ${GRN_COLOR}[INFO] Flashing eMMC image...${RST_COLOR}"
	if [ ! -e ${EMMC_IMAGE} ]; then
		echo -e "${YEL_COLOR}[Flasher] ${RED_COLOR}[ERROR] Cannot find the eMMC image...${RST_COLOR}"
		return 1
	fi
	
	echo "dd if=${EMMC_IMAGE} of=${EMMC_DEV} bs=1M"
	dd if=${EMMC_IMAGE} of=${EMMC_DEV} bs=1M
	return 0
}

function check_emmc_integrity() {
	echo -e "${YEL_COLOR}[Flasher] ${GRN_COLOR}[INFO] Checking eMMC integrity...${RST_COLOR}"
	result=$(python /usr/bin/compare.py ${EMMC_IMAGE} ${EMMC_DEV})
	if [ "${result}" = "OK" ]; then
		echo -e "${YEL_COLOR}[Flasher] ${GRN_COLOR}[INFO] Checking eMMC integrity OK.${RST_COLOR}"
		return 0
	else
		echo -e "${YEL_COLOR}[Flasher] ${RED_COLOR}[ERROR] Checking eMMC integrity FAIL.${RST_COLOR}"
		return 1
	fi
}

function burn_uboot() {
	echo -e "${YEL_COLOR}[Flasher] ${GRN_COLOR}[INFO] Burning u-boot...${RST_COLOR}"
	dd if=${NULL_DEV} of=${EMMC_DEV} bs=1k seek=768 conv=fsync count=136
	echo 0 > /sys/block/${BOOT_PAR}/force_ro
	dd if=${NULL_DEV} of=${BOOT_DEV} bs=512 seek=2
	dd if=${EMMC_UBOOT} of=${BOOT_DEV} bs=512 seek=2
	echo 1 > /sys/block/${BOOT_PAR}/force_ro
	sleep 1
	sync
}

function expand_emmc_rootfs() {
	echo -e "${YEL_COLOR}[Flasher] ${GRN_COLOR}[INFO] Expanding eMMC rootfs...${RST_COLOR}"
	PART_NUM=2
	PART_START=$(parted ${EMMC_DEV} -ms unit s p | grep "^${PART_NUM}" | awk -F':' '{ print $2}' | tr -d s)
	fdisk ${EMMC_DEV} <<EOF
p
d
${PART_NUM}
n
p
${PART_NUM}
${PART_START}

p
w
EOF
	e2fsck -yf ${EMMC_DEV}p2
	resize2fs ${EMMC_DEV}p2
}

function main() {
	echo -e "${YEL_COLOR}[Flasher] ${GRN_COLOR}[INFO] Execting flashing emmc...${RST_COLOR}"
	init_env
	flash_emmc_image
	if [ ${?} -eq 0 ]; then
		check_emmc_integrity
		if [ ${?} -eq 0 ]; then
			burn_uboot
			expand_emmc_rootfs
		else
			return 1
		fi
	else
		return 1
	fi
	
	echo -e "${YEL_COLOR}........................................................................${RST_COLOR}"
	echo -e "${YEL_COLOR}[Flasher] ${GRN_COLOR}[INFO] Execting flashing emmc success.${RST_COLOR}"
	echo -e "${YEL_COLOR}........................................................................${RST_COLOR}"
}

main
