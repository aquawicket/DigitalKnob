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


############ homebrew ############
# https://github.com/Homebrew/brew
# https://brew.sh
dk_validate(Config_Path  "dk_Config_Path()")
if(NOT Mac_Host)
	dk_undepend(homebrew)
	dk_return()
endif()

#dk_import(https://github.com/Homebrew/brew)
dk_queueCommand("ruby -e \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)\"")
# https://github.com/Homebrew/brew/issues/10368
dk_queueCommand(rm -fr "$(brew --repo homebrew/core)")
dk_queueCommand(brew tap homebrew/core)
