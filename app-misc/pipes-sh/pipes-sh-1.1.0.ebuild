# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

DESCRIPTION="Animated pipes terminal screensaver."

HOMEPAGE="https://github.com/pipeseroni/pipes.sh"
SRC_URI="https://github.com/pipeseroni/pipes.sh/archive/v1.1.0.tar.gz"
S=${WORKDIR}/pipes.sh-1.1.0

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_install() {
	emake DESTDIR="${D}" install
}
