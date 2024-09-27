#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
dk_load(dk_builder)
if(NOT LINUX AND NOT RASPBERRY)
	dk_undepend(libxfixes-dev)
	dk_return()
endif()

### INSTALL ###
if(TINYCORE)
	dk_command(tce-load -wi libXfixes-dev.tcz)
else()
	dk_command(${SUDO} apt -y install libxfixes-dev)
endif()
