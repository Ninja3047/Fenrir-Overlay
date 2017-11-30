# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5,6} )

inherit distutils-r1 eutils

DESCRIPTION="An implementation of the Language Server Protocol for Python"
HOMEPAGE="https://github.com/palantir/python-language-server"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~ia64 ~ppc ~x86 ~amd64-linux"
IUSE="doc examples test"

RDEPEND="
	>=dev-python/future-0.14.0[${PYTHON_USEDEP}]
	>=dev-python/jedi-0.10[${PYTHON_USEDEP}]
	>=dev-python/rope-0.10.5[${PYTHON_USEDEP}]
	dev-python/json-rpc[${PYTHON_USEDEP}]
	dev-python/pycodestyle[${PYTHON_USEDEP}]
	dev-python/pydocstyle[${PYTHON_USEDEP}]
	dev-python/pyflakes[${PYTHON_USEDEP}]
	dev-python/yapf[${PYTHON_USEDEP}]
	dev-python/pluggy[${PYTHON_USEDEP}]
	dev-python/mccabe[${PYTHON_USEDEP}]
	$(python_gen_cond_dep 'dev-python/configparser[${PYTHON_USEDEP}]' -2)"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( ${RDEPEND}
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/pytest-cov[${PYTHON_USEDEP}]
		dev-python/coverage[${PYTHON_USEDEP}]
		dev-python/tox[${PYTHON_USEDEP}]
		dev-python/versioneer[${PYTHON_USEDEP}] )"

python_prepare() {
	sed -i "s/'configparser',//g" setup.py
}

python_test() {
	tox -v || die "Tests fail with ${EPYTHON}"
}
