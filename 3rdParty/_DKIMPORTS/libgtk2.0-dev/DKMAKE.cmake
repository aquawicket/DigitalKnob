### INSTALL ###
DKSET(CURRENT_DIR /usr)
DKCOMMAND(sudo apt -y install libgtk2.0-dev)


### LINK ###
DKINCLUDE(/usr/include/gtk-2.0)
DKINCLUDE(/usr/lib/x86_64-linux-gnu/gtk-2.0/include)
DKINCLUDE(/usr/include/glib-2.0)
DKINCLUDE(/usr/lib/x86_64-linux-gnu/glib-2.0/include)
DKINCLUDE(/usr/include/cairo)
DKINCLUDE(/usr/include/pango-1.0)
DKINCLUDE(/usr/include/gdk-pixbuf-2.0)
SET(CMAKE_CXX_LINK_EXECUTABLE "${CMAKE_CXX_LINK_EXECUTABLE} -lgdk_pixbuf-2.0")
SET(CMAKE_CXX_LINK_EXECUTABLE "${CMAKE_CXX_LINK_EXECUTABLE} -lgdk-x11-2.0")