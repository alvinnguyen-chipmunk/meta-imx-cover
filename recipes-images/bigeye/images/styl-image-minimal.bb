DESCRIPTION = "Builds an STYL basic image without GUI and Qt content."
LICENSE = "MIT"

require recipes-core/images/core-image-minimal.bb
require recipes-images/bigeye/images/styl-image-fb.inc
require recipes-images/bigeye/images/styl-image-remove.inc
