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


############ diff-match-patch ############
# https://github.com/google/diff-match-patch.git
# https://github.com/google/diff-match-patch/archive/refs/heads/master.zip
# https://github.com/google/diff-match-patch/archive/62f2e689f498f9c92dbc588c58750addec9b1654.zip

dk_import()

# dk_include		(${diff-match-patch}/include)
# if(Windows)
#	dk_libDebug		(${diff-match-patch_Debug_Dir}/diff-match-patchd.lib)
#	dk_libRelease	(${diff-match-patch_Release_Dir}/diff-match-patch.lib)
# else()
#	dk_libDebug		(${diff-match-patch_Debug_Dir}/libdiff-match-patchd.a)
#	dk_libRelease	(${diff-match-patch_Release_Dir}/libdiff-match-patch.a)
#endif()

#dk_configure()

#dk_build()
