#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ libgtk-3-dev ############
dk_load(dk_builder)
if(NOT LINUX AND NOT RASPBERRY)
	dk_undepend(libgtk-3-dev)
	dk_return()
endif()

### INSTALL ###
dk_installPackage(libgtk-3-dev)

find_package(PkgConfig REQUIRED)
pkg_check_modules(GTK REQUIRED gtk+-3.0)

dk_define(USE_GDK)
dk_include(${GTK_INCLUDE_DIRS})
dk_lib(${GTK_LIBRARIES})
