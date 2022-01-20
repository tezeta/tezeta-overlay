# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools git-r3

DESCRIPTION="LVM GUI tools from RedHat"
HOMEPAGE="https://github.com/i-nod/system-config-lvm"
EGIT_REPO_URI="https://github.com/i-nod/system-config-lvm.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="x11-libs/gtk+:3
		dev-python/pygobject
		sys-fs/lvm2"
RDEPEND="${DEPEND}"
BDEPEND=""

PATCHES=( "${FILESDIR}/${P}-desktop-categories.patch" 
		"${FILESDIR}/${P}-remove-consolehelper.patch" )

src_prepare() {
	default
	eautoreconf
}
