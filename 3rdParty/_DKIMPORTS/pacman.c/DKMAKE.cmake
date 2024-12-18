#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


dk_load(dk_builder)
# https://github.com/floooh/pacman.c.git

#dk_import(https://github.com/floooh/pacman.c.git BRANCH main PATCH)
dk_import(https://github.com/floooh/pacman.c/archive/refs/heads/main.zip PATCH)
