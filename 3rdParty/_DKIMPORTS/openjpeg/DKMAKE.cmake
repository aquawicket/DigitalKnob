#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


dk_load(dk_builder)
# https://github.com/uclouvain/openjpeg


### IMPORT ###
#dk_import(https://github.com/uclouvain/openjpeg.git)
dk_import(https://github.com/uclouvain/openjpeg/archive/refs/heads/master.zip)


# TODO
