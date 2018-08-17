DESCRIPTION = "Builds an SDK with Qt5.9.4 for STYL Bigeye gateway platform"
LICENSE = "MIT"

require recipes-qt/meta/meta-toolchain-qt5.bb
require recipes-images/bigeye/images/styl-image-full.bb

IMAGE_INSTALL_append = " packagegroup-qt5-toolchain-target"
IMAGE_INSTALL_append = " nativesdk-packagegroup-qt5-toolchain-host"
IMAGE_INSTALL_append = " nativesdk-packagegroup-qt5-toolchain-host"