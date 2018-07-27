SUMMARY = "An application to test memory interface"
SECTION = "unittest"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRCREV = "${AUTOREV}"
SRC_URI = "git://github.com/stressapptest/stressapptest.git;protocol=https;branch=master"

S = "${WORKDIR}/git"

inherit autotools
