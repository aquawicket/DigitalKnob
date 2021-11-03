### INSTALL ###
DKSET(CURRENT_DIR /usr)
DKCOMMAND(sudo apt -y install libgtk2.0-dev)


SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} pkg-config gtk+-2.0 --cflags")
SET(CMAKE_CXX_LINK_EXECUTABLE "${CMAKE_CXX_LINK_EXECUTABLE} pkg-config gtk+-2.0 --libs")


#DKINCLUDE(/usr/include/gtk-2.0)
#DKINCLUDE(/usr/include/glib-2.0)
#if(LINUX_32 OR RASPBERRY_32 OR ANDROID_32)
#	DKINCLUDE(/usr/lib/i386-linux-gnu/ for?/gtk-2.0/include)
#	DKINCLUDE(/usr/lib/i386-linux-gnu/ for?/glib-2.0/include)
#else()
#	DKINCLUDE(/usr/lib/x86_64-linux-gnu/gtk-2.0/include)
#	DKINCLUDE(/usr/lib/x86_64-linux-gnu/glib-2.0/include)
#endif()
#DKINCLUDE(/usr/include/cairo)
#DKINCLUDE(/usr/include/pango-1.0)
#DKINCLUDE(/usr/include/gdk-pixbuf-2.0)
#SET(CMAKE_CXX_LINK_EXECUTABLE "${CMAKE_CXX_LINK_EXECUTABLE} -lgdk_pixbuf-2.0")
#SET(CMAKE_CXX_LINK_EXECUTABLE "${CMAKE_CXX_LINK_EXECUTABLE} -lgdk-x11-2.0")
