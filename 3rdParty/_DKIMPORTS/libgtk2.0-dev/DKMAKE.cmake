### INSTALL ###
DKSET(CURRENT_DIR /usr)
DKCOMMAND(sudo apt -y install libglib2.0-dev)


find_package(PkgConfig REQUIRED)
pkg_check_modules(GLIB2 REQUIRED glib-2.0)

DKINCLUDE(${GLIB_INCLUDE_DIRS})
DK_LIB(${GLIB_LIBRARIES})
