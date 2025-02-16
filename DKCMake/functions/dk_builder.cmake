#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
include_guard()	

dk_validate(host_triple   		"dk_host_triple()")
dk_validate(CONFIG_PATH   		"dk_CONFIG_PATH()")
