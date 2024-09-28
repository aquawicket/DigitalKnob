#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# https://github.com/jart/cosmopolitan



### IMPORT ###
dk_import(https://github.com/jart/cosmopolitan/archive/refs/heads/master.zip)

