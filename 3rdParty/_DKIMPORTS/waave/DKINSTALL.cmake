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


dk_validate(Target_Config  "dk_Target_Config()")
# https://sourceforge.net/projects/waave
# https://sourceforge.net/projects/waave/files/waave/waave-3.01.tar.gz


### DEPEND ###
dk_depend(ffmpeg)
dk_depend(sdl)


### IMPORT ###
dk_import(https://sourceforge.net/projects/waave/files/waave/waave-3.01.tar.gz PATCH)
#dk_import(git://git.code.sf.net/p/waave/code)


### LINK ###
dk_include			(${WAAVE_DIR}/src)
UNIX_dk_libDebug	(${WAAVE_DEBUG_DIR}/libwaave.a)
UNIX_dk_libRelease	(${WAAVE_RELEASE_DIR}/libwaave.a)
Windows_dk_libDebug		(${WAAVE_DEBUG_DIR}/waave.lib)
Windows_dk_libRelease	(${WAAVE_RELEASE_DIR}/waave.lib)


### GENERATE ###
dk_configure(${WAAVE_DIR} ${FFMPEG-DEV_CMAKE} ${SDL_CMAKE})


### COMPILE ###
dk_build(${WAAVE_DIR} waave)
