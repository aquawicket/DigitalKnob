# https://invisible-island.net/ncurses/ncurses.html
#
# https://invisible-island.net/datafiles/release/ncurses.tar.gz
if(WIN_HOST)
	return()
endif()


### VERSION ###
dk_set(NCURSES_VERSION 6.2)
dk_set(NCURSES_NAME ncurses-${NCURSES_VERSION})
dk_set(NCURSES_DL https://invisible-island.net/datafiles/release/ncurses.tar.gz)
dk_set(NCURSES ${3RDPARTY}/${NCURSES_NAME})


### INSTALL ###
dk_install(${NCURSES_DL} ncurses ${NCURSES})


### LINK ###
dk_include(${NCURSES}/include)
dk_include(${NCURSES}/${OS})
MAC_dk_libDebug(${NCURSES}/${OS}/${DEBUG_DIR}/lib/libncurses.a)
MAC_dk_libRelease(${NCURSES}/${OS}/${RELEASE_DIR}/lib/libncurses.a)
LINUX_dk_libDebug(${NCURSES}/${OS}/${DEBUG_DIR}/lib/libncurses.a)
LINUX_dk_libRelease(${NCURSES}/${OS}/${RELEASE_DIR}/lib/libncurses.a)
RASPBERRY_dk_libDebug(${NCURSES}/${OS}/${DEBUG_DIR}/lib/libncurses.a)
RASPBERRY_dk_libRelease(${NCURSES}/${OS}/${RELEASE_DIR}/lib/libncurses.a)

MAC_DEBUG_dk_setPath(${NCURSES}/${OS}/${DEBUG_DIR})
MAC_DEBUG_dk_queueCommand(${DKCONFIGURE_BUILD})
MAC_DEBUG_dk_queueCommand(make)
MAC_RELEASE_dk_setPath(${NCURSES}/${OS}/${RELEASE_DIR})
MAC_RELEASE_dk_queueCommand(${DKCONFIGURE_BUILD})
MAC_RELEASE_dk_queueCommand(make)

LINUX_DEBUG_dk_setPath(${NCURSES}/${OS}/${DEBUG_DIR})
LINUX_DEBUG_dk_queueCommand(${DKCONFIGURE_BUILD})
LINUX_DEBUG_dk_queueCommand(make)
LINUX_RELEASE_dk_setPath(${NCURSES}/${OS}/${RELEASE_DIR})
LINUX_RELEASE_dk_queueCommand(${DKCONFIGURE_BUILD})
LINUX_RELEASE_dk_queueCommand(make)

RASPBERRY_DEBUG_dk_setPath(${NCURSES}/${OS}/${DEBUG_DIR})
RASPBERRY_DEBUG_dk_queueCommand(${DKCONFIGURE_BUILD})
RASPBERRY_DEBUG_dk_queueCommand(make)
RASPBERRY_RELEASE_dk_setPath(${NCURSES}/${OS}/${RELEASE_DIR})
RASPBERRY_RELEASE_dk_queueCommand(${DKCONFIGURE_BUILD})
RASPBERRY_RELEASE_dk_queueCommand(make)