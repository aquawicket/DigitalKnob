#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ libglib2.0-dev ############
dk_load(dk_builder)
if(NOT LINUX AND NOT RASPBERRY)
	dk_undepend(libglib2.0-dev)
	dk_return()
endif()

### INSTALL ###
dk_cd(/usr)
dk_depend(sudo)
#dk_command(${SUDO_EXE} apt -y install libglib2.0-dev)
dk_installPackage(libglib2.0-dev)

find_package(PkgConfig REQUIRED)
pkg_check_modules(GLIB REQUIRED glib-2.0)

dk_include(${GLIB_INCLUDE_DIRS})
dk_lib(${GLIB_LIBRARIES})
