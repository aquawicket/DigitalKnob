#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ sw ############
# https://github.com/SoftwareNetwork/sw

dk_load(dk_builder)

#WIN_dk_import(https://github.com/SoftwareNetwork/sw.git)
WIN_dk_import(https://github.com/SoftwareNetwork/sw/archive/refs/heads/b0.4.5.zip)
