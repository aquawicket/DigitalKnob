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


############ macports ############
# https://guide.macports.org/#installing.macports
# https://github.com/macports/macports-base
# https://github.com/macports/macports-base/releases
# https://github.com/macports/macports-base/releases/download/v2.7.1/MacPorts-2.7.1-11-BigSur.pkg


dk_import			()

dk_include			(${metacall}/include)
if(MSVC)
	dk_libDebug		(${metacall_Debug_Dir}/metacall.lib)
	dk_libRelease	(${metacall_Release_Dir}/metacall.lib)
else()
	dk_libDebug		(${metacall_Debug_Dir}/libmetacall.a)
	dk_libRelease	(${metacall_Release_Dir}/libmetacall.a)
endif()

dk_configure()

k_build()
