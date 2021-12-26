if(NOT UNIX_HOST)
	return()
endif()

# https://github.com/mouuff/simple-getch
#
# https://github.com/mouuff/simple-getch/archive/refs/heads/master.zip


### VERSION ###
DKSET(GETCH_VERSION master)
DKSET(GETCH_NAME simple-getch-${GETCH_VERSION})
DKSET(GETCH_DL https://github.com/mouuff/simple-getch/archive/refs/heads/${GETCH_VERSION}.zip)
DKSET(GETCH ${3RDPARTY}/${GETCH_NAME})


### INSTALL ###
DKINSTALL(${GETCH_DL} simple-getch ${GETCH})


### LINK ###
DKINCLUDE(${GETCH}/getch/include)
#WIN_DEBUG_LIB(${GETCH}/getch/libgetch.a)
#WIN_RELEASE_LIB(${GETCH}/getch/libgetch.a)
#APPLE_DEBUG_LIB(${GETCH}/getch/libgetch.a)
#APPLE_RELEASE_LIB(${GETCH}/getch/libgetch.a)
LINUX_DEBUG_LIB(${GETCH}/getch/libgetch.a)
LINUX_RELEASE_LIB(${GETCH}/getch/libgetch.a)
RASPBERRY_DEBUG_LIB(${GETCH}/getch/libgetch.a)
RASPBERRY_RELEASE_LIB(${GETCH}/getch/libgetch.a)
#ANDROID_DEBUG_LIB(${GETCH}/getch/libgetch.a)
#ANDROID_RELEASE_LIB(${GETCH}/getch/libgetch.a)



"LINUX_DEBUG_DKSETPATH(${GETCH}/${OS}/${DEBUG_DIR})
LINUX_DEBUG_DKQCOMMAND(../../make)

"LINUX_RELEASE_DKSETPATH(${GETCH}/${OS}/${RELEASE_DIR})
LINUX_RELEASE_DKQCOMMAND(../../make)


RASPBERRY_DEBUG_DKSETPATH(${GETCH}/${OS}/${DEBUG_DIR})
RASPBERRY_DEBUG_DKQCOMMAND(../../make)

RASPBERRY_RELEASE_DKSETPATH(${GETCH}/${OS}/${RELEASE_DIR})
RASPBERRY_RELEASE_DKQCOMMAND(../../make)