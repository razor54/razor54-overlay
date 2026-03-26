# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	anyhow@1.0.98
	ashpd@0.11.0
	bytes@1.10.1
	clap@4.5.40
	crossbeam-channel@0.5.15
	dirs@6.0.0
	futures@0.3.31
	gl@0.14.0
	gtk@0.18.2
	image@0.25.6
	itertools@0.14.0
	libc@0.2.174
	once_cell@1.21.3
	paste@1.0.15
	reqwest@0.12.20
	rust-i18n@3.1.5
	serde@1.0.219
	serde_json@1.0.140
	tracing@0.1.41
	tracing-subscriber@0.3.19
	tray-icon@0.20.1
	url@2.5.4
	bzip2@0.6.0
	dircpy@0.3.19
	globset@0.4.16
	tar@0.4.44
	toml@0.8.23
	ureq@3.0.12
"

# git-sourced crates pinned by upstream Cargo.lock
CARGO_CRATE_URIS="$(cargo_crate_uris ${CRATES})"
GIT_CRATES="
	cef https://github.com/Stremio/cef-rs 8aa6a6aa6e3b621e9a571a34b64e90f1a574277b
	cef-dll-sys https://github.com/Stremio/cef-rs 8aa6a6aa6e3b621e9a571a34b64e90f1a574277b
	glutin https://github.com/Stremio/glutin 7d45516496d1783ba37fa94ebdd255272605892c feat/wayland-file-window-events
	glutin-winit https://github.com/Stremio/glutin 7d45516496d1783ba37fa94ebdd255272605892c feat/wayland-file-window-events
	libmpv2 https://github.com/Stremio/libmpv2-rs b2b0ce03fde964c0c5cd4f66e193740062468b41
	winit https://github.com/Stremio/winit dbb55e126896887283c269c4460d0d7f80349012 feat/wayland-file-window-events
"

# Upstream version/tag mapping: 1.0.0_beta13 -> v1.0.0-beta.13
MY_PV=${PV/_beta/-beta.}
CEF_VERSION="138.0.21"
CEF_DIST="cef_binary_${CEF_VERSION}+g54811fe+chromium-138.0.7204.101_linux64_minimal.tar.bz2"

DESCRIPTION="Linux-native Stremio shell written in Rust"
HOMEPAGE="https://github.com/Stremio/stremio-linux-shell"
SRC_URI="
	https://github.com/Stremio/${PN}/archive/refs/tags/v${MY_PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}
	$(cargo_live_src_uri ${GIT_CRATES})
	https://cef-builds.spotifycdn.com/${CEF_DIST}
"

LICENSE="GPL-3 Apache-2.0 BSD ISC MIT MPL-2.0 Unicode-3.0"
SLOT="0"
KEYWORDS="~amd64"
S="${WORKDIR}/${PN}-${MY_PV}"

inherit cargo desktop xdg

DEPEND="
	dev-libs/glib:2
	dev-libs/libayatana-appindicator
	dev-libs/openssl:=
	media-libs/fontconfig
	media-libs/freetype
	media-video/mpv[libmpv]
	x11-libs/gtk+:3
	x11-libs/libX11
	x11-libs/libxcb
	x11-libs/libxkbcommon
"
RDEPEND="${DEPEND}"
BDEPEND="
	app-arch/tar
	virtual/rust
"

QA_FLAGS_IGNORED="usr/bin/${PN}"

src_prepare() {
	default
	cargo_gen_config

	mkdir -p vendor/cef || die
	tar -xjf "${DISTDIR}/${CEF_DIST}" -C vendor/cef --strip-components=1 || die
}

src_configure() {
	export CEF_PATH="${S}/vendor/cef"
}

src_compile() {
	cargo_src_compile --features offline-build
}

src_install() {
	dobin target/release/${PN}

	insinto /usr/share/${PN}
	doins data/server.js

	domenu data/com.stremio.Stremio.desktop
	doicon data/icons/hicolor/scalable/apps/com.stremio.Stremio.svg
	dometainfo data/com.stremio.Stremio.metainfo.xml
}
