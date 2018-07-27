SUMMARY = "Release notes for flasher"
LICENSE = "CLOSED"
LIC_FILES_CHKSUM = ""

FILESEXTRAPATHS_append := "${THISDIR}/${PN}_${PV}"

SRC_URI = "	file://release-notes.txt"

FILES_${PN}_append = " /boot"

S = "${WORKDIR}"

do_configure() {
	:
}

do_install () {
	install -d ${D}/boot
	install -m 0644 ${S}/release-notes.txt ${D}/boot
}

COMPATIBLE_MACHINE = "(bigeye)"

