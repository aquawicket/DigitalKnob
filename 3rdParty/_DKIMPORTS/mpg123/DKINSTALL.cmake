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


############ mpg123 ############
# https://www.mpg123.de


dk_depend(bash)
dk_depend(autotools)

### IMPORT ###
#dk_import(https://sourceforge.net/projects/mpg123/files/mpg123/1.32.10/mpg123-1.32.10.tar.bz2/download)
dk_import(https://github.com/madebr/mpg123/archive/3c34e2a.zip)


### LINK ###
dk_include			(${MPG123}/include)
if(MSVC)
	dk_libDebug		(${MPG123_Debug_Dir}/mpg123.lib)
	dk_libRelease	(${MPG123_Release_Dir}/mpg123.lib)
else()
	dk_libDebug		(${MPG123_Debug_Dir}/libmpg123.a)
	dk_libRelease	(${MPG123_Release_Dir}/libmpg123.a)
endif()

dk_exec(${BASH_EXE} -c "${AUTORECONF} -f -i")


### GENERATE ###
dk_configure()


### COMPILE ###
dk_build()