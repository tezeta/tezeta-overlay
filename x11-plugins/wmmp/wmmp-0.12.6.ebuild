# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit cmake autotools

DESCRIPTION="A Window Maker dock app client for Music Player Daemon(media-sound/mpd)"
HOMEPAGE="https://github.com/yogsothoth/wmmp"
SRC_URI="https://github.com/yogsothoth/wmmp/archive/refs/tags/${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="x11-libs/libXext
	x11-libs/libXpm"
DEPEND="${RDEPEND}"

src_install() {
	doman doc/WMmp.1
	dobin ${S}_build/bin/WMmp
}
