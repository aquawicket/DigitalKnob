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


############ libglib2.0-dev ############
dk_validate(Config_Path  "dk_Config_Path()")
if(NOT Linux AND NOT Raspberry)
	dk_undepend(libglib2.0-dev)
	dk_return()
endif()

### INSTALL ###
dk_installPackage(libglib2.0-dev)

find_package(PkgConfig REQUIRED)
pkg_check_modules(GLIB REQUIRED glib-2.0)

dk_include(${GLIB_INCLUDE_DIRS})
dk_lib(${GLIB_LIBRARIES})
