# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils toolchain-funcs xdg meson

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://git.pwmt.org/pwmt/zathura-ps.git"
	EGIT_BRANCH="develop"
else
	KEYWORDS="amd64 arm x86 ~amd64-linux ~x86-linux"
	SRC_URI="https://pwmt.org/projects/zathura/plugins/download/${P}.tar.xz"
fi

DESCRIPTION="PostScript plug-in for zathura"
HOMEPAGE="https://pwmt.org/projects/zathura/"

LICENSE="ZLIB"
SLOT="0"
IUSE=""

RDEPEND=">=app-text/libspectre-0.2.6:=
	>=app-text/zathura-0.3.8
	dev-libs/glib:2=
	x11-libs/cairo:="
DEPEND="${RDEPEND}
	virtual/pkgconfig"
