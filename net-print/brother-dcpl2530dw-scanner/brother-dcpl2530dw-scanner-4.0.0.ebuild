# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit rpm

DESCRIPTION="Brother DCP-L2530DW scanner driver"
HOMEPAGE="https://support.brother.com/"
LICENSE="Brother-DCP-L2530DW"
KEYWORDS="~arch ~amd64" # Mark as untested

DEPEND="app-arch/rpm app-arch/rpm2targz"
RDEPEND="media-gfx/sane"

SRC_URI="https://download.brother.com/welcome/dlf105203/brscan4-0.4.11-1.x86_64.rpm"

S=${WORKDIR}

src_unpack() {
	rpm2targz "${DISTDIR}/${A}"
	tar xzf *.tgz
}

src_install() {
	# Install scanner files
	insinto /opt/brother/scanner/brscan4
	doins -r opt/brother/scanner/brscan4/*
}

