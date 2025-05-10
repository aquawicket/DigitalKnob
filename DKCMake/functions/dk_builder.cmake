#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()	

dk_validate(Host_Tuple   		"dk_Host_Tuple()")
dk_validate(CONFIG_PATH   		"dk_CONFIG_PATH()")
