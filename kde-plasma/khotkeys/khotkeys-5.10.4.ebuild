# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

KDE_HANDBOOK="true"
inherit kde5

DESCRIPTION="KDE Plasma workspace hotkey module"
KEYWORDS="amd64 ~arm x86"
IUSE=""

COMMON_DEPEND="
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdbusaddons)
	$(add_frameworks_dep kdelibs4support X)
	$(add_frameworks_dep kglobalaccel)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kservice)
	$(add_frameworks_dep ktextwidgets)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kwindowsystem)
	$(add_frameworks_dep kxmlgui)
	$(add_plasma_dep plasma-workspace)
	$(add_qt_dep qtdbus)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtwidgets)
	$(add_qt_dep qtx11extras)
	x11-libs/libX11
	x11-libs/libXtst
"
RDEPEND="${COMMON_DEPEND}
	$(add_frameworks_dep kded)
	$(add_plasma_dep kde-cli-tools)
	!kde-plasma/khotkeys:4
	!kde-plasma/systemsettings:4
"
DEPEND="${COMMON_DEPEND}
	x11-libs/libxcb
	x11-libs/libXtst
	x11-proto/xproto
"

PATCHES=( "${FILESDIR}/${P}-cmake-3.9.patch" )
