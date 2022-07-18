# Copyright 1999-2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

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

PATCHES=(
	"${FILESDIR}/${P}-shebang.patch"
	"${FILESDIR}/${P}-fix-broken-links.patch"
)

src_prepare() {
	default
}

src_install() {
	dobin stopwatch
	dodoc HISTORY README index.html
}
