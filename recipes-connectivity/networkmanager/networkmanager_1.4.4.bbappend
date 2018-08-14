PACKAGECONFIG = "nss ifupdown netconfig dhclient dnsmasq \
    ${@bb.utils.contains('DISTRO_FEATURES','systemd','systemd','consolekit',d)} \
    ${@bb.utils.contains('DISTRO_FEATURES','bluetooth','${BLUEZ}','',d)} \
    ${@bb.utils.contains('MACHINE_FEATURES','wifi','wifi','',d)} \
    ${@bb.utils.contains('DISTRO_FEATURES','wifi','wifi','',d)} \
    ${@bb.utils.contains('MACHINE_FEATURES','gsm','modemmanager ppp','',d)} \
"
