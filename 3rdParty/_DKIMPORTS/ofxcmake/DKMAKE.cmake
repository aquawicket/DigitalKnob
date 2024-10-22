#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ ofxcmake ############
dk_load(dk_builder)
# https://github.com/tedmoore/ofxCMake

dk_import(https://github.com/tedmoore/ofxCMake/archive/8e26e22f.zip)

# TODO