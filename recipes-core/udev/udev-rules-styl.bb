DESCRIPTION = "Udev rules for some workaround from STYL"
LICENSE = "CLOSED"
LIC_FILES_CHKSUM = ""

SRC_URI = " file://11-usbhub-comeback.rules 	\
	    file://usbhub-comeback.sh		\
"
S = "${WORKDIR}"

do_install () {
	install -d ${D}${sysconfdir}/udev/rules.d
	install -m 0644 ${WORKDIR}/11-usbhub-comeback.rules ${D}${sysconfdir}/udev/rules.d/
	
	install -d ${D}${sysconfdir}/udev/scripts
	install -m 0755 ${WORKDIR}/usbhub-comeback.sh ${D}${sysconfdir}/udev/scripts/
}

COMPATIBLE_MACHINE_${PN} = "(bigeye)"
