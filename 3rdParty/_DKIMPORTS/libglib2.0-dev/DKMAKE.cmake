if(NOT UNIX_HOST)
	return()
endif()

### INSTALL ###
dk_set(CURRENT_DIR /usr)
dk_command(sudo apt -y install libglib2.0-dev)


find_package(PkgConfig REQUIRED)
pkg_check_modules(GLIB REQUIRED glib-2.0)

#dk_debug("GLIB_INCLUDE_DIRS = ${GLIB_INCLUDE_DIRS}")
dk_include(${GLIB_INCLUDE_DIRS})
#dk_debug("GLIB_LIBRARIES = ${GLIB_LIBRARIES}")
dk_lib(${GLIB_LIBRARIES})