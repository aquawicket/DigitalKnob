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

###### gme ######
# https://github.com/libgme/game-music-emu.git
# https://github.com/libgme/game-music-emu/archive/cb2c1cc.zip

dk_import		()

dk_include			(${gme}/include)
if(Unix)
	dk_libDebug		(${gme_Debug_Dir}/gme/libgme.a)
	dk_libRelease	(${gme_Release_Dir}/gme/libgme.a)
else()
	dk_libDebug		(${gme_Debug_Dir}/gme/gme.lib)
	dk_libRelease	(${gme_Release_Dir}/gme/gme.lib)
endif()

dk_configure()

dk_build()
