if(NOT CMAKE_HOST_UNIX)
	return()
endif()

### INSTALL ###
DKSET(CURRENT_DIR /usr)
DKCOMMAND(sudo apt -y install libgtk2.0-dev)


find_package(PkgConfig REQUIRED)
pkg_check_modules(GTK REQUIRED gtk+-2.0)

DKDEFINE(USE_GDK)
#message(STATUS "GTK_INCLUDE_DIRS = ${GTK_INCLUDE_DIRS}")
DKINCLUDE(${GTK_INCLUDE_DIRS})
#message(STATUS "GTK_LIBRARIES = ${GTK_LIBRARIES}")
DK_LIB(${GTK_LIBRARIES})