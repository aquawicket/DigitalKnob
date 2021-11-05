### INSTALL ###
DKSET(CURRENT_DIR /usr)
DKCOMMAND(sudo apt -y install libgtk2.0-dev)


find_package(PkgConfig REQUIRED)
pkg_check_modules(GTK REQUIRED gtk+-2.0)

DKINCLUDE(${GTK_INCLUDE_DIRS})
DK_LIB(${GTK_LIBRARIES})