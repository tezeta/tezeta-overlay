# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=(python3_{8..10})
inherit git-r3 python-single-r1 python-utils-r1 eutils desktop

DESCRIPTION="GUI for Microsoft Pro IntelliMouse"
HOMEPAGE="https://github.com/K-Visscher/intellimouse-ctl/"
EGIT_REPO_URI="https://github.com/K-Visscher/intellimouse-ctl"
EGIT_COMMIT="411b87513f1e3677205baa9256903edadcb53c38"
LICENSE="GPL-3"

KEYWORDS="~x86 ~amd64"
SLOT="0"
IUSE=""
RDEPEND="$(python_gen_cond_dep '
	dev-python/PyQt5[${PYTHON_USEDEP}]
	>=dev-python/cython-hidapi-9999[${PYTHON_USEDEP}]')
	sys-auth/polkit
"
DEPEND="${RDEPEND}"

python_check_deps() {
	has_version "dev-python/PyQt5[${PYTHON_USEDEP}]" \
    && has_version ">=dev-python/cython-hidapi-9999[${PYTHON_USEDEP}]"
}

src_prepare() {
	eapply_user
	# Fix relative path to images
	sed -i s:"'/../resources":"'/resources": "${S}/src/main/python/main.py"
	mv -v "${S}/src/main/python/main.py" "${S}/src/main/python/__main__.py"
	mv -v "${S}/src/main/python/intellimouse.py" "${S}/src/main/python/__init__.py"
}

src_install() {

	python_moduleinto intellimouse
	python_domodule src/main/python/__init__.py src/main/python/__main__.py

	python_domodule src/main/resources

	make_wrapper "${PN}.tmp" "pkexec ${EPYTHON} -m intellimouse"
	python_newexe "${ED%/}/usr/bin/${PN}.tmp" "${PN}"
	rm "${ED%/}/usr/bin/${PN}.tmp" || die

	newicon -s 128 "${S}/src/main/icons/linux/128.png" intellimouse.png
	newicon -s 256 "${S}/src/main/icons/linux/256.png" intellimouse.png
	newicon -s 512 "${S}/src/main/icons/linux/512.png" intellimouse.png

	make_desktop_entry "${PN}" "${DESCRIPTION}" "intellimouse" "Settings"

	insinto /usr/share/polkit-1/actions/
	doins "${FILESDIR}/org.freedesktop.intellimouse.policy"
	sed -i s:"@RUN@":"/usr/bin/${EPYTHON}": ${ED%/}/usr/share/polkit-1/actions/org.freedesktop.intellimouse.policy

}
