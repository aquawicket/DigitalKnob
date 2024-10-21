#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############# libpsl ############
# https://github.com/rockdaboot/libpsl.git
dk_load(dk_builder)

### IMPORT ###
dk_import(https://github.com/rockdaboot/libpsl/archive/490bd6f.zip)



# TODO
