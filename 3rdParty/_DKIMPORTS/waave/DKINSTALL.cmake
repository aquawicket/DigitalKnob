#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


############ waave ############
# https://sourceforge.net/projects/waave
# git://git.code.sf.net/p/waave/code
# https://sourceforge.net/projects/waave/files/waave/waave-3.01.tar.gz

dk_depend(ffmpeg)
dk_depend(sdl)


dk_import()


### LINK ###
dk_include			(${waave}/src)
if(MSVC)
	dk_libDebug		(${waave_Debug_Dir}/waave.lib)
	dk_libRelease	(${waave_Release_Dir}/waave.lib)
else()
	dk_libDebug		(${waave_Debug_Dir}/libwaave.a)
	dk_libRelease	(${waave_Release_Dir}/libwaave.a)
endif()



### GENERATE ###
dk_configure(${waave} ${ffmpeg-dev_CMAKE} ${sdl_CMAKE})


### COMPILE ###
dk_build(${waave} waave)
