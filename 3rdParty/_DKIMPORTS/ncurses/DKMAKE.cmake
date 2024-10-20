#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


dk_load(dk_builder)
# https://github.com/mirror/ncurses.git
# https://invisible-island.net/ncurses/ncurses.html
# https://invisible-island.net/datafiles/release/ncurses.tar.gz

if(WIN)
	dk_undepend(ncurses)
	dk_return()
endif()


### IMPORT ###
dk_import(https://invisible-island.net/datafiles/release/ncurses.tar.gz)


### LINK ###
dk_include			(${NCURSES}/include)
dk_include			(${NCURSES}/${triple})
DEBUG_dk_include	(${NCURSES}/${triple}/${DEBUG_DIR}/include)
RELEASE_dk_include	(${NCURSES}/${triple}/${RELEASE_DIR}/include)
dk_libDebug			(${NCURSES}/${triple}/${DEBUG_DIR}/lib/libncurses.a)
dk_libRelease		(${NCURSES}/${triple}/${RELEASE_DIR}/lib/libncurses.a)


#DEBUG_dk_cd		(${NCURSES}/${triple}/${DEBUG_DIR})
#DEBUG_dk_queueCommand	(${DKCONFIGURE_BUILD})
#RELEASE_dk_cd		(${NCURSES}/${triple}/${RELEASE_DIR})
#RELEASE_dk_queueCommand(${DKCONFIGURE_BUILD})
dk_configure			(${NCURSES})

dk_build				(${NCURSES}) # ncurses)
