#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ wasm2brs ############
# https://github.com/MotleyCoderDev/wasm2brs.git

dk_load(dk_builder)

### IMPORT ###
dk_import(https://github.com/MotleyCoderDev/wasm2brs/archive/671b23b8.zip)

# TODO
