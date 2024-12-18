#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


dk_load(dk_builder)
# https://github.com/netpipe/RocketShip

#dk_import(https://github.com/netpipe/RocketShip.git BRANCH main)
dk_import(https://github.com/netpipe/RocketShip/archive/refs/heads/main.zip)
