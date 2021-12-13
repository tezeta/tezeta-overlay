# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Utility for acquiring debugging information from usb hid devices"
HOMEPAGE="https://www.pjrc.com/teensy/hid_listen.html"
SRC_URI="https://www.pjrc.com/teensy/hid_listen_1.01.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/${PN}"

QA_PRESTRIPPED="usr/bin/${PN}"

src_install() {
	dobin hid_listen
}

pkg_postinst() {
	elog "Note that this utility may require changing device permissions or superuser to work properly."
}
