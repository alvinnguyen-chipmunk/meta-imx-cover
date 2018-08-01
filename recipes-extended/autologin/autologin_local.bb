SUMMARY = "Serial terminal auto login for bigeye platform"
LICENSE = "CLOSED"
LIC_FILES_CHKSUM = ""

SRC_URI = "file://autologin.conf"

S = "${WORKDIR}"

do_install() {
	case ${MACHINE_ARCH} in
        	bigeye)
			DROPIN_DIR=serial-getty@ttymxc0.service.d;;
	        *)
			DROPIN_DIR=""
        esac
	
	if [ "${DROPIN_DIR}" != "" ]; then
		install -d ${D}${sysconfdir}/systemd/system/${DROPIN_DIR}/
		install -m 0644 ${WORKDIR}/autologin.conf ${D}${sysconfdir}/systemd/system/${DROPIN_DIR}/
	fi
}

COMPATIBLE_MACHINE = "(bigeye)"


