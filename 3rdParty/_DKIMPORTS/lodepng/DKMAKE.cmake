#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ lodepng ############
# https://github.com/lvandeve/lodepng

dk_load(dk_builder)

dk_import(https://github.com/lvandeve/lodepng/archive/79a61c79.zip)
