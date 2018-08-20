FILESEXTRAPATHS_append := "${THISDIR}/${PN}:"

SRC_URI += "file://qtenv.sh"

QT_CONFIG_BIGEYE = "\
	glib \
	fontconfig \
	linuxfb \
"
PACKAGECONFIG_BYMACHINE = "${@bb.utils.contains('MACHINE', 'bigeye', '${QT_CONFIG_BIGEYE}', '', d)}"

PACKAGECONFIG += "${PACKAGECONFIG_BYMACHINE}"

do_install_append_bigeye() {
	install -d ${D}/${sysconfdir}/profile.d
	install -m 0755 ${S}/../qtenv.sh ${D}/${sysconfdir}/profile.d
}
