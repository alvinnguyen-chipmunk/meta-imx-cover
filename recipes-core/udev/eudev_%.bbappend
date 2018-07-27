FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
#Based on: https://git.yoctoproject.org/git/meta-ti branch rocko

SRC_URI = "file://firmware.rules \
	   file://omap-tty.rules \
"

do_install_append() {
    install -m 0644 ${WORKDIR}/omap-tty.rules ${D}${sysconfdir}/udev/rules.d/
    install -m 0644 ${WORKDIR}/firmware.rules ${D}${sysconfdir}/udev/rules.d/
}
