# Copyright 1999-2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Renesas uPD720201 / uPD720202 USB 3.0 chipsets firmware"
HOMEPAGE="https://github.com/denisandroid/uPD72020x-Firmware"
SRC_URI="https://github.com/denisandroid/uPD72020x-Firmware/archive/refs/tags/1.0.0.tar.gz -> ${P}.tar.gz"

LICENSE="RENESAS"
SLOT="0"
KEYWORDS="amd64 x86"

S="${WORKDIR}/uPD72020x-Firmware-${PV}/"

src_install() {
	mv 'UPDATE.mem' renesas_usb_fw.mem
	insinto /lib/firmware
	doins renesas_usb_fw.mem

	insinto /usr/share/licenses/renesas
	doins License.rtf
}
