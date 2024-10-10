#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
dk_load(dk_builder)
if(NOT LINUX AND NOT RASPBERRY)
	dk_undepend(libxcursor-dev)
	dk_return()
endif()

### INSTALL ###
#dk_cd(/usr)
if(TINYCORE)
	#dk_command(tce-load -wi libXcursor-dev.tcz)
	dk_installPackage(libXcursor-dev.tcz)
else()
	dk_depend(sudo)
	dk_command(${SUDO_EXE} apt -y install libxcursor-dev)
	dk_installPackage(libxcursor-dev)
endif()

### LINK ###
SET(CMAKE_CXX_LINK_EXECUTABLE "${CMAKE_CXX_LINK_EXECUTABLE} -lXcursor")
