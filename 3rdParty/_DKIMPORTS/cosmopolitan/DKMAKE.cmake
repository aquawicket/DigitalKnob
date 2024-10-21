#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


########### cosmopolitan ############
# https://github.com/jart/cosmopolitan.git
dk_load(dk_builder)

### IMPORT ###
dk_import(https://github.com/jart/cosmopolitan/archive/e4d6eb3.zip)
