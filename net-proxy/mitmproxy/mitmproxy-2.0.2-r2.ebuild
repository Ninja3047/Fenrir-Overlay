# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
PYTHON_COMPAT=( python3_{3,4,5,6} )

inherit distutils-r1 versionator

DESCRIPTION="An interactive, SSL-capable, man-in-the-middle HTTP proxy"
HOMEPAGE="http://mitmproxy.org/"
SRC_URI="https://github.com/mitmproxy/mitmproxy/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples test"

RDEPEND="
	>=dev-python/blinker-1.4[${PYTHON_USEDEP}]
	>=dev-python/click-6.2[${PYTHON_USEDEP}]
	>=dev-python/certifi-2015.11.20.1[${PYTHON_USEDEP}]
	>=dev-python/construct-2.8[${PYTHON_USEDEP}]
	>=dev-python/cryptography-2.0[${PYTHON_USEDEP}]
	>=dev-python/cssutils-1.0.1[${PYTHON_USEDEP}]
	>=dev-python/flask-0.10.1[${PYTHON_USEDEP}]
	>=dev-python/hyper-h2-2.5.1[${PYTHON_USEDEP}]
	>=dev-python/html2text-2016.1.8[${PYTHON_USEDEP}]
	>=dev-python/hyperframe-4.0.1[${PYTHON_USEDEP}]
	>=dev-python/jsbeautifier-1.6.3[${PYTHON_USEDEP}]
	>=dev-python/pillow-3.2[${PYTHON_USEDEP}]
	>=dev-python/passlib-1.6.5[${PYTHON_USEDEP}]
	>=dev-python/pyasn1-0.1.9[${PYTHON_USEDEP}]
	>=dev-python/pyopenssl-17.2[${PYTHON_USEDEP}]
	>=dev-python/pyparsing-2.1.3[${PYTHON_USEDEP}]
	>=dev-python/pyperclip-1.5.22[${PYTHON_USEDEP}]
	>=dev-python/requests-2.9.1[${PYTHON_USEDEP}]
	>=dev-python/ruamel-yaml-0.13.2[${PYTHON_USEDEP}]
	>=www-servers/tornado-4.3[${PYTHON_USEDEP}]
	>=dev-python/urwid-1.3.1[${PYTHON_USEDEP}]
	>=dev-python/watchdog-0.8.3[${PYTHON_USEDEP}]
	>=dev-python/brotlipy-0.5.1[${PYTHON_USEDEP}]
	>=dev-python/sortedcontainers-1.5.4[${PYTHON_USEDEP}]
	>=dev-python/protobuf-python-3.1.0[${PYTHON_USEDEP}]
	>=dev-python/kaitaistruct-0.7[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}
	>=dev-python/setuptools-11.3[${PYTHON_USEDEP}]
	test? (
		>=dev-python/mock-1.0.1[${PYTHON_USEDEP}]
		>=dev-python/nose-1.3.0[${PYTHON_USEDEP}]
	)"
#fixme: bump it too
#		=www-servers/pathod-$(get_version_component_range 1-2)*[${PYTHON_USEDEP}]

PATCHES=( "${FILESDIR}"/"${P}"-kaitaistruct-0.7.diff )

python_prepare() {
	# Let's remove all the upper bounds and use system certificate store
	sed -e '/certifi/d' \
		-e 's/, *<[0-9=.]*//' \
		-i setup.py
	sed -e '/import certifi/d' \
		-e 's|certifi.where()|"/etc/ssl/certs/ca-certificates.crt"|' \
		-i mitmproxy/net/tcp.py
}

python_test() {
	nosetests -v || die "Tests fail with ${EPYTHON}"
}

python_install_all() {
	local DOCS=( CHANGELOG CONTRIBUTORS )
	use doc && local HTML_DOCS=( doc/. )
	use examples && local EXAMPLES=( examples/. )

	distutils-r1_python_install_all
}
