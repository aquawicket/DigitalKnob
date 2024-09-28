#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# https://github.com/BLAKE2/libb2.git


### IMPORT ###
#dk_import(https://github.com/BLAKE2/libb2.git)
dk_import(https://github.com/BLAKE2/libb2/archive/refs/heads/master.zip)

# TODO
