# Copyright 1999-2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

inherit desktop eutils git-r3 xdg

DESCRIPTION="Super Mario 64 PC port with additional features"
HOMEPAGE="https://github.com/sm64pc/sm64ex"
EGIT_REPO_URI="https://github.com/sm64pc/sm64ex.git"
EGIT_BRANCH="nightly"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+60fps +baserom-us baserom-eu baserom-jp debug +bettercamera extdata nodrawdistance +optionsmenu textsaves +texturefix"
REQUIRED_USE="^^ ( baserom-us baserom-eu baserom-jp )"

DEPEND=">=dev-lang/python-3.6
	media-libs/libsdl2[X,alsa,joystick,opengl,sound,video]
	media-libs/glew
	media-libs/audiofile"
RDEPEND="$DEPEND"

src_prepare() {
	default

	use baserom-us && ROM_VER="us"
	use baserom-eu && ROM_VER="eu"
	use baserom-jp && ROM_VER="jp"

	einfo "Attempting to copy Super Mario 64 ROM file from distfiles..."
	if [ ! -f /usr/portage/distfiles/baserom.${ROM_VER}.z64 ]; then
		die "Please rename and copy your Super Mario 64 ROM file to /usr/portage/distfiles/baserom.${ROM_VER}.z64"
	fi

	cp -v /usr/portage/distfiles/baserom.${ROM_VER}.z64 ${S}

	use 60fps && eapply -p1 "${S}/enhancements/60fps_ex.patch"
}

src_compile() {
	emake VERSION=${ROM_VER} \
		DEBUG=$(usex debug 1 0) \
		BETTERCAMERA=$(usex bettercamera 1 0) \
		NODRAWINGDISTANCE=$(usex nodrawdistance 1 0) \
		TEXTURE_FIX=$(usex texturefix 1 0) \
		EXT_OPTIONS_MENU=$(usex optionsmenu 1 0) \
		EXTERNAL_DATA=$(usex extdata 1 0) \
		TEXTSAVES=$(usex textsaves 1 0) \
		|| die "Error: emake failed!"
}

src_install() {
	insinto /usr/share/${PN}
	doins -r ./build/${ROM_VER}_pc/*

	fperms +x /usr/share/${PN}/sm64.${ROM_VER}.f3dex2e
	dosym /usr/share/${PN}/sm64.${ROM_VER}.f3dex2e /usr/bin/sm64ex

	dodoc "README.md"

	doicon -s scalable ${FILESDIR}/sm64ex.svg
	domenu ${FILESDIR}/sm64ex.desktop
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}
