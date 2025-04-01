#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ lodepng ############
# https://github.com/lvandeve/lodepng

dk_load(dk_builder)

dk_import(https://github.com/lvandeve/lodepng/archive/79a61c79.zip)
