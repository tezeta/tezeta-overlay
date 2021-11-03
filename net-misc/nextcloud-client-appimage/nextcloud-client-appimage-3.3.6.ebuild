# Copyright 1999-2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit xdg desktop

DESCRIPTION="Desktop Syncing Client for Nextcloud"
HOMEPAGE="https://github.com/nextcloud/desktop"
SRC_URI="https://github.com/nextcloud/desktop/releases/download/v${PV}/Nextcloud-${PV}-x86_64.AppImage"

LICENSE="GPL-2.0"
SLOT="0"
KEYWORDS="amd64"
IUSE="minimal"

DEPEND=""
RDEPEND="${DEPEND}
		!!net-misc/nextcloud-client"

RESTRICT="binchecks strip"

S="${WORKDIR}"

src_unpack() {
	true
}

src_install() {
	newbin ${DISTDIR}/Nextcloud-${PV}-x86_64.AppImage nextcloud

	if ! use minimal; then
		elog "Installing shared files (-minimal)"
		tar xzf "${FILESDIR}"/nextcloud-client-appimage-shared.tar.gz -C $D || die
	fi

}


pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
	elog "Documentation and man pages not installed with appimage variant"
}
