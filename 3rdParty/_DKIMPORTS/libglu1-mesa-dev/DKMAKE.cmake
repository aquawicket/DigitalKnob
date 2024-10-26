#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ libglu1-mesa-dev ############
dk_load(dk_builder)
if(NOT LINUX AND NOT RASPBERRY)
	dk_undepend(libglu1-mesa-dev)
	dk_return()
endif()

### INSTALL ###
dk_cd(/usr)
#dk_depend(sudo)
#dk_command(${SUDO_EXE} apt -y install libglu1-mesa-dev)
dk_installPackage(libglu1-mesa-dev)
