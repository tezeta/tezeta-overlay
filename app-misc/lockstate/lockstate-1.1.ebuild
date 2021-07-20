# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit xdg desktop

DESCRIPTION="monitors lock keys and shows status icons in system tray"
HOMEPAGE="http://murga-linux.com/puppy/viewtopic.php?t=110710"
SRC_URI="https://archive.org/download/Puppy_Linux_Forum_Pets/LockState-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="x11-libs/gtk+:2"
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/LockState-${PV}"

src_configure() {
	true
}

src_compile() {
	cd ./lockstate/src/
	default
}

src_install() {
	cd ./lockstate/src
	dobin lockstate
	doicon lockstate.png lockstate.svg
	domenu lockstate.desktop
}


pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}
