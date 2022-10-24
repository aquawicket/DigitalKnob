# https://github.com/aaronmjacobs/Boxer

### OS CHECK ###
RASPBERRY_dk_return()
ANDROID_dk_return()


### DEPEND ###
APPLE_dk_depend(cocoa)


### IMPORT ###
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
dk_queueCommand(${DKCMAKE_BUILD} ${BOXER})


### COMPILE ###
dk_visualStudio	(${BOXER_FOLDER} Boxer) #windows, android
dk_xcode		(${BOXER_FOLDER} Boxer) #mac, ios, iossim
dk_make			(${BOXER_FOLDER} Boxer) #linux, raspberry
