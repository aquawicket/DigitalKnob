# https://github.com/aaronmjacobs/Boxer
if(RASPBERRY OR ANDROID)
	return() 
endif()

dk_load(dk_return)
dk_return()

APPLE_dk_depend(cocoa)

dk_import(https://github.com/aaronmjacobs/Boxer.git)


### LINK ###
dk_include(${BOXER}/include)
dk_include(${BOXER}/${OS})
WIN_dk_libDebug(${BOXER}/${OS}/${DEBUG_DIR}/Boxer.lib)
WIN_dk_libRelease(${BOXER}/${OS}/${RELEASE_DIR}/Boxer.lib)
UNIX_dk_libDebug(${BOXER}/${OS}/${DEBUG_DIR}/libBoxer.a)
UNIX_dk_libRelease(${BOXER}/${OS}/${RELEASE_DIR}/libBoxer.a)


### GENERATE ###
dk_setPath(${BOXER}/${BUILD_DIR})
dk_command(${DKCMAKE_BUILD} ${BOXER})


### COMPILE ###
dk_visualStudio(${BOXER_NAME} boxer.sln boxer)
dk_xcode(${BOXER_NAME} boxer)
LINUX_dk_queueCommand(make boxer)
RASPBERRY_dk_queueCommand(make boxer)
