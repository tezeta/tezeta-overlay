# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A collection of required ROM files for PCem"
HOMEPAGE="https://github.com/BaRRaKudaRain/PCem-ROMs"
if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/BaRRaKudaRain/PCem-ROMs.git"
else
	KEYWORDS="amd64"
	SRC_URI="https://github.com/BaRRaKudaRain/PCem-ROMs/archive/refs/tags/v${PV}.0.zip"
	S="${WORKDIR}/PCem-ROMs-${PV}.0/"
fi

LICENSE="all-rights-reserved"
SLOT="0"
IUSE=""

RDEPEND="app-emulation/pcem"
DEPEND="${RDEPEND}"

src_prepare() {
	default
	find "${S}" -name 'roms.txt' -delete || die
}

src_install() {
	insinto /usr/share/pcem/roms
	doins -r ${S}/.
}

