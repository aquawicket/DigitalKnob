#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


############ homebrew ############
# https://github.com/Homebrew/brew
# https://brew.sh
# https://raw.githubusercontent.com/Homebrew/install/master/install
# https://github.com/Homebrew/brew/issues/10368

if(NOT Mac_Host)
	dk_disable(homebrew)
	dk_return()
endif()

dk_exec("ruby -e \"$(curl -fsSL ${homebrew_Import})\"")
dk_exec(rm -fr "$(brew --repo homebrew/core)")
dk_exec(brew tap homebrew/core)
