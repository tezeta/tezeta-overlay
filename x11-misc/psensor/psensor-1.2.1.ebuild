# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit autotools gnome2-utils xdg

DESCRIPTION="A graphical hardware temperature monitor for Linux"
HOMEPAGE="https://wpitchoune.net/psensor/"

if [[ ${PV} == 9999 ]]; then
    inherit git-r3
    EGIT_REPO_URI="https://gitlab.com/jeanfi/psensor.git"
else
    KEYWORDS="~amd64 ~x86"
	SRC_URI="https://wpitchoune.net/psensor/files/${P}.tar.gz"
	PATCHES=( "${FILESDIR}"/psensor-fix-gcc-ident.patch 
		"${FILESDIR}"/psensor-server-enum.patch )
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="+disks +gtop"

RDEPEND="
	disks? ( dev-libs/libatasmart
			sys-fs/udisks:2 )
	gtop? ( gnome-base/libgtop )
	>=sys-apps/lm-sensors-3
	dev-libs/glib:2
	x11-libs/gtk+:3
"
DEPEND="
	${RDEPEND}
"
BDEPEND="
	virtual/pkgconfig
"

src_prepare() {
	default
	eautoreconf
}

src_install() {
	default
}

pkg_postinst() {
	gnome2_schemas_update
	xdg_icon_cache_update
}

pkg_postrm() {
	gnome2_schemas_update
	dg_icon_cache_update
}
