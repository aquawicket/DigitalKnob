## https://dl.google.com/android/repository/platform-tools_r31.0.3-windows.zip
## https://dl.google.com/android/repository/platform-tools_r31.0.3-darwin.zip
## https://dl.google.com/android/repository/platform-tools_r31.0.3-linux.zip

if(NOT ANDROID)
	return()
endif()

DKDEPEND(android-sdk)


### VERSION ###
DKSET(ANDROIDPLATFORM_VERSION 31.0.3)
DKSET(ANDROIDPLATFORM_SHA1 ???)
DKSET(ANDROIDPLATFORM ${ANDROIDSDK}/platform-tools/${ANDROIDPLATFORM_VERSION})
if(CMAKE_HOST_WIN32)
	DKSET(ANDROIDPLATFORM_DL https://dl.google.com/android/repository/platform-tools_r${ANDROIDPLATFORM_VERSION}-windows.zip)
endif()
if(CMAKE_HOST_APPLE)
	DKSET(ANDROIDPLATFORM_DL https://dl.google.com/android/repository/platform-tools_r${ANDROIDPLATFORM_VERSION}-darwin.zip)
endif()
if(CMAKE_HOST_LINUX)
	DKSET(ANDROIDPLATFORM_DL https://dl.google.com/android/repository/platform-tools_r${ANDROIDPLATFORM_VERSION}-linux.zip)
endif()


### INSTALL ###
DKINSTALL(ANDROIDPLATFORM_DL android-platform-tools android-sdk/platform-tools/${ANDROIDPLATFORM_VERSION})
