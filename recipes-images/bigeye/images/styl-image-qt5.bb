DESCRIPTION = "Builds an STYL image with a GUI and Qt5 content"
LICENSE = "MIT"

require recipes-fsl/images/fsl-image-qt5-validation-imx.bb
require recipes-images/bigeye/images/styl-image-minimal.bb

QT5_FONTS_append = " ttf-dejavu-common ttf-dejavu-sans ttf-dejavu-sans-condensed ttf-dejavu-sans-mono ttf-dejavu-serif python  ttf-dejavu-serif-condensed"

IMAGE_INSTALL_remove = " qtwayland"
