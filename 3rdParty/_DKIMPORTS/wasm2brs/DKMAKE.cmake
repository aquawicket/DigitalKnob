#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# https://github.com/MotleyCoderDev/wasm2brs.git


### IMPORT ###
#dk_import(https://github.com/MotleyCoderDev/wasm2brs.git BRANCH main)
dk_import(https://github.com/MotleyCoderDev/wasm2brs/archive/refs/heads/main.zip)

# TODO
