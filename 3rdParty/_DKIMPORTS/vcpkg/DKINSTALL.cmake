#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ vcpkg ############
# Getting Started  https://vcpkg.io/en/getting-started.html
# Documentation    https://vcpkg.io/en/docs/README.html
dk_load(dk_builder)

dk_import(https://github.com/microsoft/vcpkg/archive/cff6ed45.zip)

dk_chdir(${VCPKG})

if(WIN)
	dk_queueCommand(bootstrap-vcpkg.bat)
endif()