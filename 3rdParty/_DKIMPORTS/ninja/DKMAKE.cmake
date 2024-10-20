#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


dk_load(dk_builder)
# https://github.com/ninja-build/ninja.git


#dk_import(https://github.com/ninja-build/ninja.git)
dk_import(https://github.com/ninja-build/ninja/archive/refs/heads/master.zip)


dk_include(${NINJA})

dk_libDebug(${NINJA}/${triple}/${DEBUG_DIR}/ninja.exe)
dk_libRelease(${NINJA}/${triple}/${DEBUG_DIR}/ninja.exe)

dk_configure(${NINJA})

dk_build(${NINJA})