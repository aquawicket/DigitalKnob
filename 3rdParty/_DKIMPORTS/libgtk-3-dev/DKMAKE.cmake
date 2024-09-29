#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
dk_load(dk_builder)
if(NOT LINUX AND NOT RASPBERRY)
	dk_undepend(libgtk-3-dev)
	dk_return()
endif()

### INSTALL ###
dk_cd(/usr)
dk_depend(sudo)
dk_command(${SUDO_EXE} apt -y install libgtk-3-dev)

find_package(PkgConfig REQUIRED)
pkg_check_modules(GTK REQUIRED gtk+-3.0)

dk_define(USE_GDK)
#dk_debug("TK_INCLUDE_DIRS)
dk_include(${GTK_INCLUDE_DIRS})
#dk_debug(GTK_LIBRARIES)
dk_lib(${GTK_LIBRARIES})
