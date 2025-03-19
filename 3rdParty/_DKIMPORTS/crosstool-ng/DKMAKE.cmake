#!/usr/bin/cmake -P
include_guard()
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ../../../DKCMake/functions/) # From this path to DK.cmake
endif()
if(NOT EXISTS ${DKCMAKE_FUNCTIONS_DIR_})
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ${CMAKE_SOURCE_DIR}/../../../../../../../DKCMake/functions/) # From try compile to Dk.cmake 
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")



###### [crosstool-ng] ######
# https://github.com/crosstool-ng/crosstool-ng

dk_import(https://github.com/crosstool-ng/crosstool-ng/archive/32f288e.zip)
