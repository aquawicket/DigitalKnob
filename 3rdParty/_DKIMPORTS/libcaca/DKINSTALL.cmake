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


########### libcaca ############
# http://caca.zoy.org/wiki/libcaca
# https://github.com/cacalabs/libcaca.git
# https://github.com/cacalabs/libcaca/archive/refs/heads/main.zip

dk_import()

dk_include				(${libcaca}/include)
dk_include				(${libcaca}/${Target_Tuple})
Unix_dk_libDebug		(${libcaca_Debug_Dir}/libcacad.a)
Unix_dk_libRelease		(${libcaca_Release_Dir}/libcaca.a)
Windows_dk_libDebug		(${libcaca_Debug_Dir}/libcacad.lib)
Windows_dk_libRelease	(${libcaca_Release_Dir}/libcaca.lib)

dk_configure()

dk_build(${libcaca} libcaca)
