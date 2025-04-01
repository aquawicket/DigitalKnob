#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ wasi ############
# https://github.com/WebAssembly/WASI.git

dk_load(dk_builder)

### IMPORT ###
dk_import(https://github.com/WebAssembly/WASI/archive/dbe2733c.zip)
