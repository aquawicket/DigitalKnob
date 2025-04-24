#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ termux-sdl ############
#https://github.com/lzhiyong/termux-sdl.git
dk_load(dk_builder)

if(NOT ANDROID_HOST)
	return()
endif()

#dk_import(https://github.com/lzhiyong/termux-sdl.git)
dk_import(https://github.com/lzhiyong/termux-sdl/archive/refs/heads/master.zip)
