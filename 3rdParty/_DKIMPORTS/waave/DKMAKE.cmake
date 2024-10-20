#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


dk_load(dk_builder)
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
WIN_dk_libDebug		(${WAAVE_DEBUG_DIR}/waave.lib)
WIN_dk_libRelease	(${WAAVE_RELEASE_DIR}/waave.lib)


### GENERATE ###
dk_configure(${WAAVE_DIR} ${FFMPEG-DEV_CMAKE} ${SDL_CMAKE})


### COMPILE ###
dk_build(${WAAVE_DIR} waave)
