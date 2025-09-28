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


############ x265 ############
# https://bitbucket.org/multicoreware/x265_git.git
# https://bitbucket.org/multicoreware/x265_git/get/dd594f59.zip


### IMPORT ###
dk_import()

### LINK ###
dk_include		(${x265}/include)
dk_include		(${x265}/${Target_Tuple})
dk_libDebug		(${x265_Debug_Dir}/libx265.a)
dk_libRelease	(${x265_Release_Dir}/libx265.a)

### GENERATE ###
dk_configure(${x265})

### COMPILE ###
dk_build()
