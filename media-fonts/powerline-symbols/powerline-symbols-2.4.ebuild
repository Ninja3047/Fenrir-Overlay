# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
inherit font

DESCRIPTION="OpenType Unicode font with symbols for Powerline/Airline"
HOMEPAGE="https://github.com/powerline/powerline"
SRC_URI="https://github.com/powerline/powerline/archive/${PV}.tar.gz"

LICENSE="MIT-with-advertising"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

S="${WORKDIR}/powerline-${PV}"

FONT_S="${S}/font"
FONT_SUFFIX="otf"
FONT_CONF=( font/10-powerline-symbols.conf )
DOCS="README.rst"
