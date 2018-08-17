# Copyright (C) 2018 O.S. Systems Software LTDA.

DESCRIPTION = "Target packages for Qt5 on target"
LICENSE = "MIT"

inherit packagegroup

PACKAGEGROUP_DISABLE_COMPLEMENTARY = "1"

# Requires Ruby to work
USE_RUBY = " \
    qtquick1 \
    qtquick1-plugins \
    ${@bb.utils.contains('DISTRO_FEATURES', 'opengl', 'qtquick1-qmlplugins', '', d)} \
    qttranslations-qtquick1 \
    qtwebkit \
    ${@bb.utils.contains('DISTRO_FEATURES', 'opengl', 'qtwebkit-qmlplugins', '', d)} \
"

# Requires Wayland to work
USE_WAYLAND = " \
    qtwayland \
    qtwayland-plugins \
    qtwayland-tools \
"

# Requires X11 to work
USE_X11 = " \
    qtx11extras \
"

RDEPENDS_${PN} += " \
    packagegroup-core-standalone-sdk-target \
    libsqlite3 \
    ${@bb.utils.contains('DISTRO_FEATURES', 'opengl', 'qt3d', '', d)} \
    ${@bb.utils.contains('DISTRO_FEATURES', 'opengl', 'qt3d-qmlplugins', '', d)} \
    qtbase \
    qtbase-plugins \
    qttranslations-qt \
    qttranslations-qtbase \
    qttranslations-qtconfig \
    qttranslations-qthelp \
    qtconnectivity \
    ${@bb.utils.contains('DISTRO_FEATURES', 'opengl', 'qtconnectivity-qmlplugins', '', d)} \
    qttranslations-qtconnectivity \
    qtdeclarative \
    ${@bb.utils.contains('DISTRO_FEATURES', 'opengl', 'qtdeclarative-qmlplugins', '', d)} \
    qtdeclarative-tools \
    qttranslations-qmlviewer \
    qttranslations-qtdeclarative \
    qtenginio \
    ${@bb.utils.contains('DISTRO_FEATURES', 'opengl', 'qtenginio-qmlplugins', '', d)} \
    ${@bb.utils.contains('DISTRO_FEATURES', 'opengl', 'qtgraphicaleffects-qmlplugins', '', d)} \
    qtimageformats \
    qtimageformats-plugins \
    qtlocation \
    qtlocation-plugins \
    ${@bb.utils.contains('DISTRO_FEATURES', 'opengl', 'qtlocation-qmlplugins', '', d)} \
    qttranslations-qtlocation \
    qtmultimedia \
    qtmultimedia-plugins \
    ${@bb.utils.contains('DISTRO_FEATURES', 'opengl', 'qtmultimedia-qmlplugins', '', d)} \
    qttranslations-qtmultimedia \
    qtscript \
    qttranslations-qtscript \
    qtsensors \
    qtsensors-plugins \
    ${@bb.utils.contains('DISTRO_FEATURES', 'opengl', 'qtsensors-qmlplugins', '', d)} \
    qtserialport \
    qtserialbus \
    qtsvg \
    qtsvg-plugins \
    qtsystems \
    ${@bb.utils.contains('DISTRO_FEATURES', 'opengl', 'qtsystems-qmlplugins', '', d)} \
    qttools \
    qttools-tools \
    ${@bb.utils.contains('DISTRO_FEATURES', 'wayland', '${USE_WAYLAND}', '', d)} \
    ${USE_RUBY} \
    ${@bb.utils.contains('DISTRO_FEATURES', 'x11', '${USE_X11}', '', d)} \
    qtwebsockets \
    ${@bb.utils.contains('DISTRO_FEATURES', 'opengl', 'qtwebsockets-qmlplugins', '', d)} \
    qttranslations-qtwebsockets \
    qtwebchannel \
    ${@bb.utils.contains('DISTRO_FEATURES', 'opengl', 'qtwebchannel-qmlplugins', '', d)} \
    qtxmlpatterns \
    qttranslations-qtxmlpatterns \
    qtquickcontrols2 \
	${@bb.utils.contains('DISTRO_FEATURES', 'opengl', 'qtcanvas3d', '', d)} \
	${@bb.utils.contains('DISTRO_FEATURES', 'opengl', 'qtcanvas3d-qmlplugins', '', d)} \
"

RRECOMMENDS_${PN} += " \
    qtquickcontrols-qmlplugins \
    qttools-plugins \
"
