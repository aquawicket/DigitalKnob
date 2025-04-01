#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ libandroid-spawn ############
# https://github.com/termux/termux-packages/blob/master/packages/libandroid-spawn/build.sh

dk_load(dk_builder)

dk_installPackage(libandroid-spawn)