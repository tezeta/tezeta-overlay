# Copyright 1999-2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

DESCRIPTION="A lunar landing simulation for X"
HOMEPAGE=""
SRC_URI="https://mirrors.slackware.com/slackware/slackware-14.2/source/xap/xgames/${PN}.tar.gz"

LICENSE="xlander"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND="x11-base/xorg-server"

S=${WORKDIR}/${PN}

PATCHES=(
	"${FILESDIR}"/${PN}-makefile.patch
	"${FILESDIR}"/${PN}-fixes.patch
)

src_prepare() {
	default
}

src_install() {
	dodoc README
	newman "${PN}.man" "${PN}.6"
	dobin "${PN}"
}
