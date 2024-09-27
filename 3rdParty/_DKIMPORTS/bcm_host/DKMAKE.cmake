#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
dk_load(dk_builder)
# bcm_host

RASPBERRY_dk_lib	(bcm_host)
