# https://github.com/aaronmjacobs/Boxer
RASPBERRY_dk_return()
ANDROID_dk_return()


APPLE_dk_depend(cocoa)


dk_import(https://github.com/aaronmjacobs/Boxer.git)


### LINK ###
dk_include			(${BOXER}/include)
dk_include			(${BOXER}/${OS})
WIN_dk_libDebug		(${BOXER}/${OS}/${DEBUG_DIR}/Boxer.lib)
WIN_dk_libRelease	(${BOXER}/${OS}/${RELEASE_DIR}/Boxer.lib)
UNIX_dk_libDebug	(${BOXER}/${OS}/${DEBUG_DIR}/libBoxer.a)
UNIX_dk_libRelease	(${BOXER}/${OS}/${RELEASE_DIR}/libBoxer.a)


### GENERATE ###
dk_setPath(${BOXER}/${BUILD_DIR})
dk_command(${DKCMAKE_BUILD} ${BOXER})


### COMPILE ###
dk_visualStudio				(${BOXER_NAME} Boxer)
dk_xcode					(${BOXER_NAME} Boxer)
LINUX_dk_queueCommand		(make Boxer)
RASPBERRY_dk_queueCommand	(make Boxer)
