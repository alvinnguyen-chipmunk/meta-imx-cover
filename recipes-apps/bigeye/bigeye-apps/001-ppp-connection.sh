#!/bin/sh

DIR="/etc/styl"
PPP_FILE="${DIR}/ppp"
SVC_FILE="${DIR}/svc"

#echo "nameserver 8.8.8.8" > /etc/resolv.conf

if [ ! -f "${PPP_FILE}" ]; then
	echo "Creating some connection for LTE module ..."
	nmcli c add ifname ttyUSB0 type gsm apn dummy && \
	nmcli c add ifname ttyUSB1 type gsm apn dummy && \
	nmcli c add ifname ttyUSB2 type gsm apn dummy && \
	nmcli c add ifname ttyUSB3 type gsm apn dummy && \
	nmcli c add ifname ttyUSB4 type gsm apn dummy && \
	nmcli c add ifname ttyUSB5 type gsm apn dummy && \
	sleep 3				              && \
	echo "Reseting NetworkManager ..."	      && \
	systemctl restart NetworkManager	      && \
	mkdir -p ${DIR}				      && \
	touch ${PPP_FILE}
fi

if [ ! -f "${SVC_FILE}" ]; then
	echo "Fixing share libraries linking for svc application ..."
        ln -s /lib/libudev.so.1 /lib/libudev.so.0			&& \
        ln -s /usr/lib/libcrypto.so.1.0.2 /usr/lib/libcrypto.so.1.0.0	&& \
	mkdir -p ${DIR}                               			&& \
	touch ${SVC_FILE}
fi
