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


############ x265 ############
# https://bitbucket.org/multicoreware/x265_git.git
# https://bitbucket.org/multicoreware/x265_git/get/dd594f59.zip
#
function(DKINSTALL)

	dk_import()

	dk_include		(${x265}/include)
	dk_include		(${x265_Tuple_Dir})
	dk_libDebug		(${x265_Debug_Dir}/libx265.a)
	dk_libRelease	(${x265_Release_Dir}/libx265.a)

	dk_configure()

	dk_build()
endfunction()
