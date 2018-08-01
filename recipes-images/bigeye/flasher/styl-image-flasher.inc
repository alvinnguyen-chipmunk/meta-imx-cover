DESCRIPTION = "A console-only image flasher for STYL Bigeye platform."

LICENSE = "MIT"
IMAGE_ROOTFS_EXTRA_SPACE = "1024000"

require recipes-core/images/core-image-minimal.bb

# package management and dhcpserver
EXTRA_IMAGE_FEATURES_append = " package-management debug-tweaks"
CORE_IMAGE_EXTRA_INSTALL_append = " dhcp-server dnsmasq"


# Add kernel modules
IMAGE_INSTALL_append = " \
	kernel-modules \
"

# NetworkManager and relate packages
IMAGE_INSTALL_append = " \
	util-linux \
	usbutils \
	usb-modeswitch \
	net-tools \
	coreutils \
"

# SSH and SFTP server
IMAGE_INSTALL_append = " openssh openssh-sftp-server"

# Timezone
IMAGE_INSTALL_append = " tzdata tzdata-asia tzdata-europe"

# Utilities
IMAGE_INSTALL_append = " picocom resolvconf bash-completion wget icu fbset"
IMAGE_INSTALL_append = " rsync curl nano htop i2c-tools grep \
						 vim pkgconfig stressapptest systemd-analyze speedtest lftp python"

# More libraries that application needed
IMAGE_INSTALL_append = " libpng libconfig libarchive"

IMAGE_INSTALL_append = " bigeye-autologin"

# Add watchdog user application for watchdog timer reboot
IMAGE_INSTALL_append = " watchdog"

# Package support multi-bootscript
#IMAGE_INSTALL += "u-boot-script-styl"

# Flasher utils
IMAGE_INSTALL += "flasher-bigeye parted e2fsprogs-resize2fs"

# u-boot script bootup
IMAGE_INSTALL_append = " u-boot-bootscr"
