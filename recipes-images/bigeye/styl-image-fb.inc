DESCRIPTION = "A console-only image for STYL Bigeye platform."

LICENSE = "MIT"

require recipes-core/images/core-image-minimal.bb

# package management and dhcpserver
EXTRA_IMAGE_FEATURES_append = " package-management debug-tweaks eclipse-debug"
CORE_IMAGE_EXTRA_INSTALL_append = " dhcp-server dnsmasq"

# Populate SDK with Qt5
inherit populate_sdk_qt5

# NetworkManager and relate packages
IMAGE_INSTALL_append = "\
	networkmanager 	\
	modemmanager 	\
	mobile-broadband-provider-info \
	util-linux 	\
	usbutils 	\
	usb-modeswitch 	\
	ppp 		\
	net-tools 	\
"

# SSH and SFTP server
IMAGE_INSTALL_append = " openssh openssh-sftp-server"

# Qt support
IMAGE_INSTALL += "packagegroup-qt5-full qtbase"

IMAGE_INSTALL += "ttf-dejavu-common ttf-dejavu-sans ttf-dejavu-sans-condensed ttf-dejavu-sans-mono ttf-dejavu-serif python  ttf-dejavu-serif-condensed"

IMAGE_INSTALL_remove = " qtwayland"

# GDB support
IMAGE_INSTALL_append = " gdb gdbserver"

# Timezone
IMAGE_INSTALL_append = " tzdata tzdata-asia tzdata-europe"

# Utilities
IMAGE_INSTALL_append = " picocom resolvconf bash-completion wget icu fbset"
IMAGE_INSTALL_append = " rsync curl nano htop i2c-tools grep vim pkgconfig stressapptest systemd-analyze lftp python"

# More libraries that application needed
IMAGE_INSTALL_append = " libpng libconfig libarchive"

IMAGE_INSTALL_append = " styl-autologin"

# Add watchdog user application for watchdog timer reboot
IMAGE_INSTALL_append = " watchdog"

# Sysv init
IMAGE_INSTALL += "initscripts"

# Workaround for USB HUB
IMAGE_INSTALL += "udev-rules-styl"

# Bigeye test application
IMAGE_INSTALL += "bigeye-testapp"

# Version rootfs and release_notes
IMAGE_INSTALL += "image-version release-notes"

# Support Splash Screen
IMAGE_INSTALL += "fbida"

# Other package for wifi
IMAGE_INSTALL += "crda libnl openssl"

# Other package support wireless from TI repositories

# # Pacakge for Wifi
IMAGE_INSTALL += "wl18xx-target-scripts wl18xx-calibrator wlconf"
IMAGE_INSTALL += "wl18xx-fw"

# # Packages for Bluetooth
#IMAGE_INSTALL += "uim bt-firmware bluez5 obexftp pulseaudio devmem2"

# Wireless stresstest
IMAGE_INSTALL += "wireless-stresstest"

# Auto configure wireless connection
IMAGE_INSTALL += "styl-usb-wireless-config"
