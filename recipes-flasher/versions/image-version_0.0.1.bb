LICENSE = "CLOSED"
LIC_FILES_CHKSUM = ""

# Modify these as desired
SRCREV = "${AUTOREV}"

DEPENDS = "bash"

S = "${WORKDIR}"

FILES_${PN}_append = " /boot"


do_configure() {
	:
}

do_compile() {
	if [ ${MACHINE} = "yellowfinbv" ]
	then
		VER_STRING="Bus Terminal BUILD_DATE=$(date +%Y.%m.%d) DISTRO_VERSION=${DISTRO_VERSION}"
	elif [ ${MACHINE} = "yellowfinbc" ]
	then
		VER_STRING="Bus Console BUILD_DATE=$(date +%Y.%m.%d) DISTRO_VERSION=${DISTRO_VERSION}"
	elif [ ${MACHINE} = "yellowfinsd_bv" ]
	then
		VER_STRING="Yellowfin SD Bus Terminal DISTRO_VERSION=${DISTRO_VERSION} BUILD_DATE=$(date +%Y.%m.%d)"
	elif [ ${MACHINE} = "yellowfinsd_bc" ]
	then
		VER_STRING="Yellowfin SD Bus Console DISTRO_VERSION=${DISTRO_VERSION} BUILD_DATE=$(date +%Y.%m.%d)"
	elif [ ${MACHINE} = "bigeye" ]
	then
		VER_STRING="Bigeye Gateway DISTRO_VERSION=${DISTRO_VERSION} BUILD_DATE=$(date +%Y.%m.%d)"

	fi
	echo ${VER_STRING} > ${S}/version.txt
}
do_install () {
	install -d ${D}/boot
	install -m 0755 ${S}/version.txt ${D}/boot
}

COMPATIBLE_MACHINE = "(yellowfinbc|yellowfinbv|yellowfinsd_bc|yellowfinsd_bv|bigeye)"

