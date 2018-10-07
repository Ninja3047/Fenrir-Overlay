# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit multilib toolchain-funcs virtualx meson
[[ ${PV} == 9999* ]] && inherit git-2

DESCRIPTION="UI library that focuses on simplicity and minimalism"
HOMEPAGE="https://pwmt.org/projects/girara/"
if ! [[ ${PV} == 9999* ]]; then
SRC_URI="https://pwmt.org/projects/${PN}/download/${P}.tar.xz"
fi
EGIT_REPO_URI="https://git.pwmt.org/pwmt/${PN}.git"
EGIT_BRANCH="develop"

LICENSE="ZLIB"
SLOT="3"
if ! [[ ${PV} == 9999* ]]; then
KEYWORDS="amd64 arm x86 ~amd64-linux ~x86-linux"
fi
IUSE="docs +json libnotify test"

RDEPEND=">=dev-libs/glib-2.28
	>=x11-libs/gtk+-3.4:3
	dev-libs/json-c
	!<${CATEGORY}/${PN}-0.1.6
	libnotify? ( >=x11-libs/libnotify-0.7 )"
DEPEND="${RDEPEND}
	sys-devel/gettext
	virtual/pkgconfig
	test? ( x11-apps/xhost
		dev-libs/check )"

pkg_setup() {
	mygiraraconf=(
		-Denable-notify=$(usex libnotify true false)
		-Denable-json=$(usex json true false)
		-Denable-docs=$(usex docs true false)
		)
}
