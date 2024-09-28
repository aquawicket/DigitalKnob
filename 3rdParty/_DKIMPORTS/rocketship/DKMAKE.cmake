#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# https://github.com/netpipe/RocketShip

#dk_import(https://github.com/netpipe/RocketShip.git BRANCH main)
dk_import(https://github.com/netpipe/RocketShip/archive/refs/heads/main.zip)
