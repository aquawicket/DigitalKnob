if(NOT CMAKE_HOST_WIN32)
	return()
endif()

# https://developer.android.com/studio/releases/sdk-tools
#
# https://dl.google.com/android/repository/sdk-tools-windows-4333796.zip
# https://dl.google.com/android/repository/sdk-tools-darwin-4333796.zip
# https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip


### VERSION ###
DKSET(ANDROIDSDKTOOLS_VERSION 26.2.0) #revision
DKSET(ANDROIDSDKTOOLS_BUILD 4333796)
WIN_HOST_SET(ANDROIDSDKTOOLS_DL https://dl.google.com/android/repository/sdk-tools-windows-${ANDROIDSDKTOOLS_BUILD}.zip)
MAC_HOST_SET(ANDROIDSDKTOOLS_DL https://dl.google.com/android/repository/sdk-tools-darwin-${ANDROIDSDKTOOLS_BUILD}.zip)
LINUX_HOST_SET(ANDROIDSDKTOOLS_DL https://dl.google.com/android/repository/sdk-tools-linux-${ANDROIDSDKTOOLS_BUILD}.zip)
DKSET(ANDROIDSDKTOOLS ${ANDROIDSDK}/tools)


### INSTALL ###
file(MAKE_DIRECTORY ${ANDROIDSDK}/tools)
DKINSTALL(${ANDROIDSDKTOOLS_DL} android-sdk-tools ${ANDROIDSDKTOOLS})
