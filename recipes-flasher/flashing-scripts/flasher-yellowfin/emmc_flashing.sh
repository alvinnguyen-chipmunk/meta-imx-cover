#!/bin/bash
# Description: 
# Usage: 

export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin


function init_env() {
	BOOT_PAR="mmcblk0boot0"
	EMMC_PAR="mmcblk0"
	EMMC_IMAGE="/boot/yellowfin.sdcard"
	EMMC_UBOOT="/boot/u-boot.imx"
	EMMC_DEV="/dev/${EMMC_PAR}"
	NULL_DEV="/dev/zero"
	BOOT_DEV="/dev/${BOOT_PAR}"
}

function flash_emmc_image() {
	echo -e "[\e[0;32mINFO\e[0m] Flashing eMMC image..."
	if [ ! -e ${EMMC_IMAGE} ]; then
		echo -e "[\e[0;31mERROR\e[0m] Cannot find the eMMC image"
		return 1
	fi
	
	dd if=${EMMC_IMAGE} of=${EMMC_DEV} bs=1M
	return 0
}

function check_emmc_integrity() {
	echo -e "[\e[0;32mINFO\e[0m] Checking eMMC integrity..."
	result=$(python /usr/bin/compare.py ${EMMC_IMAGE} ${EMMC_DEV})
	if [ ${result} == "OK" ]; then
		echo -e "[\e[0;32mINFO\e[0m] Checking eMMC integrity OK"
		return 0
	else
		echo -e "[\e[0;31mERROR\e[0m] Checking eMMC integrity failed"
		return 1
	fi
}

function burn_uboot() {
	echo "[\e[0;32mINFO\e[0m] Burning U-boot..."
	dd if=${NULL_DEV} of=${EMMC_DEV} bs=1k seek=384 count=129
	echo 0 > /sys/block/${BOOT_PAR}/force_ro
	dd if=${NULL_DEV} of=${BOOT_DEV} bs=512 seek=2 count=1000
	dd if=${EMMC_UBOOT} of=${BOOT_DEV} bs=512 seek=2
	echo 1 > /sys/block/${BOOT_PAR}/force_ro
	#echo 8 > /sys/block/mmcblk0/device/boot_config
	sleep 1
	sync
}

function expand_emmc_rootfs() {
	echo "[\e[0;32mINFO\e[0m] Expanding eMMC rootfs..."
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

function enable_boot_config() {
	x=1
	while [ $x -le 1 ]
	do
		echo 8 > /sys/block/${EMMC_PAR}/device/boot_config
		result=$(cat /sys/block/${EMMC_PAR}/device/boot_info | grep -q "BOOT_PARTITION-ENABLE: 1")
		if [ -z ${result} ]; then
			x=$(( $x + 1 ))
			echo "Boot Partition has been enabled."
		else
			echo "Enabling Boot Partition..."
			echo 8 > /sys/block/${EMMC_PAR}/device/boot_config
		fi
	done
}

function main() {
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
	
	# enable_boot_config
	
	echo ".........................."
	echo "...Finish eMMC flashing..."
	echo ".........................."
}

main
