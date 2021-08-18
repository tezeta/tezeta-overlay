# Copyright 1999-2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

DESCRIPTION="Adobe Flash Player standalone projector"
HOMEPAGE="https://www.adobe.com/support/flashplayer/debug_downloads.html"

SRC_URI="https://fpdownload.macromedia.com/pub/flashplayer/updaters/32/flash_player_sa_linux.x86_64.tar.gz
		debugger? ( https://fpdownload.macromedia.com/pub/flashplayer/updaters/32/flash_player_sa_linux_debug.x86_64.tar.gz )"

LICENSE="Adobe"
SLOT="32"
KEYWORDS="~amd64"
IUSE="debugger"

DEPEND=""
RDEPEND="${DEPEND}
		x11-libs/gtk+:2"

S="${WORKDIR}"

src_install(){
	if ( use debugger ); then
		newbin flashplayerdebugger flashplayer
		echo FLASHPLAYER_DEBUGGER="${DESTTREE}/bin/flashplayer" > 99adobe-flashplayer-debugger
	else
		dobin flashplayer
	fi
}
