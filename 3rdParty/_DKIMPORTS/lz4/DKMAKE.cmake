#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


dk_load(dk_builder)
# https://github.com/lz4/lz4.git


### IMPORT ###
#dk_import(https://github.com/lz4/lz4.git BRANCH dev)
dk_import(https://github.com/lz4/lz4/archive/refs/heads/dev.zip)


# TODO
