if(NOT UNIX_HOST)
	return()
endif()

### INSTALL ###
dk_set(CURRENT_DIR /usr)
DKCOMMAND(sudo apt -y install libglib2.0-dev)


find_package(PkgConfig REQUIRED)
pkg_check_modules(GLIB REQUIRED glib-2.0)

#DKINFO("GLIB_INCLUDE_DIRS = ${GLIB_INCLUDE_DIRS}")
DKINCLUDE(${GLIB_INCLUDE_DIRS})
#DKINFO("GLIB_LIBRARIES = ${GLIB_LIBRARIES}")
DKLIB(${GLIB_LIBRARIES})