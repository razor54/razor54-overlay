# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Bambu Studio - 3D printing slicer (PrusaSlicer fork)"
HOMEPAGE="https://github.com/bambulab/BambuStudio"
SRC_URI="https://github.com/bambulab/BambuStudio/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
    dev-util/cmake
    sys-devel/gcc
    dev-util/pkgconf
    media-libs/mesa
    virtual/glu
    x11-libs/cairo
    x11-libs/gtk+:3
    media-libs/glew
    net-libs/libsoup:2.4
    net-libs/webkit-gtk:4.1
    net-misc/curl
    media-libs/gstreamer
    dev-cpp/eigen
    dev-cpp/tbb
    sci-libs/nlopt
    media-gfx/openvdb
    dev-libs/wayland
    x11-libs/libxkbcommon
    dev-libs/wayland-protocols
    media-libs/glfw
    dev-libs/boost
    dev-libs/expat
    sys-devel/m4
    dev-lang/perl
    media-libs/libjpeg-turbo
    media-video/ffmpeg
    media-libs/libpng
    dev-libs/openssl
    dev-libs/gmp
"

RDEPEND="${DEPEND}"

S="${WORKDIR}/BambuStudio-${PV}"
BAMBU_DEPS="${WORKDIR}/BambuStudio_dep"

inherit cmake

src_prepare() {
    default
    # Apply any patches needed to force system libraries (recommended)
}

src_configure() {
    # Build dependencies first
    cd "${S}/deps" || die
    mkdir -p build && cd build || die
    cmake ../ \
        -DDEP_WX_GTK3=1 || die
    make || die

    # Main project configure
    cmake "${S}" \
        -DSLIC3R_STATIC=ON \
        -DSLIC3R_GTK=3 \
        -DBBL_RELEASE_TO_PUBLIC=1 \
        -DCMAKE_PREFIX_PATH="${BAMBU_DEPS}/usr/local" \
        -DCMAKE_INSTALL_PREFIX="${D}/usr" \
        -DCMAKE_BUILD_TYPE=Release || die
}

src_compile() {
    emake || die
}

src_install() {
    emake DESTDIR="${D}" install || die
}

