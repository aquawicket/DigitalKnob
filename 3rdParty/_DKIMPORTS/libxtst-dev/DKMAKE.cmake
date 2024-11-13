#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


dk_load(dk_builder)
if(NOT LINUX AND NOT RASPBERRY)
	dk_undepend(libxtst-dev)
	dk_return()
endif()


### INSTALL ###
if(TINYCORE)
	#dk_command(tce-load -wi libXtst-dev.tcz)
	dk_installPackage(libXtst-dev.tcz)
else()
	dk_installPackage(libxtst-dev)
endif()

### LINK ###
## dk_include(/usr/include/gtk-2.0)
## dk_include(/usr/lib/x86_64-linux-gnu/gtk-2.0/include)
SET(CMAKE_CXX_LINK_EXECUTABLE "${CMAKE_CXX_LINK_EXECUTABLE} -lXtst")
