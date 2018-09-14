# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit eutils multilib toolchain-funcs

DESCRIPTION="Standard ML of New Jersey compiler and libraries"
HOMEPAGE="http://www.smlnj.org"

BASE_URI="http://smlnj.cs.uchicago.edu/dist/working/${PV}"

FILES="
doc.tgz

config.tgz

cm.tgz
compiler.tgz
runtime.tgz
system.tgz
MLRISC.tgz
smlnj-lib.tgz
old-basis.tgz

ckit.tgz
nlffi.tgz

cml.tgz
eXene.tgz

ml-lpt.tgz
ml-lex.tgz
ml-yacc.tgz
ml-burg.tgz

pgraph.tgz
trace-debug-profile.tgz

heap2asm.tgz

smlnj-c.tgz

asdl.tgz
"

#use amd64 in 32-bit mode
SRC_URI="amd64? ( ${BASE_URI}/boot.x86-unix.tgz -> ${P}-boot.x86-unix.tgz )
		 ppc?   ( ${BASE_URI}/boot.ppc-unix.tgz -> ${P}-boot.ppc-unix.tgz )
		 sparc? ( ${BASE_URI}/boot.sparc-unix.tgz -> ${P}-boot.sparc-unix.tgz )
		 x86?   ( ${BASE_URI}/boot.x86-unix.tgz -> ${P}-boot.x86-unix.tgz )"

for file in ${FILES}; do
	SRC_URI+=" ${BASE_URI}/${file} -> ${P}-${file} "
done

LICENSE="BSD"
SLOT="0"

#sparc support should be there but is untested
KEYWORDS="-* ~amd64 ~ppc ~x86"
IUSE="pax_kernel"
DEPEND="pax_kernel? ( sys-apps/elfix )"
RDEPEND=""

S=${WORKDIR}

src_unpack() {
	mkdir -p "${S}"
	for file in ${A}; do
		[[ ${file} != ${P}-config.tgz ]] && cp "${DISTDIR}/${file}" "${S}/${file#${P}-}"
	done

#	make sure we don't use the internet to download anything
	unpack ${P}-config.tgz && rm config/*.bat
	echo SRCARCHIVEURL=\"file:/${S}\" > "${S}"/config/srcarchiveurl
}

src_prepare() {
	# respect CC et al. (bug 243886)
	mkdir base || die # without this unpacking runtime will fail
	./config/unpack "${S}" runtime || die
	default
	for file in mk.*; do
		sed -e "/^AS/s:as:$(tc-getAS):" \
			-e "/^CC/s:gcc:$(tc-getCC):" \
			-e "/^CPP/s:gcc:$(tc-getCC):" \
			-e "/^CFLAGS/{s:-O[0123s]:: ; s:=:= ${CFLAGS}:}" \
			-i base/runtime/objs/${file}
	done
}

src_compile() {
	SMLNJ_HOME="${S}" \
		./config/install.sh || die "compilation failed"
}

src_install() {
	SUBDIR=$(ABI=x86 get_libdir)/${PN}
	DIR=/usr/${SUBDIR}
	for file in bin/{*,.*}; do
		[[ -f ${file} ]] && sed -e "2iSMLNJ_HOME=${EPREFIX%/}/${DIR}" \
								-e "s:${WORKDIR}:${EPREFIX%/}/${DIR}:" -i ${file}
	done
	dodir ${DIR}/bin
	exeinto ${DIR}/bin
	pushd bin || die
	for i in .arch-n-opsys .link-sml .run-sml heap2exec ml-* sml; do
		doexe ${i}
	done
	for i in heap2exec ml-* sml; do
		dosym ../${SUBDIR}/bin/${i} /usr/bin/${i}
	done
	popd || die
	dodir ${DIR}/bin/.heap
	insinto ${DIR}/bin/.heap
	doins bin/.heap/*
	dodir ${DIR}/bin/.run
	exeinto ${DIR}/bin/.run
	pushd bin/.run || die
	for i in run*; do
		doexe ${i}
	done
	popd || die
	insinto ${DIR}
	doins -r lib
	dodoc -r doc/*
}
