# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils toolchain-funcs xdg meson

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://git.pwmt.org/pwmt/zathura-djvu.git"
	EGIT_BRANCH="develop"
else
	KEYWORDS="amd64 arm x86"
	SRC_URI="http://pwmt.org/projects/zathura/plugins/download/${P}.tar.xz"
fi

DESCRIPTION="DjVu plug-in for zathura"
HOMEPAGE="http://pwmt.org/projects/zathura/"

LICENSE="ZLIB"
SLOT="0"
IUSE=""

RDEPEND=">=app-text/djvu-3.5.24-r1:=
	>=app-text/zathura-0.3.8
	dev-libs/glib:2=
	x11-libs/cairo:="
DEPEND="${RDEPEND}
	virtual/pkgconfig"
