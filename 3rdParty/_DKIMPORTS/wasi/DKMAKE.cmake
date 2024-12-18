#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ wasi ############
# https://github.com/WebAssembly/WASI.git
dk_load(dk_builder)

### IMPORT ###
dk_import(https://github.com/WebAssembly/WASI/archive/dbe2733c.zip)
