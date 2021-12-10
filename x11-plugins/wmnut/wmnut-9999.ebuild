# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit autotools git-r3

DESCRIPTION="a dockapp to monitor multiple UPSs statistics through Network UPS Tools"
HOMEPAGE="https://github.com/aquette/wmnut"
EGIT_REPO_URI="https://github.com/aquette/wmnut.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXpm
	>=sys-power/nut-2.2.1"
DEPEND="${RDEPEND}
	x11-base/xorg-proto
	x11-apps/xrandr"

src_prepare() {
	default
	eautoreconf
}
