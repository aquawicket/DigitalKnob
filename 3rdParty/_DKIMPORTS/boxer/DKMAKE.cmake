# https://github.com/aaronmjacobs/Boxer
# https://github.com/aquawicket/Boxer
#
# https://github.com/aquawicket/Boxer/archive/refs/heads/master.zip
# https://github.com/aaronmjacobs/Boxer/archive/refs/heads/master.zip
# https://github.com/aaronmjacobs/Boxer/archive/refs/heads/C.zip

if(RASPBERRY)
	return() 
endif()

### DEPENDS ###
if(MAC OR IOS OR IOSSIM)
	DKDEPEND(cocoa)
endif()


### VERSION ###
DKSET(BOXER_VERSION master)
DKSET(BOXER_NAME boxer-${BOXER_VERSION})
DKSET(BOXER_DL https://github.com/aquawicket/Boxer/archive/refs/heads/${BOXER_VERSION}.zip)
DKSET(BOXER ${3RDPARTY}/${BOXER_NAME})


### INSTALL ###
DKINSTALL(${BOXER_DL} boxer ${BOXER})


### LINK ###
DKINCLUDE(${BOXER}/include)
DKINCLUDE(${BOXER}/${OS})
WIN_DEBUG_LIB(${BOXER}/${OS}/${DEBUG_DIR}/Boxer.lib)
WIN_RELEASE_LIB(${BOXER}/${OS}/${RELEASE_DIR}/Boxer.lib)
UNIX_DEBUG_LIB(${BOXER}/${OS}/${DEBUG_DIR}/libBoxer.a)
UNIX_RELEASE_LIB(${BOXER}/${OS}/${RELEASE_DIR}/libBoxer.a)


### COMPILE ###
DKSETPATH(${BOXER}/${BUILD_DIR})
DKCOMMAND(${DKCMAKE_BUILD} ${BOXER})

WIN_VS(${BOXER_NAME} boxer.sln boxer)
MAC_XCODE(${BOXER_NAME} boxer)
IOS_XCODE(${BOXER_NAME} boxer)
IOSSIM_XCODE(${BOXER_NAME} boxer)
LINUX_DKQCOMMAND(make boxer)
RASPBERRY_DKQCOMMAND(make boxer)
ANDROID_VS(${BOXER_NAME} boxer.sln boxer)
