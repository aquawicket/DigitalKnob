#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# https://github.com/uclouvain/openjpeg


### IMPORT ###
#dk_import(https://github.com/uclouvain/openjpeg.git)
dk_import(https://github.com/uclouvain/openjpeg/archive/refs/heads/master.zip)


# TODO
