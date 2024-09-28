#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# https://github.com/lz4/lz4.git


### IMPORT ###
#dk_import(https://github.com/lz4/lz4.git BRANCH dev)
dk_import(https://github.com/lz4/lz4/archive/refs/heads/dev.zip)


# TODO
