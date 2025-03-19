#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ rocketship ############
# https://github.com/netpipe/RocketShip

dk_load(dk_builder)

#dk_import(https://github.com/netpipe/RocketShip.git BRANCH main)
dk_import(https://github.com/netpipe/RocketShip/archive/refs/heads/main.zip)
