# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
#note: sneedacity claims to depend on 3.1-gtk3, but compiling with system wxwidgets is broken currently.
#Only works with pg_overlay's wxGTK (not included)
#WX_GTK_VER="3.1-gtk3"

inherit cmake flag-o-matic xdg
#inherit wxwidgets

DESCRIPTION="Free crossplatform audio editor (formerly Audacity)"
HOMEPAGE="https://github.com/Sneeds-Feed-and-Seed/sneedacity"

if [[ "${PV}" != 9999 ]] ; then
	SRC_URI="https://github.com/Sneeds-Feed-and-Seed/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz
			$SRC_URI"
	S="${WORKDIR}/${P}"
    KEYWORDS="~amd64 ~arm64 ~mips ~ppc ~ppc64 ~x86"
else
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Sneeds-Feed-and-Seed/${PN}"
	EGIT_BRANCH="conan_removal"
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
	"${FILESDIR}/${P}-add-lockable-elements.patch"
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
		die "Building Sneedacity with system wxwidgets is currently broken, please remove the system-wxwidgets flag and try again."
	fi
	#use system-wxwidgets || setup-wxwidgets

	append-cxxflags -std=gnu++14

	# * always use system libraries if possible
	# * options listed in the order that cmake-gui lists them
	local mycmakeargs=(
#		--disable-dynamic-loading
		-Dsneedacity_lib_preference=system
		-Dsneedacity_use_expat=system
		-Dsneedacity_use_ffmpeg=$(usex ffmpeg loaded off)
		-Dsneedacity_use_flac=$(usex flac system off)
		-Dsneedacity_use_id3tag=$(usex id3tag system off)
		-Dsneedacity_use_ladspa=$(usex ladspa)
		-Dsneedacity_use_lame=system
		-Dsneedacity_use_lv2=$(usex lv2 system off)
		-Dsneedacity_use_libmad=$(usex mad system off)
		#fails to compile without midi, see https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=255186
		-Dsneedacity_use_midi=$(usex system-portmidi system local)
		-Dsneedacity_use_nyquist=local
		-Dsneedacity_use_ogg=$(usex ogg system off)
		-Dsneedacity_use_pa_alsa=$(usex alsa)
		-Dsneedacity_use_pa_jack=$(usex jack linked off)
		-Dsneedacity_use_pa_oss=$(usex oss)
		#-Dsneedacity_use_pch leaving it to the default behavior
		-Dsneedacity_use_portaudio=local # only 'local' option is present
		-Dsneedacity_use_portmixer=$(usex portmixer local off)
		-Dsneedacity_use_portsmf=local
		-Dsneedacity_use_sbsms=$(usex sbsms local off) # no 'system' option in configuration?
		-Dsneedacity_use_sndfile=system
		-Dsneedacity_use_soundtouch=system
		-Dsneedacity_use_soxr=system
		-Dsneedacity_use_twolame=$(usex twolame system off)
		-Dsneedacity_use_vamp=$(usex vamp system off)
		-Dsneedacity_use_vorbis=$(usex vorbis system off)
		-Dsneedacity_use_vst=$(usex vst)
		-Dsneedacity_use_wxwidgets=$(usex system-wxwidgets system local)
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
