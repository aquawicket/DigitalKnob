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


###### embed ######
# https://github.com/MKlimenko/embed
# https://github.com/MKlimenko/embed/archive/refs/heads/master.zip

### INSTALL ###
#dk_getFileParams("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")
dk_import		(${embed_Import} NAME embed)

dk_depend(tbb)


### LINK ###
dk_include			(${embed}/include)
if(MSVC)
	dk_libDebug		(${embed_Debug_Dir}/embed.lib)
	dk_libRelease	(${embed_Release_Dir}/embed.lib)
else()
	dk_libDebug		(${embed_Debug_Dir}/libembed.a)
	dk_libRelease	(${embed_Release_Dir}/libembed.a)
endif()

### GENERATE ###
dk_configure(${embed} ${tbb_Cmake}) # -fexperimental-library


### COMPILE ###
dk_build()