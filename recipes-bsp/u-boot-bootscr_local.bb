FILESEXTRAPATHS_append := "${THISDIR}/${PN}:"
DEPENDS = "u-boot-mkimage-native"


SRC_URI += "	file://bigeye-emmc.script	\
		file://bigeye-net.script  	\
		file://bigeye-release.script  	\
		file://bigeye-sdcard.script	\
"

STYL_BOOTSCRIPT_SRC ?= "${WORKDIR}"
STYL_BOOTSCRIPT_SRC_${MACHINE} ?= "${WORKDIR}/${MACHINE}"
STYL_BOOTSCRIPT_DES ?= "${WORKDIR}/output"

do_compile_append() {
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

do_deploy_append() {
    install -d ${DEPLOY_DIR_IMAGE}
    install -m 0644 ${STYL_BOOTSCRIPT_DES}/* ${DEPLOY_DIR_IMAGE}/
}

PACKAGE_ARCH = "${MACHINE_ARCH}"
COMPATIBLE_MACHINE = "(bigeye)"

