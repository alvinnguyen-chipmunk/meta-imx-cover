do_compile_append () {
	echo "interface=usb0" >> ${WORKDIR}/dnsmasq.conf
	echo "    dhcp-range=192.168.100.2,192.168.100.20,255.255.255.0,24h" >>  ${WORKDIR}/dnsmasq.conf
}

COMPATIBLE_MACHINE_${PN} = "(bigeye)"
