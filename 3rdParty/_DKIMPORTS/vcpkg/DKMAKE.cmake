#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


dk_load(dk_builder)
# Getting Started  https://vcpkg.io/en/getting-started.html
# Documentation    https://vcpkg.io/en/docs/README.html


#dk_import(https://github.com/Microsoft/vcpkg.git)
dk_import(https://github.com/microsoft/vcpkg/archive/refs/heads/master.zip)


dk_cd(${VCPKG})
WIN_dk_queueCommand(bootstrap-vcpkg.bat)
