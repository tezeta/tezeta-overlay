# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit subversion xdg desktop

DESCRIPTION="a NeXT 68k workstation emulator"
HOMEPAGE="http://previous.alternative-system.com/"
SRC_URI=""
ESVN_REPO_URI="https://svn.code.sf.net/p/previous/code/trunk"
ESVN_PROJECT=Previous

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug +print pcap"

DEPEND="media-libs/libsdl2[X,opengl,sound,video]
	sys-libs/zlib
	print? (
		media-libs/libpng
	)
	pcap? (
		net-libs/libpcap
	)
"
RDEPEND="${DEPEND}"
BDEPEND="app-arch/unzip"

DOCS=()

PATCHES=(
	"${FILESDIR}"/previous-zlibfix.patch
	"${FILESDIR}"/previous-romdefault.patch
	"${FILESDIR}"/previous-cmakefix.patch
)

src_prepare() {
	default
}

src_configure() {
	if use debug; then
		debugarg="--enable-debug"
	fi

	#todo: use CMake directly for build instead of configure script
	#currently the included CMakeLists for Previous installs assets in
	#undesirable places, i.e. ROM files in /usr/bin, icon in /usr/share/previous.
	#a bigger concern is issues with soname deps
	./configure \
		--prefix=/usr \
		${debugarg}
}

src_install() {
	newbin ./src/Previous previous

	insinto /usr/share/previous
	doins ./src/ND_step1_v43.BIN
	doins ./src/Rev_0.8_v31.BIN
	doins ./src/Rev_1.0_v41.BIN
	doins ./src/Rev_2.5_v66.BIN
	doins ./src/Rev_3.3_v74.BIN

	dodoc readme.previous.txt networking.howto.txt filesharing.howto.txt

	unzip -q "${FILESDIR}"/PReV-icons-WOshad.zip
	for i in 16 32 128 256 512 ; do
		newicon -s "${i}" ./HighResOSX-WOshadow.iconset/icon_"${i}x${i}".png previous-app.png
	done

	domenu "${FILESDIR}"/previous.desktop
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}
