# Copyright 1999-2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Desktop Syncing Client for Nextcloud"
HOMEPAGE="https://github.com/nextcloud/desktop"
SRC_URI="https://github.com/nextcloud/desktop/releases/download/v${PV}/Nextcloud-${PV}-x86_64.AppImage"

LICENSE="GPL-2.0"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
		!!net-misc/nextcloud-client"

RESTRICT="binchecks strip"

S="${WORKDIR}"

src_install() {
	newbin ${DISTDIR}/Nextcloud-${PV}-x86_64.AppImage nextcloud
}
