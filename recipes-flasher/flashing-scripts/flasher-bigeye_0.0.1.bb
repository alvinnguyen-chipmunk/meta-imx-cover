SUMMARY = "This is a group of script to flashing bigeye board"
LICENSE = "CLOSED"
LIC_FILES_CHKSUM = ""

FILESEXTRAPATHS_append := "${THISDIR}/${PN}:"

SRC_URI = " file://emmc_flashing.sh 	\
	    file://flasher.sh 		\
	    file://ledindicator.sh 	\
	    file://compare.py 		\
"
# Modify these as desired
PV = "1.0"

RDEPENDS_${PN} = "bash"

S = "${WORKDIR}"

FILES_${PN}_append = " /boot ${sysconfdir}/profile.d ${bindir}"


do_install () {
	install -d ${D}/boot
	install -m 0755 ${S}/emmc_flashing.sh ${D}/boot
	install -m 0755 ${S}/ledindicator.sh ${D}/boot

	install -d ${D}/${bindir}
	install -m 0755 ${S}/compare.py ${D}/${bindir}	

	install -d ${D}${sysconfdir}/profile.d
	install -m 0755 ${S}/flasher.sh ${D}/${sysconfdir}/profile.d
}

COMPATIBLE_MACHINE_${PN} = "(bigeye)"
