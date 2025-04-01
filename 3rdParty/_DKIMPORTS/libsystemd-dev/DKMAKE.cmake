#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ libsystemd-dev ############
dk_load(dk_builder)
if(NOT LINUX AND NOT RASPBERRY)
	dk_undepend(libsystemd-dev)
	dk_return()
endif()

### INSTALL ###
dk_installPackage(libsystemd-dev)

### LINK ###
dk_include(/usr/include/systemd)
SET(CMAKE_CXX_LINK_EXECUTABLE "${CMAKE_CXX_LINK_EXECUTABLE} -lsystemd")
