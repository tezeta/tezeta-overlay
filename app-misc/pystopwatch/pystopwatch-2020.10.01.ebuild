# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8,9,10} )

inherit python-single-r1 git-r3

DESCRIPTION="a simple alarm/stopwatch/timer that can minimize to the tray"
HOMEPAGE="https://github.com/tezeta/pystopwatch"
EGIT_REPO_URI="https://github.com/tezeta/pystopwatch.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="x11-libs/gtk+:3[introspection]
		dev-python/pygobject:3
		${PYTHON_DEPS}"

DEPEND=""
REQUIRED_USE=${PYTHON_REQUIRED_USE}

src_prepare() {
	default
	unpack ./man/${PN}.1.gz
}

src_install() {
	python_doscript ${PN}
	doman ${PN}.1
}
