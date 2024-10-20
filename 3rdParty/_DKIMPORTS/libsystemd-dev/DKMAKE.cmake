#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


dk_load(dk_builder)
if(NOT LINUX AND NOT RASPBERRY)
	dk_undepend(libsystemd-dev)
	dk_return()
endif()

### INSTALL ###
#dk_cd(/usr)
#dk_depend(sudo)
#dk_command(${SUDO_EXE} apt -y install libsystemd-dev)
dk_installPackage(libsystemd-dev)


### LINK ###
dk_include(/usr/include/systemd)
SET(CMAKE_CXX_LINK_EXECUTABLE "${CMAKE_CXX_LINK_EXECUTABLE} -lsystemd")
