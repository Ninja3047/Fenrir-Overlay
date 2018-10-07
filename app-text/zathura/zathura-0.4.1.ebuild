# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils multilib toolchain-funcs virtualx xdg-utils meson

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://git.pwmt.org/pwmt/zathura.git"
	EGIT_BRANCH="develop"
else
	KEYWORDS="amd64 arm x86 ~amd64-linux ~x86-linux"
	SRC_URI="http://pwmt.org/projects/${PN}/download/${P}.tar.xz"
fi

DESCRIPTION="A highly customizable and functional document viewer"
HOMEPAGE="http://pwmt.org/projects/zathura/"

LICENSE="ZLIB"
SLOT="0"
IUSE="+magic sqlite synctex test"

RDEPEND=">=dev-libs/girara-0.2.8:3=
	>=dev-libs/glib-2.32:2=
	x11-libs/cairo:=
	>=x11-libs/gtk+-3.6:3
	magic? ( sys-apps/file:= )
	sqlite? ( dev-db/sqlite:3= )
	synctex? ( >=app-text/texlive-core-2015 )"
DEPEND="${RDEPEND}
	sys-devel/gettext
	virtual/pkgconfig
	test? ( dev-libs/check )"

src_configure() {
	local emesonargs=(
		-Denable-magic=$(usex magic true false)
		-Denable-sqlite=$(usex sqlite true false)
		-Denable-syntex=$(usex synctex true false)
		-Denable-seccomp=true
	)
	meson_src_configure
}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
