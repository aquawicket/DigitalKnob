#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ libb2 ############
# https://github.com/BLAKE2/libb2.git

dk_load(dk_builder)

### IMPORT ###
#dk_import(https://github.com/BLAKE2/libb2.git)
dk_import(https://github.com/BLAKE2/libb2/archive/refs/heads/master.zip)

# TODO
