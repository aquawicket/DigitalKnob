#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ cpp-subprocess ############
# https://github.com/tsaarni/cpp-subprocess
# NOTE:		Header only library
#			Use #include "subprocess.hpp"
dk_load(dk_builder)

### IMPORT ###
dk_import(https://github.com/tsaarni/cpp-subprocess/archive/3bb8956.zip)

### LINK ###
dk_include(${CPP_SUBPROCESS}/include)
