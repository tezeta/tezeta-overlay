# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=(python3_{7,8,9,10})
WX_GTK_VER=3.0-gtk3

inherit cmake git-r3 flag-o-matic python-single-r1 wxwidgets xdg

DESCRIPTION="an easy-to-use multi-track audio editor and recorder, forked from Audacity"
HOMEPAGE="https://github.com/tenacityteam/tenacity"

EGIT_REPO_URI="https://github.com/tenacityteam/tenacity"
#git pulling nonexistant vcpkg submodule, filter it
EGIT_SUBMODULES=( '*' '-*vcpkg*' )
CMAKE_BUILD_TYPE="Release"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+midi id3tag mp3 ogg +vorbis +flac sbsms soundtouch ffmpeg +lv2 twolame +vst2 vamp"

RDEPEND="
	${PYTHON_DEPS}
	virtual/opengl
	sys-libs/zlib
	dev-libs/expat
	media-sound/lame
	media-libs/libsndfile
	media-libs/soxr
	dev-db/sqlite:3
	dev-libs/glib:2
	x11-libs/gtk+:3
	x11-libs/wxGTK:${WX_GTK_VER}
	media-libs/portaudio
	midi? (
		media-libs/portmidi:=
		media-libs/portsmf:=
	)
	id3tag? ( media-libs/libid3tag:= )
	mp3? ( media-libs/libmad )
	twolame? ( media-sound/twolame )
	ogg? ( media-libs/libogg )
	vorbis? ( media-libs/libvorbis )
	flac? ( media-libs/flac[cxx] )
	sbsms? ( media-libs/libsbsms )
	soundtouch? ( media-libs/libsoundtouch )
	ffmpeg? ( media-video/ffmpeg )
	lv2? (
		media-libs/lv2
		media-libs/lilv
		media-libs/suil
	)
	vamp? ( media-libs/vamp-plugin-sdk )
	vst2? ( x11-libs/gtk+:3[X] )
"
DEPEND="
	${RDEPEND}
	sys-devel/gettext
	app-text/scdoc
"

PATCHES=(
   	"${FILESDIR}/${P}-disable-ccache.patch"
	"${FILESDIR}/${P}-fix-vertical-track-resizing.patch"
	"${FILESDIR}/${P}-fix-gettimeofday.patch"
)

src_prepare() {
	cmake_src_prepare
}

src_configure() {
	setup-wxwidgets

	append-cxxflags -std=gnu++14

	local mycmakeargs=(
		-DBUILD_MANPAGE=ON
		-DMIDI=$(usex midi)
		-DID3TAG=$(usex id3tag)
		-DMP3_DECODING=$(usex mp3)
		-DMP2_ENCODING=$(usex twolame)
		-DOGG=$(usex ogg)
		-DVORBIS=$(usex vorbis)
		-DFLAC=$(usex flac)
		-DSBSMS=$(usex sbsms)
		-DSOUNDTOUCH=$(usex soundtouch)
		-DFFMPEG=$(usex ffmpeg)
		-DVAMP=$(usex vamp)
		-DLV2=$(usex lv2)
		-DVST2=$(usex vst2)
	)

	cmake_src_configure
}

src_install() {
	cmake_src_install
}
