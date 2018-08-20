DESCRIPTION = "A console-only image for STYL Bigeye platform."

LICENSE = "MIT"

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
IMAGE_INSTALL_append = " packagegroup-qt5-full qtbase"

IMAGE_INSTALL_append = " ttf-dejavu-common ttf-dejavu-sans ttf-dejavu-sans-condensed ttf-dejavu-sans-mono ttf-dejavu-serif python  ttf-dejavu-serif-condensed"

IMAGE_INSTALL_remove = " qtwayland"

# qtcreator debug
#IMAGE_INSTALL_append = " packagegroup-qt5-qtcreator-debug"

# GDB support
IMAGE_INSTALL_append = " gdb gdbserver"

# Timezone
IMAGE_INSTALL_append = " tzdata tzdata-asia tzdata-europe"

# Utilities
IMAGE_INSTALL_append = " picocom resolvconf bash-completion wget icu fbset minicom"
IMAGE_INSTALL_append = " rsync curl nano htop i2c-tools grep vim pkgconfig stressapptest systemd-analyze lftp python"

# More libraries that application needed
IMAGE_INSTALL_append = " libpng libconfig libarchive"

IMAGE_INSTALL_append = " autologin"

# Add watchdog user application for watchdog timer reboot
IMAGE_INSTALL_append = " watchdog"

# Sysv init
IMAGE_INSTALL_append = " initscripts"

# Workaround for USB HUB
IMAGE_INSTALL_append = " udev-rules-styl"

# Bigeye test application
IMAGE_INSTALL_append = " bigeye-apps"

# Version rootfs and release_notes
IMAGE_INSTALL_append = " image-version release-notes"

# Support Splash Screen
IMAGE_INSTALL_append = " fbida"

# Other package for wifi
IMAGE_INSTALL_append = " crda libnl openssl"

# Other package support wireless from TI repositories

# # Pacakge for Wifi
IMAGE_INSTALL_append = " wl18xx-target-scripts wl18xx-calibrator wlconf"
IMAGE_INSTALL_append = " wl18xx-fw"
#IMAGE_INSTALL_append = " wl18xx-udev-workaround"

# # Packages for Bluetooth
#IMAGE_INSTALL_append = " uim bt-firmware bluez5 obexftp pulseaudio devmem2"

# Wireless stresstest
IMAGE_INSTALL_append = " wireless-stresstest"

# Auto configure wireless connection
IMAGE_INSTALL_append = " styl-usb-wireless-config"

# U-boot script bootup
IMAGE_INSTALL_append = " u-boot-script-cover"
