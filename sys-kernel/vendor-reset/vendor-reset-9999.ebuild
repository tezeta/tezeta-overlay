# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 linux-mod

DESCRIPTION="kernel module that is capable of resetting hardware devices into a state where they can be re-initialized"
HOMEPAGE="https://github.com/gnif/vendor-reset"
EGIT_REPO_URI="https://github.com/gnif/vendor-reset.git"
EGIT_BRANCH="master"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

S="${WORKDIR}/${PN}-${PV}"

MODULE_NAMES="vendor-reset(vendor-reset:${S}/vendor-reset:${S})"
BUILD_TARGETS="all"

src_compile() {
	linux-mod_src_compile || die
}

src_install() {
	einstalldocs
	linux-mod_src_install || die
}
