# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit autotools git-r3

DESCRIPTION="NetworkManager frontend as a Window Maker dockapp"
HOMEPAGE="https://github.com/d-torrance/wmnm"
EGIT_REPO_URI="https://github.com/d-torrance/wmnm.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXpm"
DEPEND="${RDEPEND}
	x11-base/xorg-proto
	x11-apps/xrandr"

src_prepare() {
	eautoreconf
	eapply_user
}
