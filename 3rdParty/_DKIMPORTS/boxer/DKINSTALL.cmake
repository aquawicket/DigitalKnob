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


############ boxer ############
# https://github.com/aaronmjacobs/Boxer.git

dk_validate(Target_Tuple "dk_Target_Tuple()")
if(Android OR Raspberry)
	dk_undepend(boxer)
	dk_return()
endif()

#dk_getFileParams("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")

### DEPEND ###
dk_depend			(cocoa)
dk_depend			(libgtk-3-dev)

### IMPORT ###
dk_import			(${Boxer_Import})

### LINK ###
dk_include			(${BOXER}/include)
dk_include			(${BOXER_CONFIG_DIR})

if(MSVC)
	dk_libDebug		(${BOXER_DEBUG_DIR}/Boxer.lib)
	dk_libRelease	(${BOXER_RELEASE_DIR}/Boxer.lib)
else()
	dk_libDebug		(${BOXER_DEBUG_DIR}/libBoxer.a)
	dk_libRelease	(${BOXER_RELEASE_DIR}/libBoxer.a)
endif()

### GENERATE ###
dk_configure		(${BOXER})

### COMPILE ###
dk_build			(${BOXER} Boxer)
