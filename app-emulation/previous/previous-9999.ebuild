# Copyright 1999-2020 Gentoo Authors
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
KEYWORDS=""
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
BDEPEND=""

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
	./configure \
		--prefix=/usr \
		${debugarg}		
}

src_install() {
	#emake DESTDIR="$D" install
	dobin ./src/Previous

	insinto /usr/share/previous
	doins ./src/ND_step1_v43_eeprom.bin
	doins ./src/Rev_1.0_v41.BIN
	doins ./src/Rev_2.5_v66.BIN
	doins ./src/Rev_3.3_v74.BIN

	dodoc readme.previous.txt networking.howto.txt filesharing.howto.txt

	unzip -q "${FILESDIR}"/PReV-icons-WOshad.zip
	cd ./HighResOSX-WOshadow.iconset

	newicon -s 16 icon_16x16.png previous-app.png
	newicon -s 32 icon_32x32.png previous-app.png
	newicon -s 128 icon_128x128.png previous-app.png
	newicon -s 256 icon_256x256.png previous-app.png
	newicon -s 512 icon_512x512.png previous-app.png
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