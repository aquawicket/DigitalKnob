#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ netsurf ############
# https://git.netsurf-browser.org/netsurf.git
dk_load(dk_builder)

dk_import(https://git.netsurf-browser.org/netsurf.git)