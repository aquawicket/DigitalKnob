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


############ vcpkg ############
# Getting Started  https://vcpkg.io/en/getting-started.html
# Documentation    https://vcpkg.io/en/docs/README.html
dk_validate(Target_Config  "dk_Target_Config()")

dk_import(https://github.com/microsoft/vcpkg/archive/cff6ed45.zip)

dk_chdir(${VCPKG})

if(Windows)
	dk_queueCommand(bootstrap-vcpkg.bat)
endif()