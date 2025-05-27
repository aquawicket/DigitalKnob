#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


dk_validate(CONFIG_PATH  "dk_CONFIG_PATH()")
# https://github.com/mirror/ncurses.git
# https://invisible-island.net/ncurses/ncurses.html
# https://invisible-island.net/datafiles/release/ncurses.tar.gz

if(Windows)
	dk_undepend(ncurses)
	dk_return()
endif()


### IMPORT ###
dk_import(https://invisible-island.net/datafiles/release/ncurses.tar.gz)


### LINK ###
dk_include			(${NCURSES}/include)
dk_include			(${NCURSES}/${Target_Tuple})
Debug_dk_include	(${NCURSES_DEBUG_DIR}/include)
Release_dk_include	(${NCURSES_RELEASE_DIR}/include)
dk_libDebug			(${NCURSES_DEBUG_DIR}/lib/libncurses.a)
dk_libRelease		(${NCURSES_RELEASE_DIR}/lib/libncurses.a)


#DEBUG_dk_chdir			(${NCURSES_DEBUG_DIR})
#DEBUG_dk_queueCommand	(${DKCONFIGURE_BUILD})
#RELEASE_dk_chdir		(${NCURSES_RELEASE_DIR})
#RELEASE_dk_queueCommand(${DKCONFIGURE_BUILD})
dk_configure			(${NCURSES})

dk_build				(${NCURSES}) # ncurses)
