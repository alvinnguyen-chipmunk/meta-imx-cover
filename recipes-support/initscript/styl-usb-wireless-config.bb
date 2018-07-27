SUMMARY = "Styl auto configure wireless connnection from USB mass storage"
LICENSE = "CLOSED"
LIC_FILES_CHKSUM = ""

BRANCH="only-wireless"
SRC_URI = "git://git@192.168.9.253/yellowfin/extraconfigservice.git;protocol=ssh;branch=${BRANCH}"
SRCREV = "${AUTOREV}"

inherit systemd

RDEPENDS_${PN} = " python python-six python-pyudev python-dbus dbus-glib python-smbus bash"

S = "${WORKDIR}/git"

FILES_${PN}_append = " /home/root /home/root/styl-usb-wireless-config"

do_install() {
	# add python script
        install -d ${D}/home/root/styl-usb-wireless-config
        install -m 0644 ${S}/styl_usb_wireless_config_header.py 	${D}/home/root/styl-usb-wireless-config/
        install -m 0755 ${S}/styl_usb_wireless_config.py 		${D}/home/root/styl-usb-wireless-config/

	# Install systemd unit files
        install -d ${D}${systemd_unitdir}/system
        install -m 0644 ${S}/styl-usb-wireless-config.service ${D}${systemd_unitdir}/system
}

SYSTEMD_SERVICE_${PN} = "styl-usb-wireless-config.service"

COMPATIBLE_MACHINE_${PN} = "(bigeye)"
