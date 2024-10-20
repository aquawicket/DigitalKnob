#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


dk_load(dk_builder)
# https://freeimage.sourceforge.io


### IMPORT ###
dk_import(https://gigenet.dl.sourceforge.net/project/freeimage/Source%20Distribution/3.18.0/FreeImage3180.zip)


# TODO