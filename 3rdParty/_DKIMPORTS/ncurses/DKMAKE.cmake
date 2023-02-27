# https://invisible-island.net/ncurses/ncurses.html
#
# https://invisible-island.net/datafiles/release/ncurses.tar.gz

if(WIN)
	dk_undepend(ncurses)
	dk_return()
endif()


### IMPORT ###
dk_import(https://invisible-island.net/datafiles/release/ncurses.tar.gz)


### LINK ###
dk_include			(${NCURSES}/include)
dk_include			(${NCURSES}/${OS})
DEBUG_dk_include	(${NCURSES}/${OS}/${DEBUG_DIR})
RELEASE_dk_include	(${NCURSES}/${OS}/${RELEASE_DIR})
dk_libDebug			(${NCURSES}/${OS}/${DEBUG_DIR}/lib/libncurses.a)
dk_libRelease		(${NCURSES}/${OS}/${RELEASE_DIR}/lib/libncurses.a)


DEBUG_dk_setPath		(${NCURSES}/${OS}/${DEBUG_DIR})
DEBUG_dk_queueCommand	(${DKCONFIGURE_BUILD})
DEBUG_dk_queueCommand	(make)
RELEASE_dk_setPath		(${NCURSES}/${OS}/${RELEASE_DIR})
RELEASE_dk_queueCommand	(${DKCONFIGURE_BUILD})
RELEASE_dk_queueCommand	(make)
