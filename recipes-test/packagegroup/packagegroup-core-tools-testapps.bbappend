# If networkmanager has been integrated need to remove connman to avoid conflict when compile rootfs
RDEPENDS_${PN}_remove = " ${@bb.utils.contains('DISTRO_FEATURES', 'networkmanager', " connman-tools connman-tests connman-client", "", d)} "
