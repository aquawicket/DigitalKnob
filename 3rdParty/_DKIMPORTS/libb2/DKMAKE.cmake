#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


dk_load(dk_builder)
# https://github.com/BLAKE2/libb2.git


### IMPORT ###
#dk_import(https://github.com/BLAKE2/libb2.git)
dk_import(https://github.com/BLAKE2/libb2/archive/refs/heads/master.zip)

# TODO
