#!/bin/sh

TRUE=0
FALSE=1

PARTITION="/dev/mmcblk0p1"
MOUNT_DIR="/mnt/mmcblk0p1"

LOGO_BC="logo_bc.bmp"
LOGO_BV="logo_bv.bmp"

LOGO_DIR="/boot"

BV_MACHINE="yellowfinsd_bv"
BC_MACHINE="yellowfinsd_bc"

BOARD=$(uname -n)

ERROR=${FALSE}

__main__()
{
	echo "Mount partition consist logo image"
	umount ${PARTITION}
	mkdir -p ${MOUNT_DIR}
	mount -t vfat ${PARTITION} ${MOUNT_DIR}
	
	if [ ${?} -eq 0 ]; then
		echo "Burning logo file ..."
        	if [ "${BOARD}" = "${BV_MACHINE}" ]; then
			cp ${LOGO_DIR}/${LOGO_BV} ${MOUNT_DIR}
			if [ ${?} -ne 0 ]; then
				ERROR=${TRUE}
			fi
		else
			cp ${LOGO_DIR}/${LOGO_BC} ${MOUNT_DIR}
			if [ ${?} -ne 0 ]; then
                                ERROR=${TRUE}
                        fi			
		fi
		sync
		umount ${PARTITION}
	else
		ERROR=${TRUE}
	fi

	echo "............................."
	if [ ${ERROR} -eq ${TRUE} ]; then
		echo "....Flashing logo failure...."
	else
		echo "....Flashing logo success...."
	fi
	echo "............................."
}

__main__
