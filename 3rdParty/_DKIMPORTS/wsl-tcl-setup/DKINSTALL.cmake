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


############ wsl-tcl-setup ############
# wsl-tcl-setup_Import=https://github.com/zkedem/wsl-tcl-setup/archive/2467e4ee6d2370dc15690d67d47b2097aae18cae.zip
# tinycorelinux_x86_64=http://www.tinycorelinux.net/15.x/x86_64/release/CorePure64-current.iso


dk_import()

