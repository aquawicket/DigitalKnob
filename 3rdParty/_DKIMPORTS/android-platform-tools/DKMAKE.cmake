## https://dl.google.com/android/repository/platform-tools_r31.0.3-windows.zip
## https://dl.google.com/android/repository/platform-tools_r31.0.3-darwin.zip
## https://dl.google.com/android/repository/platform-tools_r31.0.3-linux.zip
if(NOT ANDROID)
	return()
endif()


### VERSION ###
DKSET(ANDROIDPLATFORMTOOLS_VERSION 31.0.3)
DKSET(ANDROIDPLATFORMTOOLS_SHA1 ???)
DKSET(ANDROIDPLATFORMTOOLS ${ANDROIDSDK}/platform-tools/${ANDROIDPLATFORMTOOLS_VERSION})
if(CMAKE_HOST_WIN32)
	DKSET(ANDROIDPLATFORMTOOLS_DL https://dl.google.com/android/repository/platform-tools_r${ANDROIDPLATFORMTOOLS_VERSION}-windows.zip)
endif()
if(CMAKE_HOST_APPLE)
	DKSET(ANDROIDPLATFORMTOOLS_DL https://dl.google.com/android/repository/platform-tools_r${ANDROIDPLATFORMTOOLS_VERSION}-darwin.zip)
endif()
if(CMAKE_HOST_LINUX)
	DKSET(ANDROIDPLATFORMTOOLS_DL https://dl.google.com/android/repository/platform-tools_r${ANDROIDPLATFORMTOOLS_VERSION}-linux.zip)
endif()


### INSTALL ###
DKINSTALL(ANDROIDPLATFORMTOOLS_DL android-platform-tools android-sdk/platform-tools/${ANDROIDPLATFORMTOOLS_VERSION})
