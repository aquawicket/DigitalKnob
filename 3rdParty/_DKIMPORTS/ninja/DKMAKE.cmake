#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############# ninja ############
# https://github.com/ninja-build/ninja.git
dk_load(dk_builder)

dk_import(https://github.com/ninja-build/ninja/archive/f8ce3b32.zip)

dk_include(${NINJA})

dk_libDebug(${NINJA_DEBUG_DIR}/ninja.exe)
dk_libRelease(${NINJA_DEBUG_DIR}/ninja.exe)

dk_configure(${NINJA})

dk_build(${NINJA})
