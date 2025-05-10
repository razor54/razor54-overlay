# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit rpm

DESCRIPTION="Brother DCP-L2530DW printer driver"
HOMEPAGE="https://support.brother.com/"
LICENSE="Brother-DCP-L2530DW"
KEYWORDS="~arch ~amd64" # Mark as untested

DEPEND="app-arch/rpm app-arch/rpm2targz"
RDEPEND=">=net-print/cups-2.0"

SRC_URI="https://download.brother.com/welcome/dlf103517/dcpl2530dwpdrv-4.0.0-1.i386.rpm"

S=${WORKDIR}

src_unpack() {
	rpm2targz "${DISTDIR}/${A}"
	tar xzf *.tgz
}

src_install() {
	# Install printer files
	insinto /opt/brother/Printers/DCPL2530DW/cupswrapper
	doins -r opt/brother/Printers/DCPL2530DW/cupswrapper/*

	insinto /opt/brother/Printers/DCPL2530DW/inf
	doins opt/brother/Printers/DCPL2530DW/inf/*

	insinto /opt/brother/Printers/DCPL2530DW/lpd
	doins -r opt/brother/Printers/DCPL2530DW/lpd/*
}

