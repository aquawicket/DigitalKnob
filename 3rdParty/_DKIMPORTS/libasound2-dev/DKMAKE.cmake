#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
dk_load(dk_builder)

if(NOT LINUX AND NOT RASPBERRY)
	dk_undepend(libasound2-dev)
	dk_return()
endif()


### INSTALL ###
dk_cd(/usr)
dk_depend(sudo)
#dk_command(${SUDO_EXE} apt -y install libasound2-dev)
dk_installPackage(libasound2-dev)

### Tiny Core Linux ###
#if(TINYCORE)
#	dk_command(tce-load -wi libasound2-dev)
#endif()


### LINK ###
dk_include(/usr/include/alsa)
SET(CMAKE_CXX_LINK_EXECUTABLE "${CMAKE_CXX_LINK_EXECUTABLE} -lasound")
