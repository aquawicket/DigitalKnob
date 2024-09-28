include_guard()	
#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)

dk_validate(HOST_TRIPLE   		"dk_host_triple()")
dk_validate(TARGET_TRIPLE 		"dk_TARGET_TRIPLE()")
dk_validate(DKBUILD_TYPE		"dk_BUILD_TYPE()")
dk_validate(CONFIG_PATH   		"dk_MULTI_CONFIG()")
#dk_validate(CMAKE_C_COMPILER	"dk_depend(clang)")
#dk_validate(CMAKE_CXX_COMPILER	"dk_depend(clang)")