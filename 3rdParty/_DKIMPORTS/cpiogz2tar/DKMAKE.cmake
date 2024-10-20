#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


# https://github.com/zkedem/cpiogz2tar



dk_import(https://github.com/zkedem/cpiogz2tar/archive/1c3ea923a390bda86b6ddba1411b34dc0f1813c0.zip)
