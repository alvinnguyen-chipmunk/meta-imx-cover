SUMMARY = "This is a serial service for Sirius reader, it directs data flow from application to correct port"
LICENSE = "CLOSED"
LIC_FILES_CHKSUM = ""

FILESEXTRAPATHS_append := "${THISDIR}/${PN}:"

SRC_URI = " file://emmc_flashing.sh 	\
	    file://flasher.sh 		\
	    file://ledindicator.sh 	\
	    file://reader_flashing.sh 	\
	    file://scanner_setting.sh 	\
	    file://logo_flashing.sh	\
	    file://compare.py \
	    file://mlsColorFilter.sh \
"

# Modify these as desired
PV = "1.0"

SD_BC_RDEPENDS = ""
SD_BV_RDEPENDS = " reader-emvconf-tool reader-serial-service reader-utils"
RDEPENDS_${PN} = "bash ${@base_contains("${MACHINE_ARCH}", "yellowfinsd_bv", "${SD_BV_RDEPENDS}", "${SD_BC_RDEPENDS}",d)}"

S = "${WORKDIR}"

FILES_${PN}_append = " /boot ${sysconfdir}/profile.d ${bindir}"


do_install () {
	install -d ${D}/boot
	install -m 0755 ${S}/emmc_flashing.sh ${D}/boot
	install -m 0755 ${S}/ledindicator.sh ${D}/boot
	install -m 0755 ${S}/logo_flashing.sh ${D}/boot

	install -d ${D}/${bindir}
	install -m 0755 ${S}/compare.py ${D}/${bindir}	

	case ${MACHINE_ARCH} in
        	yellowfinsd_bv)
			install -m 0755 ${S}/reader_flashing.sh ${D}/boot
			install -m 0755 ${S}/scanner_setting.sh ${D}/boot
			install -m 0755 ${S}/mlsColorFilter.sh ${D}/boot
			break;;               	
	        yellowfinsd_bc)
        	        break;;
	        *)
        	        exit 1
        esac

	install -d ${D}${sysconfdir}/profile.d
	install -m 0755 ${S}/flasher.sh ${D}/${sysconfdir}/profile.d
}

COMPATIBLE_MACHINE_${PN} = "(yellowfinsd_bc|yellowfinsd_bv)"
