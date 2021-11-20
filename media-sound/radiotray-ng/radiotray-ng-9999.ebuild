# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
WX_GTK_VER="3.0-gtk3"

inherit cmake desktop git-r3 wxwidgets xdg

DESCRIPTION="a NeXT 68k workstation emulator"
HOMEPAGE="http://previous.alternative-system.com/"
EGIT_REPO_URI="https://github.com/ebruck/radiotray-ng.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug"

DEPEND="x11-libs/gtk+:3
	net-misc/curl[ssl]
	dev-libs/jsoncpp
	dev-libs/libxdg-basedir
	x11-libs/libnotify
	dev-libs/boost
	dev-libs/libbsd
	x11-libs/wxGTK:${WX_GTK_VER}[X]
	media-libs/gstreamer:1.0
	dev-libs/libappindicator
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_prepare() {
	cmake_src_prepare
}

src_configure() {
	setup-wxwidgets
	
	CMAKE_BUILD_TYPE=$(usex debug Debug Release)

	local mycmakeargs=(
		-DBUILD_TESTS=$(usex debug ON OFF)
	)

	cmake_src_configure
}

src_install() {
	cmake_src_install
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}
