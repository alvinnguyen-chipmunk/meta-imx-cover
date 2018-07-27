#@TYPE: Machine
#@NAME: Bigeye Gateway platform
#@SOC: i.MX6ULL
#@DESCRIPTION: Machine configuration for STYL Bigeye Gateway platform
#@MAINTAINER: Alvin Nguyen <alvin.nguyen@styl.solutions>

MACHINEOVERRIDES =. "mx6:mx6ul:mx6ull:"

include conf/machine/include/imx-base.inc
include conf/machine/include/tune-cortexa7.inc
require conf/machine/include/styl-imx6ull-default-versions.inc
require conf/machine/include/styl-imx6ull-default-providers.inc
require conf/machine/include/styl-imx6ull-default-settings.inc

MACHINE_FIRMWARE_append = " firmware-imx-epdc"

OPTEE_BIN_EXT = "6ullevk"

SERIAL_CONSOLE = "115200 ttymxc0"

###################### UBOOT ###################################################
UBOOT_CONFIG ??= "${@bb.utils.contains('COMBINED_FEATURES', 'optee', 'sd-optee', 'sd', d)}"
UBOOT_CONFIG[sd] = "mx6ull_14x14_evk_config,sdcard"
UBOOT_CONFIG[emmc] = "mx6ull_14x14_evk_emmc_config,sdcard"
UBOOT_CONFIG[nand] = "mx6ull_14x14_evk_nand_config,ubifs"
UBOOT_CONFIG[qspi1] = "mx6ull_14x14_evk_qspi1_config"
UBOOT_CONFIG[mfgtool] = "mx6ull_14x14_evk_config"
UBOOT_CONFIG[sd-optee] = "mx6ull_14x14_evk_optee_config"
UBOOT_CONFIG[bigeye] = "mx6ull_14x14_bigeye_config"

###################### ROOTFS ##################################################
IMAGE_FSTYPES += " sdcard tar.bz2"

BOOT_SPACE = "20480"
