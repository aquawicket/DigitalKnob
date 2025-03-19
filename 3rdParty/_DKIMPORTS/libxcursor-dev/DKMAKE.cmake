#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


dk_load(dk_builder)
if(NOT LINUX AND NOT RASPBERRY)
	dk_undepend(libxcursor-dev)
	dk_return()
endif()

### INSTALL ###
if(TINYCORE)
	#dk_command(tce-load -wi libXcursor-dev.tcz)
	dk_installPackage(libXcursor-dev.tcz)
else()
	dk_installPackage(libxcursor-dev)
endif()

### LINK ###
SET(CMAKE_CXX_LINK_EXECUTABLE "${CMAKE_CXX_LINK_EXECUTABLE} -lXcursor")
