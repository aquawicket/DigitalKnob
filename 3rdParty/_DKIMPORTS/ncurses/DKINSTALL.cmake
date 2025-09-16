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


dk_validate(Target_Config  "dk_Target_Config()")
# https://github.com/mirror/ncurses.git
# https://invisible-island.net/ncurses/ncurses.html
# https://invisible-island.net/datafiles/release/ncurses.tar.gz

if(Windows)
	dk_disable(ncurses)
	dk_return()
endif()


### IMPORT ###
dk_import(https://invisible-island.net/datafiles/release/ncurses.tar.gz)


### LINK ###
dk_include			(${NCURSES}/include)
dk_include			(${NCURSES}/${Target_Tuple})
Debug_dk_include	(${NCURSES_Debug_Dir}/include)
Release_dk_include	(${NCURSES_Release_Dir}/include)
dk_libDebug			(${NCURSES_Debug_Dir}/lib/libncurses.a)
dk_libRelease		(${NCURSES_Release_Dir}/lib/libncurses.a)


#DEBUG_dk_chdir		(${NCURSES_Debug_Dir})
#DEBUG_dk_exec		(${DKCONFIGURE_BUILD})
#RELEASE_dk_chdir	(${NCURSES_Release_Dir})
#RELEASE_dk_exec	(${DKCONFIGURE_BUILD})
dk_configure		(${NCURSES})

dk_build			(${NCURSES}) # ncurses)
