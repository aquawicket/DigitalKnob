#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# https://github.com/bombela/backward-cpp.git


### IMPORT ###
#dk_import(https://github.com/bombela/backward-cpp.git)
dk_import(https://github.com/bombela/backward-cpp/archive/refs/heads/master.zip)



### LINK ###
dk_include			(${BACKWARD_CPP_DIR})
#UNIX_dk_libDebug	(${BACKWARD_CPP_DEBUG_DIR}/libbackward.a)
#UNIX_dk_libRelease	(${BACKWARD_CPP_RELEASE_DIR}/libbackward.a)
#WIN_dk_libDebug	(${BACKWARD_CPP_DEBUG_DIR}/backward.lib)
#WIN_dk_libRelease	(${BACKWARD_CPP_RELEASE_DIR}/backward.lib)

if(ANDROID)
	dk_delete(${DKPLUGINS_DIR}/DK/backward.cpp NO_HALT)
else()
	dk_copy(${BACKWARD_CPP_DIR}/backward.cpp ${DKPLUGINS_DIR}/DK/backward.cpp OVERWRITE)
endif()


### GENERATE ###
#dk_configure(${BACKWARD_CPP_DIR})


### COMPILE ###
#dk_build(${BACKWARD_CPP_DIR})
