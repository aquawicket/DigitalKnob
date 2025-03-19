#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ libgl1-mesa-dev ############

dk_load(dk_builder)
if(NOT LINUX AND NOT RASPBERRY)
	dk_undepend(libgl1-mesa-dev)
	dk_return()
endif()

### INSTALL ###
dk_installPackage(libgl1-mesa-dev)
