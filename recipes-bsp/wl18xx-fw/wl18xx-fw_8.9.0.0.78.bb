DESCRIPTION = "Firmware files for use with TI wl18xx"
LICENSE = "TI-TSPA"
LIC_FILES_CHKSUM = "file://LICENCE;md5=4977a0fe767ee17765ae63c435a32a9e"

PROVIDES += "wl12xx-firmware"
RPROVIDES_${PN} += "wl12xx-firmware"
RREPLACES_${PN} += "wl12xx-firmware"
RCONFLICTS_${PN} += "wl12xx-firmware"

SRC_URI = " \
	git://git.ti.com/wilink8-wlan/wl18xx_fw.git;protocol=git;branch=${BRANCH} \
	file://0001-Add-Makefile-to-install-firmware-files.patch \
"

# Commit  Updated to FW 8.9.0.0.78
SRCREV = "1e2115acb07a2425d7a282078bd0aa22350eebf8"
BRANCH = "master"

S = "${WORKDIR}/git"

CLEANBROKEN = "1"

do_compile() {
    :
}

do_install() {
    oe_runmake 'DEST_DIR=${D}' install
}

FILES_${PN} = "/lib/firmware/ti-connectivity/*"
