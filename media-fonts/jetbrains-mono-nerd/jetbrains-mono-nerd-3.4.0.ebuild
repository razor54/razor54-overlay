EAPI=8

inherit font

FONT_NAME="JetBrainsMono"

DESCRIPTION="JetBrains officially created font for developers"
HOMEPAGE="https://NerdFonts.com"
SRC_URI="https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/${FONT_NAME}.zip"
KEYWORDS="amd64"

LICENSE="NERDFONTS"
SLOT="0"

S="${WORKDIR}"
FONT_SUFFIX="ttf"

