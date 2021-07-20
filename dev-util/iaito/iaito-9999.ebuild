# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 cmake-utils

DESCRIPTION="A Qt and C++ GUI for radare2 reverse engineering framework"
HOMEPAGE="http://www.iaito.re"
EGIT_REPO_URI="https://github.com/radareorg/iaito"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwebengine:5[widgets]
	dev-qt/qtwidgets:5
	=dev-util/radare2-9999"
RDEPEND="${DEPEND}"

CMAKE_USE_DIR="${S}/src"

src_install() {
	dobin "$BUILD_DIR/iaito"
}
