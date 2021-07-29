# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit autotools git-r3

DESCRIPTION="a command line mixer for PulseAudio"
HOMEPAGE="https://github.com/falconindy/ponymix"
EGIT_REPO_URI="https://github.com/falconindy/ponymix.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="bash-completions zsh-completions"

DEPEND="media-sound/pulseaudio
		bash-completions? (
			app-shells/bash
		)
		zsh-completions? (
			app-shells/zsh
		)
"
RDEPEND="${DEPEND}"

src_install() {
	dobin ponymix

	if use bash-completions; then
		insinto /usr/share/bash-completion/completions
		newins bash-completion ponymix
	fi

	if use zsh-completions; then
		insinto /usr/share/zsh/site-functions 
		newins zsh-completion _ponymix
	fi

	doman ponymix.1
}
