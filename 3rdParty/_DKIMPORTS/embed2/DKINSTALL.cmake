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


############ embed ############
# https://github.com/batterycenter/embed



### DEPENDS ###
#dk_depend(libname)

### INSTALL ###
#dk_getFileParams	("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")
dk_import			("https://github.com/batterycenter/embed/archive/465081903d97ff1ed05e1fd5d0b3c8032a4a26a6.zip")

### LINK ###
dk_include			(${EMBED}/include)
if(Unix)
	dk_libDebug		(${EMBED_Debug_Dir}/libembed.a)
	dk_libRelease	(${EMBED_Release_Dir}/libembed.a)
else()
	dk_libDebug		(${EMBED_Debug_Dir}/libembed.lib)
	dk_libRelease	(${EMBED_Release_Dir}/libembed.lib)
endif()

### GENERATE ###
dk_configure()


### COMPILE ###
dk_build()
