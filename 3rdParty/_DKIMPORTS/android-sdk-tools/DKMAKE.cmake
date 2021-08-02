# https://developer.android.com/studio/releases/sdk-tools
#
# https://dl.google.com/android/repository/sdk-tools-windows-4333796.zip
# https://dl.google.com/android/repository/sdk-tools-darwin-4333796.zip
# https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
if(NOT ANDROID)
	return()
endif()


### VERSION ###
DKSET(ANDROIDSDKTOOLS_VERSION 26.2.0) #revision
DKSET(ANDROIDSDKTOOLS_BUILD 4333796)
DKSET(ANDROIDSDKTOOLS_SHA1 ???)
DKSET(ANDROIDSDKTOOLS ${ANDROIDSDK}/sdk-tools/${ANDROIDSDKTOOLS_VERSION})
if(CMAKE_HOST_WIN32)
	DKSET(ANDROIDSDKTOOLS_DL https://dl.google.com/android/repository/sdk-tools-windows-${ANDROIDSDKTOOLS_BUILD}.zip)
endif()
if(CMAKE_HOST_APPLE)
	DKSET(ANDROIDSDKTOOLS_DL https://dl.google.com/android/repository/sdk-tools-darwin-${ANDROIDSDKTOOLS_BUILD}.zip)
endif()
if(CMAKE_HOST_LINUX)
	DKSET(ANDROIDSDKTOOLS_DL https://dl.google.com/android/repository/sdk-tools-linux-${ANDROIDSDKTOOLS_BUILD}.zip)
endif()


### INSTALL ###
file(MAKE_DIRECTORY ${ANDROIDSDK}/sdk-tools)
DKINSTALL(${ANDROIDSDKTOOLS_DL} android-sdk-tools ${ANDROIDSDKTOOLS})
