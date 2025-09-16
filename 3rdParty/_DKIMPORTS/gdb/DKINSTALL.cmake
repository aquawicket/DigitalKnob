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


############ gdb ############
# https://packages.msys2.org/base/gdb

dk_validate(Target_Config  "dk_Target_Config()")

if(DEFINED ENV{MSYSTEM})
	dk_set(MSYSTEM 		"$ENV{MSYSTEM}")
	dk_set(${MSYSTEM} 	1)
endif()


#dk_depend(msys2)

dk_installPackage(gdb)
