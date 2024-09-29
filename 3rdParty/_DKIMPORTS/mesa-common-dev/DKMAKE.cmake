#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
dk_load(dk_builder)
# https://www.mesa3d.org

if(NOT LINUX AND NOT RASPBERRY)
	dk_undepend(mesa-common-dev)
	dk_return()
endif()


### INSTALL ###
#dk_cd(/usr)
dk_depend(sudo)
dk_command(${SUDO_EXE} apt -y install mesa-common-dev)
