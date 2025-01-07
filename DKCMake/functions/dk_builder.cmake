#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
include_guard()	

dk_validate(host_triple   		"dk_host_triple()")
#dk_validate(TARGET_TRIPLE 		"dk_target_triple()")
dk_validate(target_type		"dk_target_type()")
dk_validate(CONFIG_PATH   		"dk_CONFIG_PATH()")