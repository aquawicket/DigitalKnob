#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ openssl-cmake ############
# https://github.com/viaduck/openssl-cmake.git

dk_load(dk_builder) 

#dk_import(https://github.com/viaduck/openssl-cmake.git)
dk_import(https://github.com/viaduck/openssl-cmake/archive/refs/heads/v3.zip)

