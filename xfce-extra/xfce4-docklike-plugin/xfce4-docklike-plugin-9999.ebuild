# Copyright 1999-2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools xdg-utils git-r3

DESCRIPTION="A modern, docklike, minimalist taskbar for XFCE"
HOMEPAGE="https://github.com/nsz32/docklike-plugin"
EGIT_REPO_URI="https://github.com/nsz32/docklike-plugin.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/gtk+:3
	x11-libs/libwnck:3
	>=x11-libs/cairo-1.16
	>=xfce-base/libxfce4ui-4.14
	>=xfce-base/xfce4-panel-4.14
	x11-libs/libX11"
DEPEND="${RDEPEND}
	dev-util/intltool
	sys-devel/gettext
	virtual/pkgconfig"

src_configure() {
	./autogen.sh || die "autogen failed"

	local myconf=(
		--prefix="${EPREFIX}/usr" \
		--libexecdir="${EPREFIX}"/usr/$(get_libdir) \
		--docdir="${EPREFIX}/usr/share/doc/${PF}"
	)

	econf "${myconf[@]}" || die
}

src_install() {
	default
	find "${D}" -name '*.la' -delete || die
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
