# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
#note: tenacity claims to depend on 3.1-gtk3, but compiling with system wxwidgets is broken currently.
#Only works with pg_overlay's wxGTK (not included)
WX_GTK_VER="3.1-gtk3"

inherit cmake flag-o-matic wxwidgets xdg

DESCRIPTION="an easy-to-use multi-track audio editor and recorder, forked from Audacity"
HOMEPAGE="https://github.com/tenacityteam/tenacity"

if [[ "${PV}" != 9999 ]] ; then
	SRC_URI="https://github.com/tenacityteam/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz
			$SRC_URI"
	S="${WORKDIR}/${P}"
    KEYWORDS="~amd64 ~arm64 ~mips ~ppc ~ppc64 ~x86"
else
	inherit git-r3
	EGIT_REPO_URI="https://github.com/tenacityteam/${PN}"
	CMAKE_BUILD_TYPE="Release"
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~mips ppc ppc64 x86"
IUSE="alsa doc ffmpeg +flac id3tag jack +ladspa +lv2 mad ogg oss +portmixer
	sbsms system-portmidi system-wxwidgets twolame vamp +vorbis +vst"

RESTRICT="test network-sandbox"

RDEPEND="dev-libs/expat
	media-libs/libsndfile
	media-libs/libsoundtouch
	media-libs/portaudio[alsa?]
	media-libs/soxr
	>=media-sound/lame-3.100-r3
	system-wxwidgets? ( x11-libs/wxGTK:3.1-gtk3[X] )
	alsa? ( media-libs/alsa-lib )
	ffmpeg? ( media-video/ffmpeg:= )
	flac? ( media-libs/flac[cxx] )
	id3tag? ( media-libs/libid3tag )
	jack? ( virtual/jack )
	lv2? (
		dev-libs/serd
		dev-libs/sord
		>=media-libs/lilv-0.24.6-r2
		media-libs/lv2
		media-libs/sratom
		media-libs/suil
	)
	mad? ( >=media-libs/libmad-0.15.1b )
	ogg? ( media-libs/libogg )
	system-portmidi? ( media-libs/portmidi )
	sbsms? ( media-libs/libsbsms )
	twolame? ( media-sound/twolame )
	vamp? ( media-libs/vamp-plugin-sdk )
	vorbis? ( media-libs/libvorbis )
"

DEPEND="${RDEPEND}"
BDEPEND="app-arch/unzip
	sys-devel/gettext
	virtual/pkgconfig
	dev-util/conan
"

PATCHES=(
   	#"${FILESDIR}/${P}-disable-ccache.patch"
	"${FILESDIR}/${P}-fix-vertical-track-resizing.patch"
	"${FILESDIR}/${P}-fix-gettimeofday.patch"
	"${FILESDIR}/${P}-add-missing-include-portaudio.patch"
	"${FILESDIR}/${P}-about-dialog-fix-flag-checks.patch"
)

src_prepare() {
	cmake_src_prepare

	#MIDI_OUT depends on midi
#	if ! use midi; then
#		sed -i -e 's/^ *MIDI_OUT//g' src/Experimental.cmake || die
#	fi
}

src_configure() {
	#todo: fix issues finding system wxwidgets with conan
	if use system-wxwidgets; then
		die "Building Tenacity with system wxwidgets is currently broken, please remove the system-wxwidgets flag and try again."
	fi
	#use system-wxwidgets || setup-wxwidgets

	append-cxxflags -std=gnu++14

	# * always use system libraries if possible
	# * options listed in the order that cmake-gui lists them
	local mycmakeargs=(
#		--disable-dynamic-loading
		-Dlib_preference=system
		-Duse_expat=system
		-Duse_ffmpeg=$(usex ffmpeg loaded off)
		-Duse_flac=$(usex flac system off)
		-Duse_id3tag=$(usex id3tag system off)
		-Duse_ladspa=$(usex ladspa)
		-Duse_lame=system
		-Duse_lv2=$(usex lv2 system off)
		#fails to compile without midi, see https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=255186
		-Duse_libmad=$(usex mad system off)
		-Duse_midi=$(usex system-portmidi system local)
		-Duse_nyquist=local
		-Duse_ogg=$(usex ogg system off)
		-Duse_pa_alsa=$(usex alsa)
		-Duse_pa_jack=$(usex jack linked off)
		-Duse_pa_oss=$(usex oss)
		#-Duse_pch leaving it to the default behavior
		-Duse_portaudio=local # only 'local' option is present
		-Duse_portmixer=$(usex portmixer local off)
		-Duse_portsmf=local
		-Duse_sbsms=$(usex sbsms local off) # no 'system' option in configuration?
		-Duse_sndfile=system
		-Duse_soundtouch=system
		-Duse_soxr=system
		-Duse_twolame=$(usex twolame system off)
		-Duse_vamp=$(usex vamp system off)
		-Duse_vorbis=$(usex vorbis system off)
		-Duse_vst=$(usex vst)
		-Duse_wxwidgets=$(usex system-wxwidgets system local)
	)

	cmake_src_configure

	# if git is not installed, this (empty) file is not being created and the compilation fails
	# so we create it manually
	touch "${BUILD_DIR}/src/private/RevisionIdent.h" || die "failed to create file"

}

src_install() {
	cmake_src_install

	# Remove bad doc install
	rm -r "${ED}"/usr/share/doc || die

	if use doc ; then
		docinto html
		dodoc -r "${WORKDIR}"/help/manual/{m,man,manual}
		dodoc "${WORKDIR}"/help/manual/{favicon.ico,index.html,quick_help.html}
		dosym ../../doc/${PF}/html /usr/share/${PN}/help/manual
	fi
}
