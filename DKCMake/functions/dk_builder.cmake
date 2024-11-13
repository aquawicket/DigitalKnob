include_guard()	
#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)

dk_validate(host_triple   		"dk_host_triple()")
#dk_validate(TARGET_TRIPLE 		"dk_target_triple()")
dk_validate(DKBUILD_TYPE		"dk_DKBUILD_TYPE()")
dk_validate(CONFIG_PATH   		"dk_CONFIG_PATH()")