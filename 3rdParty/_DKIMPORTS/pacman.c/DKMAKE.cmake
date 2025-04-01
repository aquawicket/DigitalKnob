#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ pacman.c ############
# https://github.com/floooh/pacman.c.git

dk_load(dk_builder)

#dk_import(https://github.com/floooh/pacman.c.git BRANCH main PATCH)
dk_import(https://github.com/floooh/pacman.c/archive/refs/heads/main.zip PATCH)
