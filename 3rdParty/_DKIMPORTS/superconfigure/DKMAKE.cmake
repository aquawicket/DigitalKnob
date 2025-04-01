#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ superconfigure ############
# https://github.com/ahgamut/superconfigure?tab=readme-ov-file



dk_import(https://github.com/ahgamut/superconfigure/archive/42c2388d28ebc0982c7b313d33104022df39eecb.zip)