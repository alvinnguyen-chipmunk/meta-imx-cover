LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRCREV = "f9f23d7a95608936ea7d839731dbd56f1667b7ed"
SRC_URI = "git://github.com/hyperrealm/libconfig.git;protocol=https;branch=master"

S = "${WORKDIR}/git"

inherit autotools
