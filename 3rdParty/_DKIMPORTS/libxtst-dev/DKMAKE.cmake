#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
dk_load(dk_builder)
if(NOT LINUX AND NOT RASPBERRY)
	dk_undepend(libxtst-dev)
	dk_return()
endif()


### INSTALL ###
#dk_cd(/usr)
if(TINYCORE)
	#dk_command(tce-load -wi libXtst-dev.tcz)
	dk_installPackage(libXtst-dev.tcz)
else()
	#dk_depend(sudo)
	#dk_command(${SUDO_EXE} apt -y install libxtst-dev)
	dk_installPackage(libxtst-dev)
endif()

### LINK ###
## dk_include(/usr/include/gtk-2.0)
## dk_include(/usr/lib/x86_64-linux-gnu/gtk-2.0/include)
SET(CMAKE_CXX_LINK_EXECUTABLE "${CMAKE_CXX_LINK_EXECUTABLE} -lXtst")
