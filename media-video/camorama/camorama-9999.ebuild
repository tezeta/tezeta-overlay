# Copyright 1999-2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools git-r3 gnome2-utils xdg-utils

DESCRIPTION="A webcam application featuring various image filters"
HOMEPAGE="https://github.com/alessio/camorama"
EGIT_REPO_URI="https://github.com/alessio/camorama.git"

LICENSE="GPL-2"
SLOT="3"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="
	gnome-base/gnome-common
	x11-libs/cairo
	x11-libs/gtk+:3
	media-libs/libv4l
"
DEPEND="${RDEPEND}
	dev-util/intltool
	virtual/pkgconfig
	sys-devel/gettext
"

src_configure() {
	./autogen.sh || die "autogen failed"
	econf || die
}

pkg_postinst() {
	gnome2_schemas_update
	xdg_icon_cache_update
}

pkg_postrm() {
	gnome2_schemas_update
	xdg_icon_cache_update
}
