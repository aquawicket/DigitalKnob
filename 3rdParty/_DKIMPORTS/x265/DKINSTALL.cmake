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
dk_validate(Target_Config  "dk_Target_Config()")

### IMPORT ###
dk_import(https://bitbucket.org/multicoreware/x265_git/get/dd594f59.zip)

### LINK ###
dk_include		(${X265}/include)
dk_include		(${X265}/${Target_Tuple})
dk_libDebug		(${X265.Debug_Dir}/libx265.a)
dk_libRelease	(${X265.Release_Dir}/libx265.a)

### GENERATE ###
dk_configure(${X265})

### COMPILE ###
dk_build()
