include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
if(NOT LINUX AND NOT RASPBERRY)
	dk_undepend(libglib2.0-dev)
	dk_return()
endif()

### INSTALL ###
dk_cd(/usr)
dk_command(${SUDO} apt -y install libglib2.0-dev)


find_package(PkgConfig REQUIRED)
pkg_check_modules(GLIB REQUIRED glib-2.0)

#dk_debug(GLIB_INCLUDE_DIRS)
dk_include(${GLIB_INCLUDE_DIRS})
#dk_debug(GLIB_LIBRARIES)
dk_lib(${GLIB_LIBRARIES})
