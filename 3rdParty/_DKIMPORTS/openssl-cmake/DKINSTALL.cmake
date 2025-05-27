#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


############ openssl-cmake ############
# https://github.com/viaduck/openssl-cmake.git

dk_validate(CONFIG_PATH  "dk_CONFIG_PATH()") 

#dk_import(https://github.com/viaduck/openssl-cmake.git)
dk_import(https://github.com/viaduck/openssl-cmake/archive/refs/heads/v3.zip)

