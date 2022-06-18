if(NOT UNIX_HOST)
	return()
endif()

### INSTALL ###
dk_set(CURRENT_DIR /usr)
DKCOMMAND(sudo apt -y install libgtk2.0-dev)


find_package(PkgConfig REQUIRED)
pkg_check_modules(GTK REQUIRED gtk+-2.0)

dk_define(USE_GDK)
#DKINFO("GTK_INCLUDE_DIRS = ${GTK_INCLUDE_DIRS}")
dk_include(${GTK_INCLUDE_DIRS})
#DKINFO("GTK_LIBRARIES = ${GTK_LIBRARIES}")
DKLIB(${GTK_LIBRARIES})