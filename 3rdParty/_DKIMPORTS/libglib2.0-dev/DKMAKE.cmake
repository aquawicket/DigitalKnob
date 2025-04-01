#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ libglib2.0-dev ############
dk_load(dk_builder)
if(NOT LINUX AND NOT RASPBERRY)
	dk_undepend(libglib2.0-dev)
	dk_return()
endif()

### INSTALL ###
dk_installPackage(libglib2.0-dev)

find_package(PkgConfig REQUIRED)
pkg_check_modules(GLIB REQUIRED glib-2.0)

dk_include(${GLIB_INCLUDE_DIRS})
dk_lib(${GLIB_LIBRARIES})
