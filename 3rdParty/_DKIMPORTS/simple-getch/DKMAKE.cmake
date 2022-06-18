# https://github.com/mouuff/simple-getch
if(NOT UNIX_HOST)
	return()
endif()


dk_import(https://github.com/mouuff/simple-getch.git)

#dk_set(GETCH_VERSION master)
#dk_set(GETCH_DL https://github.com/mouuff/simple-getch/archive/refs/heads/master.zip)
#dk_set(GETCH_NAME simple-getch-${GETCH_VERSION})
#dk_set(GETCH ${3RDPARTY}/${GETCH_NAME})
#dk_install(${GETCH_DL} simple-getch ${GETCH})


### LINK ###
dk_include(${GETCH}/getch/include)
#WIN_DEBUG_DKLIB(${GETCH}/getch/libgetch.a)
#WIN_RELEASE_DKLIB(${GETCH}/getch/libgetch.a)
#APPLE_DEBUG_DKLIB(${GETCH}/getch/libgetch.a)
#APPLE_RELEASE_DKLIB(${GETCH}/getch/libgetch.a)
LINUX_DEBUG_DKLIB(${GETCH}/getch/libgetch.a)
LINUX_RELEASE_DKLIB(${GETCH}/getch/libgetch.a)
RASPBERRY_DEBUG_DKLIB(${GETCH}/getch/libgetch.a)
RASPBERRY_RELEASE_DKLIB(${GETCH}/getch/libgetch.a)
#ANDROID_DEBUG_DKLIB(${GETCH}/getch/libgetch.a)
#ANDROID_RELEASE_DKLIB(${GETCH}/getch/libgetch.a)


dk_setPath(${GETCH}/${BUILD_DIR})

#LINUX_DEBUG_dk_setPath(${GETCH}/${OS}/${DEBUG_DIR})
LINUX_DEBUG_dk_queueCommand(../../make)

#LINUX_RELEASE_dk_setPath(${GETCH}/${OS}/${RELEASE_DIR})
LINUX_RELEASE_dk_queueCommand(../../make)


#RASPBERRY_DEBUG_dk_setPath(${GETCH}/${OS}/${DEBUG_DIR})
RASPBERRY_DEBUG_dk_queueCommand(../../make)

#RASPBERRY_RELEASE_dk_setPath(${GETCH}/${OS}/${RELEASE_DIR})
RASPBERRY_RELEASE_dk_queueCommand(../../make)