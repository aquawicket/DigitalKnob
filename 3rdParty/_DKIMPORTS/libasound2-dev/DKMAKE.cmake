#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
dk_load(dk_builder)

if(NOT LINUX AND NOT RASPBERRY)
	dk_undepend(libasound2-dev)
	dk_return()
endif()

dk_depend(sudo)

### INSTALL ###
dk_cd(/usr)
dk_command(${SUDO} apt -y install libasound2-dev)

### Tiny Core Linux ###
if(TINYCORE)
	dk_command(tce-load -wi libasound2-dev)
endif()


### LINK ###
dk_include(/usr/include/alsa)
SET(CMAKE_CXX_LINK_EXECUTABLE "${CMAKE_CXX_LINK_EXECUTABLE} -lasound")
