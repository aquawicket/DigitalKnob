#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ cpp-subprocess ############
# https://github.com/tsaarni/cpp-subprocess
# NOTE:		Header only library
#			Use #include "subprocess.hpp"
dk_load(dk_builder)

### IMPORT ###
dk_import(https://github.com/tsaarni/cpp-subprocess/archive/3bb8956.zip)

### LINK ###
dk_include(${CPP_SUBPROCESS}/include)
