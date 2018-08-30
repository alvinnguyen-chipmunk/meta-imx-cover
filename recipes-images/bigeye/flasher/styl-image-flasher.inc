DESCRIPTION = "A console-only image flasher for STYL Bigeye platform."
LICENSE = "MIT"

IMAGE_ROOTFS_EXTRA_SPACE = "2048000"

require recipes-core/images/core-image-minimal.bb

# Timezone
IMAGE_INSTALL_append = " tzdata tzdata-asia tzdata-europe"

# Utilities
IMAGE_INSTALL_append = " bash-completion rsync curl nano htop i2c-tools grep vim pkgconfig lftp python"

# More libraries that application needed
IMAGE_INSTALL_append = " libpng libconfig libarchive"

IMAGE_INSTALL_append = " autologin"

# Add watchdog user application for watchdog timer reboot
IMAGE_INSTALL_append = " watchdog"

# Flasher utils
IMAGE_INSTALL += "flasher-bigeye parted e2fsprogs-resize2fs"

# u-boot script bootup
IMAGE_INSTALL_append = " u-boot-script-cover"
