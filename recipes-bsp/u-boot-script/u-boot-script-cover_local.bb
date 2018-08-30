DESCRIPTION = "Custom bootscript for STYL's board"
LICENSE = "CLOSED"
LIC_FILES_CHKSUM = ""
DEPENDS = "u-boot-mkimage-native"

FILESEXTRAPATHS_append := "${THISDIR}/${PN}:"

SRC_URI += "	file://bigeye-sdcard.script	\
		file://bigeye-wifi.script  	\
		file://bigeye-manual.script  	\
		file://bigeye-flasher.script  	\
"

DESTDIR = "/boot"
S = "${WORKDIR}"

STYL_BOOTSCRIPT_SRC ?= "${WORKDIR}"
STYL_BOOTSCRIPT_SRC_${MACHINE} ?= "${WORKDIR}/${MACHINE}"
STYL_BOOTSCRIPT_DES ?= "${WORKDIR}/output"

do_compile() {
        mkdir -p ${STYL_BOOTSCRIPT_SRC}
        mkdir -p ${STYL_BOOTSCRIPT_DES}
        cp ${WORKDIR}/*.script ${STYL_BOOTSCRIPT_SRC}

        for file in ${STYL_BOOTSCRIPT_SRC}/*
        do
                OF=$(basename "${file}")
                OF=${OF%.*}.scr
                uboot-mkimage -A arm -O linux -T script -C none -a 0 -e 0       \
                -n "STYL u-boot bootscript" -d ${file}                          \
                ${STYL_BOOTSCRIPT_DES}/${OF}
        done
}

do_install() {
    install -d ${D}/${DESTDIR}
    install -m 0644 ${STYL_BOOTSCRIPT_DES}/* ${D}/${DESTDIR}/

    install -d ${DEPLOY_DIR_IMAGE}
    echo "install -m 0644 ${STYL_BOOTSCRIPT_DES}/* ${DEPLOY_DIR_IMAGE}"
    install -m 0644 ${STYL_BOOTSCRIPT_DES}/* ${DEPLOY_DIR_IMAGE}/
}

FILES_${PN} = "${DESTDIR}/*"

PACKAGE_ARCH = "${MACHINE_ARCH}"
COMPATIBLE_MACHINE = "(bigeye)"

