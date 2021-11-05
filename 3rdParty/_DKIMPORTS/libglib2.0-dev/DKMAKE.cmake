### INSTALL ###
DKSET(CURRENT_DIR /usr)
DKCOMMAND(sudo apt -y install libglib2.0-dev)


find_package(PkgConfig REQUIRED)
pkg_check_modules(GLIB REQUIRED glib-2.0)

DKINCLUDE(${GLIB_INCLUDE_DIRS})
DKINCLUDE(/usr/lib/arm-linux-gnueabihf/glib-2.0/include) #glibconfig.h  raspberry
DK_LIB(${GLIB_LIBRARIES})