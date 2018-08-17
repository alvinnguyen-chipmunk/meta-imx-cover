DESCRIPTION = "Builds an STYL Bigeye gateway image full feature"
LICENSE = "MIT"

require recipes-images/bigeye/images/styl-image-minimal.bb
require recipes-images/bigeye/images/styl-image-console.bb
require recipes-images/bigeye/images/styl-image-gui.bb
require recipes-images/bigeye/images/styl-image-qt5.bb
