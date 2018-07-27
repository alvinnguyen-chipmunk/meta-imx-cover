SUMMARY = "Styl USB extra configure daemon"
LICENSE = "CLOSED"
LIC_FILES_CHKSUM = ""

SRC_URI = "git://git@192.168.9.253/yellowfin/extraconfigservice.git;protocol=ssh;branch=V1.0"
PV = "1.0+git${SRCPV}"
SRCREV = "${AUTOREV}"

inherit systemd

RDEPENDS_${PN} = " python python-six python-pyudev python-dbus dbus-glib python-smbus bash"

S = "${WORKDIR}/git"

FILES_${PN}_append = " /home/root \
		       ${sysconfdir}/profile.d"

do_install() {
	# add python script
        install -d ${D}/home/root/extra-service
        install -m 0644 ${S}/extra_config_header.py 	${D}/home/root/extra-service
        install -m 0644 ${S}/extra_config_runtime.py 	${D}/home/root/extra-service
        install -m 0644 ${S}/extra_config_boottime.py 	${D}/home/root/extra-service

	# Install systemd unit files
        install -d ${D}${systemd_unitdir}/system
        install -m 0644 ${S}/styl-yellowfin-extra-config-runtime.service ${D}${systemd_unitdir}/system
	
	# Install profile unit files
	install -d ${D}${sysconfdir}/profile.d
	install -m 0755 ${S}/styl-yellowfin-extra-config-boottime.sh ${D}${sysconfdir}/profile.d
}

SYSTEMD_SERVICE_${PN} = "styl-yellowfin-extra-config-runtime.service"
