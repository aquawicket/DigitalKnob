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
# https://github.com/google/diff-match-patch.git
# https://github.com/google/diff-match-patch/archive/62f2e689f498f9c92dbc588c58750addec9b1654.zip


### IMPORT ###
dk_import(https://github.com/google/diff-match-patch/archive/62f2e689f498f9c92dbc588c58750addec9b1654.zip)
#dk_import(https://github.com/google/diff-match-patch/archive/refs/heads/master.zip)



### LINK ###
#dk_include			(${DIFF_MATCH_PATCH}/include)
#Unix_dk_libDebug	(${DIFF_MATCH_PATCH_Debug_Dir}/libdiff-match-patchd.a)
#Unix_dk_libRelease	(${DIFF_MATCH_PATCH_Release_Dir}/libdiff-match-patch.a)
#Windows_dk_libDebug	(${DIFF_MATCH_PATCH_Debug_Dir}/diff-match-patchd.lib)
#Windows_dk_libRelease	(${DIFF_MATCH_PATCH_Release_Dir}/diff-match-patch.lib)


### GENERATE ###
#dk_configure()


### COMPILE ###
#dk_build(${DIFF_MATCH_PATCH} diff-match-patch)
