#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
dk_load(dk_builder)
if(NOT LINUX_HOST)
	dk_undepend(libgtkglext1-dev)
	dk_return()
endif()

### INSTALL ###
dk_cd(/usr)
dk_depend(sudo)
dk_command(${SUDO_EXE} apt -y install libgtkglext1-dev)
