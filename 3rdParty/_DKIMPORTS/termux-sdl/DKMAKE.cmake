#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ termux-sdl ############
#https://github.com/lzhiyong/termux-sdl.git
dk_load(dk_builder)

if(NOT ANDROID_HOST)
	return()
endf()

#dk_import(https://github.com/lzhiyong/termux-sdl.git)
dk_import(https://github.com/lzhiyong/termux-sdl/archive/refs/heads/master.zip)
