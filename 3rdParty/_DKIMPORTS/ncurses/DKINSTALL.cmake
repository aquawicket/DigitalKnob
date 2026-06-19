#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


############ ncurses ############
# https://github.com/mirror/ncurses.git
# https://invisible-island.net/ncurses/ncurses.html
# https://invisible-island.net/datafiles/release/ncurses.tar.gz

if(Windows)
	dk_disable(ncurses)
	dk_return()
endif()

dk_import()

dk_include		(${ncurses}/include)
dk_include		(${ncurses_Tuple_Dir})
dk_include		(${ncurses_Build_Dir}/include)
dk_libDebug		(${ncurses_Debug_Dir}/lib/libncurses.a)
dk_libRelease	(${ncurses_Release_Dir}/lib/libncurses.a)

dk_configure()

dk_build()
