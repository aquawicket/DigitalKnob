# https://github.com/aaronmjacobs/Boxer

if(RASPBERRY OR ANDROID)
	return() 
endif()

### DEPENDS ###
if(APPLE)
	DKDEPEND(cocoa)
endif()


### IMPORT ###
dk_import(https://github.com/aaronmjacobs/Boxer.git)
#dk_import(https://github.com/aaronmjacobs/Boxer/archive/01c17f6a9cd66068f7890ea887ab3b9a673f0434.zip)


### LINK ###
DKINCLUDE(${BOXER}/include)
DKINCLUDE(${BOXER}/${OS})
WIN_DEBUG_DKLIB(${BOXER}/${OS}/${DEBUG_DIR}/Boxer.lib)
WIN_RELEASE_DKLIB(${BOXER}/${OS}/${RELEASE_DIR}/Boxer.lib)
UNIX_DEBUG_DKLIB(${BOXER}/${OS}/${DEBUG_DIR}/libBoxer.a)
UNIX_RELEASE_DKLIB(${BOXER}/${OS}/${RELEASE_DIR}/libBoxer.a)


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
