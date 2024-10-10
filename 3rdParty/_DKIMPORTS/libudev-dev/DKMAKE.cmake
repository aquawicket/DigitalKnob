#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
dk_load(dk_builder)
if(NOT LINUX AND NOT RASPBERRY)
	dk_undepend(libudev-dev)
	dk_return()
endif()

### INSTALL ###
dk_cd(/usr)
#dk_depend(sudo)
#dk_command(${SUDO_EXE} apt -y install libudev-dev)
dk_installPackage(libudev-dev)


### LINK ###
#dk_include(/usr/include/udev)
SET(CMAKE_CXX_LINK_EXECUTABLE "${CMAKE_CXX_LINK_EXECUTABLE} -ludev")
