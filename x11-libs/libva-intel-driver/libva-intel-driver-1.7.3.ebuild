# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

SCM=""
if [ "${PV%9999}" != "${PV}" ] ; then # Live ebuild
	SCM=git-2
	EGIT_BRANCH=master
	EGIT_REPO_URI="https://github.com/01org/intel-vaapi-driver.git"
fi

AUTOTOOLS_AUTORECONF="yes"
inherit autotools-multilib ${SCM}

DESCRIPTION="HW video decode support for Intel integrated graphics"
HOMEPAGE="https://github.com/01org/intel-vaapi-driver"
if [ "${PV%9999}" != "${PV}" ] ; then # Live ebuild
	SRC_URI=""
	S="${WORKDIR}/${PN}"
else
	SRC_URI="https://github.com/01org/intel-vaapi-driver/archive/${PV}.tar.gz -> ${P}.tar.gz"
fi

LICENSE="MIT"
SLOT="0"
if [ "${PV%9999}" = "${PV}" ] ; then
	KEYWORDS="amd64 x86 ~amd64-linux ~x86-linux"
else
	KEYWORDS=""
fi
IUSE="+drm wayland X"

RDEPEND=">=x11-libs/libva-1.7.2[X?,wayland?,drm?,${MULTILIB_USEDEP}]
	>=x11-libs/libdrm-2.4.46[video_cards_intel,${MULTILIB_USEDEP}]
	wayland? ( >=media-libs/mesa-9.1.6[egl,${MULTILIB_USEDEP}] >=dev-libs/wayland-1.0.6[${MULTILIB_USEDEP}] )"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS=( AUTHORS NEWS README )

src_prepare() {
	sed -e 's/intel-gen4asm/\0diSaBlEd/g' -i configure.ac || die
	autotools-multilib_src_prepare
}

multilib_src_configure() {
	local myeconfargs=(
		$(use_enable drm)
		$(use_enable wayland)
		$(use_enable X x11)
	)
	autotools-utils_src_configure
}
