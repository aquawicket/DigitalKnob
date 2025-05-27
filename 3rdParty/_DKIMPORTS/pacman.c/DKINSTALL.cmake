#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


############ pacman.c ############
# https://github.com/floooh/pacman.c.git

dk_validate(CONFIG_PATH  "dk_CONFIG_PATH()")

#dk_import(https://github.com/floooh/pacman.c.git BRANCH main PATCH)
dk_import(https://github.com/floooh/pacman.c/archive/refs/heads/main.zip PATCH)
