#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############# libpsl ############
# https://github.com/rockdaboot/libpsl.git

dk_load(dk_builder)

### IMPORT ###
dk_import(https://github.com/rockdaboot/libpsl/archive/490bd6f.zip)



# TODO
