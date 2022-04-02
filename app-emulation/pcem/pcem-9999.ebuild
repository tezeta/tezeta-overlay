# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

WX_GTK_VER="3.0-gtk3"
inherit cmake desktop flag-o-matic wxwidgets

DESCRIPTION="A PC emulator that specializes in running old operating systems and software"
HOMEPAGE="
	https://pcem-emulator.co.uk/
	https://github.com/sarah-walker-pcem/pcem/
"
if [[ ${PV} == 9999 ]]; then
    inherit git-r3
    EGIT_REPO_URI="https://github.com/sarah-walker-pcem/pcem.git"
else
	KEYWORDS="amd64"
	SRC_URI="https://pcem-emulator.co.uk/files/PCemV${PV}Linux.tar.gz"
fi

LICENSE="GPL-2+"
SLOT="0"
IUSE="+alsa debug extra-debug experimental networking pcap +plugin-engine"
REQUIRED_USE="extra-debug? ( debug ) pcap? ( networking )"

RDEPEND="
	alsa? ( media-libs/alsa-lib )
	pcap? ( net-libs/libpcap )
	experimental? ( media-libs/freetype )
	media-libs/libsdl2
	media-libs/openal
	x11-libs/wxGTK:${WX_GTK_VER}[tiff,X]
"
DEPEND="${RDEPEND}"

PATCHES=( )

src_prepare() {
	cmake_src_prepare
}

src_configure() {
	setup-wxwidgets

	EXPDEBUG=OFF
	use extra-debug && use experimental && EXPDEBUG=ON

	local mycmakeargs=(
		-DCMAKE_BUILD_TYPE=$(usex debug Debug Release)
		-DUSE_NETWORKING=$(usex networking ON OFF)
		-DUSE_PCAP_NETWORKING=$(usex pcap ON OFF)
		-DUSE_ALSA=$(usex alsa ON OFF)
		-DPLUGIN_ENGINE=$(usex plugin-engine ON OFF)

		#Experimental options
		-DUSE_EXPERIMENTAL=$(usex experimental ON OFF)
		-DUSE_EXPERIMENTAL_PGC=$(usex experimental ON OFF)
		-DUSE_EXPERIMENTAL_PRINTER=$(usex experimental ON OFF)

		#Extra debug options
		-DPCEM_SLIRP_DEBUG=$(usex extra-debug ON OFF)
		-DPCEM_RECOMPILER_DEBUG=$(usex extra-debug ON OFF)
		-DPCEM_NE2000_DEBUG=$(usex extra-debug ON OFF)
		-DPCEM_EMU8K_DEBUG_REGISTERS=$(usex extra-debug ON OFF)
		-DPCEM_SB_DSP_RECORD_DEBUG=$(usex extra-debug ON OFF)
		-DPCEM_MACH64_DEBUG=$(usex extra-debug ON OFF)
		-DPCEM_DEBUG_EXTRA=$(usex extra-debug ON OFF)

		#Experimental debug options
		-DPCEM_PRINTER_DEBUG=${EXPDEBUG}

		-DPCEM_LIB_DIR=/usr/$(get_libdir)
	)

	cmake_src_configure
}

src_install() {
	cmake_src_install

	newicon src/wx-ui/icons/32x32/widescreen.png pcem.png
	make_desktop_entry "pcem" "PCem" pcem "Development;Utility"
}

pkg_postinst() {
	elog "In order to use PCem, you will need some roms for various emulated systems."
	elog "You can either install globally for all users or locally for yourself."
	elog ""
	elog "To install globally, put your ROM files into '${ROOT}/usr/share/pcem/roms/<system>'."
	elog "To install locally, put your ROM files into '~/.pcem/roms/<system>'."
	elog ""
	elog "Additionally, you can emerge app-emulation/pcem-roms from tezeta-overlay."
}
