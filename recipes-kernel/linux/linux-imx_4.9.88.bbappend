FILESEXTRAPATHS_append := "${THISDIR}/${PN}_${PV}:"

SRC_URI += "	file://defconfig file://Supported-STYL-Bigeye-Gateway-board.patch"

do_copy_defconfig () {
	exit 0
}
