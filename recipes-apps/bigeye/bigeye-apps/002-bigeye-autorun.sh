#!/bin/sh

BOLDYELLOW='\033[1m\033[33m'
CLEAN='\033[0m'

if [ ! -e /etc/localtime -a ! -e /etc/TZ ]; then
	TZ="UTC"		# Time Zone. Look at http://theory.uwinnipeg.ca/gnu/glibc/libc_303.html
				# for an explanation of how to set this to your local timezone.
	export TZ
fi

if [ -x /usr/bin/resize ];then
	# Make sure we are on a serial console (i.e. the device used starts with /dev/tty),
	# otherwise we confuse e.g. the eclipse launcher which tries do use ssh
 	test `tty | cut -c1-8` = "/dev/tty" && resize >/dev/null
fi

if  echo $SSH_TTY | grep pts; then        
	return
fi

echo -e "${BOLDYELLOW} *** [BIGEYE]: I will starting bigeye application in 5 seconds. Press Ctrl+C to break it.${CLEAN}"
read -t 5 tmp

echo -e "${BOLDYELLOW} *** [BIGEYE]: Using ttymxc6 for bigeye interface.${CLEAN}"
export STYL_SVC_RF_CMD=/dev/ttymxc6
export ORCA_UPDATER_PARAM="-p $STYL_SVC_RF_CMD"

echo "${BOLDYELLOW} *** [BIGEYE]: STYL_SVC_RF_CMD=${STYL_SVC_RF_CMD}${CLEAN}"

if [ "$ORCA_SERVICE_RUN" == "" ]; then
	export ORCA_SERVICE_RUN=1
	echo -e "${BOLDYELLOW} *** [BIGEYE]: Change mode to executable for applications.${CLEAN}"
	chmod +x /home/root/styl_bigeye/apps/bigeye/bigeye
	chmod +x /home/root/styl_bigeye/apps/svc/svc
	chmod +x /home/root/styl_bigeye/run.sh
	cd /home/root/styl_bigeye
	echo -e "${BOLDYELLOW} *** [BIGEYE]: Executing autorun shell script of svc and bigeye application.${CLEAN}"
	./run.sh &
fi
