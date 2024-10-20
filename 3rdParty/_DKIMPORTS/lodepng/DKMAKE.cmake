#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


dk_load(dk_builder)
# https://github.com/lvandeve/lodepng
#

#dk_import(https://github.com/lvandeve/lodepng.git)
dk_import(https://github.com/lvandeve/lodepng/archive/refs/heads/master.zip)
