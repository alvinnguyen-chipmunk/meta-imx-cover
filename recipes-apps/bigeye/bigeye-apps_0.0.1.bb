SUMMARY = "Bigeye test applications"
LICENSE = "CLOSED"
LIC_FILES_CHKSUM = ""

FILESEXTRAPATHS_append := "${THISDIR}/${PN}_${PV}"

SRC_URI = "	file://styl_bigeye.tar.gz 	\
		file://001-ppp-connection.sh 	\
		file://002-bigeye-autorun.sh"

FILES_${PN}_append = "  /home/root/styl_bigeye			\
			/home/root/styl_bigeye/download		\
			/home/root/styl_bigeye/apps/bigeye 	\
			/home/root/styl_bigeye/apps/svc		\
			/home/root/styl_bigeye/apps/downloader	\
			/home/root/styl_bigeye/apps/flashingapp	\
		     "

RDEPENDS_${PN} = "bash glib-2.0 libconfig qtbase curl"

S = "${WORKDIR}"

do_install() {
        install -d ${D}/home/root
        install -d ${D}/home/root/styl_bigeye

        cp -rf ${S}/styl_bigeye/* ${D}/home/root/styl_bigeye

	install -d ${D}/etc/profile.d
	install -m 0644 ${S}/001-ppp-connection.sh ${D}/etc/profile.d/
	install -m 0644 ${S}/002-bigeye-autorun.sh ${D}/etc/profile.d/
}
