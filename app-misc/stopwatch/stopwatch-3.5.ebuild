# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="Graphical stopwatch with optional countdown and millisecond accuracy"
HOMEPAGE="http://expect.sourceforge.net/stopwatch/"
SRC_URI="http://expect.sourceforge.net/$PN/$PN.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="
	dev-lang/tcl
	dev-lang/tk"
RDEPEND="${DEPEND}"

# directory name in tarball is not consistent with package version
MY_PV="3.4"
S="${WORKDIR}/${PN}-${MY_PV}"

src_prepare() {
	epatch "${FILESDIR}/${P}-shebang.patch"
	epatch "${FILESDIR}/${P}-fix-broken-links.patch"
	epatch_user
}

src_install() {
	dobin stopwatch
	dodoc HISTORY README index.html
}
