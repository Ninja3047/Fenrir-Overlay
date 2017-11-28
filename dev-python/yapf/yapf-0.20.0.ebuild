# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5,6} )

inherit distutils-r1 eutils

DESCRIPTION="A formatter for Python code"
HOMEPAGE="https://github.com/google/yapf"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~ia64 ~ppc ~x86 ~amd64-linux"
IUSE="test"

RDEPEND=""
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
		test? ( ${RDEPEND}
			dev-python/coverage[${PYTHON_USEDEP}]
			dev-python/tox[${PYTHON_USEDEP}] )"

python_test() {
	tox -v || die "Tests fail with ${EPYTHON}"
}
