# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9,10,11} )

inherit desktop python-single-r1 git-r3

DESCRIPTION="simple GUI frontend for Blinkstick on Linux"
HOMEPAGE="https://github.com/tezeta/pyblinkgtk"
EGIT_REPO_URI="https://github.com/tezeta/pyblinkgtk.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="x11-libs/gtk+:3[introspection]
		dev-python/pygobject:3
		dev-python/blinkstick
		${PYTHON_DEPS}"

DEPEND=""
REQUIRED_USE=${PYTHON_REQUIRED_USE}

src_prepare() {
	default
}

src_install() {
	python_doscript ${PN}
}
