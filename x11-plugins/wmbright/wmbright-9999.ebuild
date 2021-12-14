# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit autotools git-r3

DESCRIPTION="A brightness control dockapp in the style of wmix"
HOMEPAGE="https://github.com/Jolmberg/wmbright"
EGIT_REPO_URI="https://github.com/Jolmberg/wmbright.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXpm"
DEPEND="${RDEPEND}
	x11-base/xorg-proto
	x11-apps/xrandr"

PATCHES=(
    "${FILESDIR}"/${P}-makefile.patch
)

src_install() {
	dobin wmbright
	dodoc {sample.wmbrightrc,README.md}
}
