# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3

DESCRIPTION="Universal theme switcher and config generator for the i3 wm"
HOMEPAGE="https://github.com/okraits/j4-make-config"
EGIT_REPO_URI="https://github.com/okraits/j4-make-config.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

DEPEND="dev-lang/python"
RDEPEND=""

src_install() {
	dobin j4-make-config
	dodoc README.md
	dodir /usr/share/${PN}-git/themes
	cp -r themes "${ED}"/usr/share/${PN}-git/ || die "cp failed"
}
