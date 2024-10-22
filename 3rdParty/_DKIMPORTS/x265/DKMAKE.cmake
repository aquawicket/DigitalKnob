#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ x265 ############
# https://bitbucket.org/multicoreware/x265_git.git
dk_load(dk_builder)

### IMPORT ###
dk_import(https://bitbucket.org/multicoreware/x265_git/get/dd594f59.zip)

### LINK ###
dk_include		(${X265}/include)
dk_include		(${X265}/${triple})
dk_libDebug		(${X265_DEBUG_DIR}/libx265.a)
dk_libRelease	(${X265_RELEASE_DIR}/libx265.a)

### GENERATE ###
dk_configure(${X265})

### COMPILE ###
dk_build(${X265})
