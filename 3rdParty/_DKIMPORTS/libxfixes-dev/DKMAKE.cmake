#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
if(NOT LINUX AND NOT RASPBERRY)
	dk_undepend(libxfixes-dev)
	dk_return()
endif()

### INSTALL ###
if(TINYCORE)
	dk_command(tce-load -wi libXfixes-dev.tcz)
else()
	dk_depend(sudo)
	dk_command(${SUDO_EXE} apt -y install libxfixes-dev)
endif()
