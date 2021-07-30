# https://developer.android.com/studio/releases/build-tools
#
# https://dl.google.com/android/repository/build-tools_r30.0.1-windows.zip
# https://dl.google.com/android/repository/build-tools_r30.0.1-darwin.zip
# https://dl.google.com/android/repository/build-tools_r30.0.1-linux.zip
if(NOT ANDROID)
	return()
endif()


### VERSION ###
DKSET(ANDROIDBUILDTOOLS_VERSION 30.0.1)
DKSET(ANDROIDBUILDTOOLS_SHA1 ???)
DKSET(ANDROIDBUILDTOOLS ${ANDROIDSDK}/build-tools/${ANDROIDBUILDTOOLS_VERSION})
if(CMAKE_HOST_WIN32)
	DKSET(ANDROIDBUILDTOOLS_DL https://dl.google.com/android/repository/build-tools_r${ANDROIDBUILDTOOLS_VERSION}-windows.zip)
endif()
if(CMAKE_HOST_APPLE)
	DKSET(ANDROIDBUILDTOOLS_DL https://dl.google.com/android/repository/build-tools_r${ANDROIDBUILDTOOLS_VERSION}-darwin.zip)
endif()
if(CMAKE_HOST_LINUX)
	DKSET(ANDROIDBUILDTOOLS_DL https://dl.google.com/android/repository/build-tools_r${ANDROIDBUILDTOOLS_VERSION}-linux.zip)
endif()


### INSTALL ###
DKINSTALL(ANDROIDBUILDTOOLS_DL android-build-tools android-sdk/build-tools/${ANDROIDBUILDTOOLS_VERSION})
