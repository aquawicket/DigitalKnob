#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# https://github.com/WebAssembly/WASI.git


### IMPORT ###
#dk_import(https://github.com/WebAssembly/WASI.git BRANCH main)
dk_import(https://github.com/WebAssembly/WASI/archive/refs/heads/main.zip)
