# Copyright 1999-2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

inherit eutils git-r3

DESCRIPTION="a command line tool for performing fuzzy string matching against lists of words"
HOMEPAGE="https://github.com/mjfisheruk/funiq"
EGIT_REPO_URI="https://github.com/mjfisheruk/funiq.git"

#No license information is present, assume full copyright
LICENSE="all-rights-reserved"
KEYWORDS="~amd64"
SLOT=0
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	dobin bin/funiq
	dodoc {README.md,CHANGELOG.md}
}
