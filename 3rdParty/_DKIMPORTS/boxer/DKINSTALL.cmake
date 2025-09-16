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
	dk_disable(boxer)
	dk_return()
endif()

### DEPEND ###
dk_depend(cocoa)
dk_depend(libgtk-3-dev)

### IMPORT ###
dk_import()

### LINK ###
dk_include			(${boxer}/include)
dk_include			(${boxer_Config_Dir})

if(MSVC)
	dk_libDebug		(${boxer_Debug_Dir}/Boxer.lib)
	dk_libRelease	(${boxer_Release_Dir}/Boxer.lib)
else()
	dk_libDebug		(${boxer_Debug_Dir}/libBoxer.a)
	dk_libRelease	(${boxer_Release_Dir}/libBoxer.a)
endif()

### GENERATE ###
dk_configure		(${boxer})

### COMPILE ###
dk_build			(${boxer} Boxer)
