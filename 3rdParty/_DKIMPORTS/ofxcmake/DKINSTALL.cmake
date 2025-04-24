#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ ofxcmake ############
# https://github.com/tedmoore/ofxCMake

dk_load(dk_builder)

dk_import(https://github.com/tedmoore/ofxCMake/archive/8e26e22f.zip)

# TODO