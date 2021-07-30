if(NOT ANDROID)
	return()
endif()


if(CMAKE_HOST_WIN32)
	DKSET(ANDROIDNDK_TAG windows-x86_64)
endif()
if(CMAKE_HOST_APPLE)
	DKSET(ANDROIDNDK_TAG darwin-x86_64)
endif()
if(CMAKE_HOST_LINUX)
	DKSET(ANDROIDNDK_TAG linux-x86_64)
endif()

### VERSION ###
DKSET(ANDROIDNDK_VERSION r22b)
DKSET(ANDROIDNDK_NAME android-ndk-r22b-windows-x86_64)
DKSET(ANDROIDNDK_BUILD 22.1.7171670)
DKSET(ANDROIDNDK_FILE android-ndk-r22b-windows-x86_64.zip)
DKSET(ANDROIDNDK_DL https://dl.google.com/android/repository/android-ndk-r22b-windows-x86_64.zip)
DKSET(ANDROIDNDK_SHA1 96ba1a049303cf6bf3ee84cfd64d6bcd43486a50)
DKSET(ANDROIDNDK ${ANDROIDSDK}/ndk/${ANDROIDNDK_BUILD})
DKSETENV("NDK_ROOT" ${ANDROIDNDK})


### INSTALL ###
if(CMAKE_HOST_WIN32)
	## https://dl.google.com/android/repository/android-ndk-r21e-windows-x86_64.zip
	DKINSTALL(https://dl.google.com/android/repository/${ANDROIDNDK_FILE} android-ndk android-sdk/ndk/${ANDROIDNDK_BUILD})
endif()

if(CMAKE_HOST_APPLE)
	## https://dl.google.com/android/repository/android-ndk-r21e-darwin-x86_64.dmg
	DKINSTALL(https://dl.google.com/android/repository/android-ndk-${ANDROIDNDK_VERSION}-darwin-x86_64.zip android-ndk android-sdk/ndk/${ANDROIDNDK_BUILD})
endif()

if(CMAKE_HOST_LINUX)
	## https://dl.google.com/android/repository/android-ndk-r21e-linux-x86_64.zip
	DKINSTALL(https://dl.google.com/android/repository/android-ndk-${ANDROIDNDK_VERSION}-linux-x86_64.zip android-ndk android-sdk/ndk/${ANDROIDNDK_BUILD})
endif()
