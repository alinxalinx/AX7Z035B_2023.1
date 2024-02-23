#
# This file is the autostart recipe.
#

SUMMARY = "Simple autostart application"
SECTION = "PETALINUX/apps"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "file://autostart \
	"

S = "${WORKDIR}"

inherit update-rc.d

INITSCRIPT_NAME = "autostart"
INITSCRIPT_PARAMS = "start 99 5 ."

do_install() {
	install -d ${D}${sysconfdir}/init.d
	install -m 0755 ${S}/autostart ${D}${sysconfdir}/init.d/autostart
}

RDEPENDS_${PN} += "bash"
