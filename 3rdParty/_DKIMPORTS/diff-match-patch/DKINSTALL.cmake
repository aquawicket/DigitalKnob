#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


dk_load(dk_builder)
# https://github.com/google/diff-match-patch.git
# https://github.com/google/diff-match-patch/archive/62f2e689f498f9c92dbc588c58750addec9b1654.zip


### IMPORT ###
dk_import(https://github.com/google/diff-match-patch/archive/62f2e689f498f9c92dbc588c58750addec9b1654.zip)
#dk_import(https://github.com/google/diff-match-patch/archive/refs/heads/master.zip)



### LINK ###
#dk_include			(${DIFF_MATCH_PATCH}/include)
#UNIX_dk_libDebug	(${DIFF_MATCH_PATCH_DEBUG_DIR}/libdiff-match-patchd.a)
#UNIX_dk_libRelease	(${DIFF_MATCH_PATCH_RELEASE_DIR}/libdiff-match-patch.a)
#Windows_dk_libDebug	(${DIFF_MATCH_PATCH_DEBUG_DIR}/diff-match-patchd.lib)
#Windows_dk_libRelease	(${DIFF_MATCH_PATCH_RELEASE_DIR}/diff-match-patch.lib)


### GENERATE ###
#dk_configure(${DIFF_MATCH_PATCH_DIR})


### COMPILE ###
#dk_build(${DIFF_MATCH_PATCH} diff-match-patch)
