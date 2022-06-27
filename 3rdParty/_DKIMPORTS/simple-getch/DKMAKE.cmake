# https://github.com/mouuff/simple-getch

if(NOT UNIX_HOST)
	return()
endif()


#dk_set(GETCH_VERSION master)
#dk_set(GETCH_DL https://github.com/mouuff/simple-getch/archive/refs/heads/master.zip)
#dk_set(GETCH_NAME simple-getch-${GETCH_VERSION})
#dk_set(GETCH ${3RDPARTY}/${GETCH_NAME})
#dk_install(${GETCH_DL} ${GETCH})
dk_import(https://github.com/mouuff/simple-getch.git)


### LINK ###
dk_include(${GETCH}/getch/include)
#WIN_dk_libDebug(${GETCH}/getch/libgetch.a)
#WIN_dk_libRelease(${GETCH}/getch/libgetch.a)
#APPLE_dk_libDebug(${GETCH}/getch/libgetch.a)
#APPLE_dk_libRelease(${GETCH}/getch/libgetch.a)
LINUX_dk_libDebug(${GETCH}/getch/libgetch.a)
LINUX_dk_libRelease(${GETCH}/getch/libgetch.a)
RASPBERRY_dk_libDebug(${GETCH}/getch/libgetch.a)
RASPBERRY_dk_libRelease(${GETCH}/getch/libgetch.a)
#ANDROID_dk_libDebug(${GETCH}/getch/libgetch.a)
#ANDROID_dk_libRelease(${GETCH}/getch/libgetch.a)


### COMPILE ###
dk_setPath(${GETCH}/${BUILD_DIR})
LINUX_DEBUG_dk_queueCommand(../../make)
LINUX_RELEASE_dk_queueCommand(../../make)
RASPBERRY_DEBUG_dk_queueCommand(../../make)
RASPBERRY_RELEASE_dk_queueCommand(../../make)