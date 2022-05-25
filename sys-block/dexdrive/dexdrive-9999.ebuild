# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit linux-mod

if [[ ${PV} == *9999* ]]; then
	EGIT_REPO_URI="https://github.com/fbriere/linux-dexdrive.git"
	EGIT_BRANCH="master"
	inherit git-r3
else
	KEYWORDS="~amd64"
	SRC_URI="https://github.com/fbriere/linux-dexdrive/archive/v${PV}.tar.gz -> ${P}.tar.gz"
fi

DESCRIPTION="Linux block driver for the InterAct DexDrive"
HOMEPAGE="https://github.com/fbriere/linux-dexdrive"
LICENSE="GPL-2"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}"

MODULE_NAMES="dexdrive(misc)"

PATCHES=( "${FILESDIR}/${PN}-mutedebug.patch" )

pkg_setup() {
	linux-mod_pkg_setup

	BUILD_TARGETS="modules"
	BUILD_PARAMS="CC=$(tc-getCC) KERNEL_BUILD=${KERNEL_DIR}"
}

src_compile() {
	set_arch_to_kernel
	linux-mod_src_compile

	emake dexattach
}

src_install() {
	set_arch_to_kernel
	linux-mod_src_install

	insinto /etc/modules-load.d/
	newins "${FILESDIR}"/modload.conf dexdrive.conf

	dobin dexattach
}
