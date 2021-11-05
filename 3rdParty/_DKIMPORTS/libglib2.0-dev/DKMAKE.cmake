### INSTALL ###
DKSET(CURRENT_DIR /usr)
DKCOMMAND(sudo apt -y install libglib2.0-dev)


find_package(PkgConfig REQUIRED)
pkg_check_modules(GLIB REQUIRED glib-2.0)

message(STATUS "GLIB_INCLUDE_DIRS = ${GLIB_INCLUDE_DIRS}")
DKINCLUDE(${GLIB_INCLUDE_DIRS})
DKINCLUDE(/usr/lib/arm-linux-gnueabihf/glib-2.0/include) #glibconfig.h  raspberry
message(STATUS "GLIB_LIBRARIES = ${GLIB_LIBRARIES}")
DK_LIB(${GLIB_LIBRARIES})