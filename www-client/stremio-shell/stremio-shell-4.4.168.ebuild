# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

RAZERCHROMA_SHA="99045142479ba0e2fc3b9cccb72e348c67cd5829"
LIBMPV_SHA="b0eae77cf6dc59aaf142b7d079cb13a0904fd3ee"
SINGLEAPPLICATION_SHA="aede311d28d20179216c5419b581087be2a8409f"

DESCRIPTION="Qt5-based Stremio desktop shell"
HOMEPAGE="https://www.stremio.com
	https://github.com/Stremio/stremio-shell"
SRC_URI="
	https://github.com/Stremio/${PN}/archive/refs/tags/v${PV}.tar.gz
		-> ${P}.tar.gz
	https://github.com/Ivshti/razerchroma/archive/${RAZERCHROMA_SHA}.tar.gz
		-> razerchroma-${RAZERCHROMA_SHA}.tar.gz
	https://github.com/Ivshti/libmpv/archive/${LIBMPV_SHA}.tar.gz
		-> libmpv-${LIBMPV_SHA}.tar.gz
	https://github.com/itay-grudev/SingleApplication/archive/${SINGLEAPPLICATION_SHA}.tar.gz
		-> singleapplication-${SINGLEAPPLICATION_SHA}.tar.gz
	https://dl.strem.io/four/v${PV}/server.js
	https://dl.strem.io/four/v${PV}/stremio.asar
"

LICENSE="MIT"
S="${WORKDIR}/${PN}-${PV}"
SLOT="0"
KEYWORDS=""

inherit desktop qmake-utils xdg-utils

DEPEND="
	dev-libs/openssl:=
	dev-qt/qtcore:5
	media-video/mpv[libmpv]
	net-libs/nodejs
"
RDEPEND="${DEPEND}"
BDEPEND="net-misc/wget"

src_unpack() {
	default

	rm -rf "${S}/deps"/* || die
	cp -R "${WORKDIR}/razerchroma-${RAZERCHROMA_SHA}" "${S}/deps/chroma" || die
	cp -R "${WORKDIR}/libmpv-${LIBMPV_SHA}" "${S}/deps/libmpv" || die
	cp -R "${WORKDIR}/SingleApplication-${SINGLEAPPLICATION_SHA}" "${S}/deps/singleapplication" || die
}

src_configure() {
	eqmake5 PREFIX="/usr"
}

src_compile() {
	emake
}

src_install() {
	dobin "${PN}"

	insinto /opt/${PN}
	doins "${DISTDIR}/server.js" "${DISTDIR}/stremio.asar"

	domenu smartcode-stremio.desktop
	newicon images/stremio.png smartcode-stremio.png
}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
