# https://github.com/mouuff/simple-getch
# https://github.com/mouuff/simple-getch/archive/refs/heads/master.zip
if(NOT UNIX_HOST)
	dk_return()
endif()


dk_import(https://github.com/mouuff/simple-getch.git)


### LINK ###
dk_include				(${GETCH}/getch/include)
WIN_dk_libDebug			(${GETCH}/getch/libgetch.a)
WIN_dk_libRelease		(${GETCH}/getch/libgetch.a)
APPLE_dk_libDebug		(${GETCH}/getch/libgetch.a)
APPLE_dk_libRelease		(${GETCH}/getch/libgetch.a)
LINUX_dk_libDebug		(${GETCH}/getch/libgetch.a)
LINUX_dk_libRelease		(${GETCH}/getch/libgetch.a)
RASPBERRY_dk_libDebug	(${GETCH}/getch/libgetch.a)
RASPBERRY_dk_libRelease	(${GETCH}/getch/libgetch.a)
ANDROID_dk_libDebug		(${GETCH}/getch/libgetch.a)
ANDROID_dk_libRelease	(${GETCH}/getch/libgetch.a)


### COMPILE ###
dk_setPath							(${GETCH}/${BUILD_DIR})
LINUX_DEBUG_dk_queueCommand			(../../make)
LINUX_RELEASE_dk_queueCommand		(../../make)
RASPBERRY_DEBUG_dk_queueCommand		(../../make)
RASPBERRY_RELEASE_dk_queueCommand	(../../make)
