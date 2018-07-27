SUMMARY = "Script stresstest for wifi connection"
LICENSE = "CLOSED"
LIC_FILES_CHKSUM = ""

#SRC_URI = "file://wifi-stresstest.sh 		\
#	   file://styl-wifi-stresstest.service 	\
#"
SRC_URI = "file://wifi-stresstest.sh 		\
"
#inherit systemd 

RDEPENDS_${PN} = " python python-six python-pyudev python-dbus dbus-glib python-smbus bash"

S = "${WORKDIR}"

FILES_${PN}_append = "/home			\
		      /home/testing		\
		      /home/testing/wifi	\
"
do_install() {
	# add test script
        install -d ${D}/home/testing/wifi
        install -m 0755 ${S}/wifi-stresstest.sh ${D}/home/testing/wifi/

	# Install systemd unit files
        # install -d ${D}${systemd_unitdir}/system
        # install -m 0644 ${S}/styl-wifi-stresstest.service ${D}${systemd_unitdir}/system
}

#SYSTEMD_SERVICE_${PN} = "styl-wifi-stresstest.service"
#SYSTEMD_AUTO_ENABLE_${PN} = "disable"
COMPATIBLE_MACHINE = "(bigeye)"
