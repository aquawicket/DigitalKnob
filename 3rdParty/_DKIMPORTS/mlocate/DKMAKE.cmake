#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


dk_load(dk_builder)
# mlocate
# EXAMPLE Usage:   $ locate libx11.a

if(NOT UNIX_HOST OR ANDROID)
	dk_undepend(mlocate)
	dk_return()
endif()

### INSTALL ###
dk_cd(/usr)
#dk_depend(sudo)
#dk_command(${SUDO_EXE} apt -y install mlocate)
dk_installPackage(mlocate)
dk_command(${SUDO_EXE} updatedb)
