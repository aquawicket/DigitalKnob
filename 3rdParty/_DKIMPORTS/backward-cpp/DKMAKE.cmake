#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)



# https://github.com/bombela/backward-cpp.git


### IMPORT ###
dk_import(https://github.com/bombela/backward-cpp/archive/51f0700452cf71c57d43c2d028277b24cde32502.zip)
#dk_import(https://github.com/bombela/backward-cpp/archive/refs/heads/master.zip)



### LINK ###
dk_include			(${BACKWARD_CPP_DIR})
#UNIX_dk_libDebug	(${BACKWARD_CPP_DEBUG_DIR}/libbackward.a)
#UNIX_dk_libRelease	(${BACKWARD_CPP_RELEASE_DIR}/libbackward.a)
#WIN_dk_libDebug	(${BACKWARD_CPP_DEBUG_DIR}/backward.lib)
#WIN_dk_libRelease	(${BACKWARD_CPP_RELEASE_DIR}/backward.lib)


if("$ENV{WSL_DISTRO_NAME}" STREQUAL "Alpine")
	dk_delete(${DKPLUGINS_DIR}/DK/backward.cpp NO_HALT)
elseif(ANDROID)
	dk_delete(${DKPLUGINS_DIR}/DK/backward.cpp NO_HALT)
else()
	dk_copy(${BACKWARD_CPP_DIR}/backward.cpp ${DKPLUGINS_DIR}/DK/backward.cpp OVERWRITE)
endif()


### GENERATE ###
#dk_configure(${BACKWARD_CPP_DIR})


### COMPILE ###
#dk_build(${BACKWARD_CPP_DIR})
