if(NOT ANDROID)
	return()
endif()

### VERSION ###
DKSET(ANDROIDNDK_VERSION r20b)
DKSET(ANDROIDNDK_NAME android-ndk-r20b-windows-x86_64)
DKSET(ANDROIDNDK_BUILD 20.1.5948944)
DKSET(ANDROIDNDK_FILE android-ndk-r20b-windows-x86_64.zip)
DKSET(ANDROIDNDK_DL https://dl.google.com/android/repository/android-ndk-r20b-windows-x86_64.zip)
DKSET(ANDROIDNDK_SHA1 ead0846608040b8344ad2bc9bc721b88cf13fb8d)

#DKSET(ANDROIDNDK_VERSION r21e)
#DKSET(ANDROIDNDK_NAME android-ndk-r21e-windows-x86_64)
#DKSET(ANDROIDNDK_BUILD 21.4.7075529)
#DKSET(ANDROIDNDK_FILE android-ndk-r21e-windows-x86_64.zip)
#DKSET(ANDROIDNDK_DL https://dl.google.com/android/repository/android-ndk-r21e-windows-x86_64.zip)
#DKSET(ANDROIDNDK_SHA1 fc44fea8bb3f5a6789821f40f41dce2d2cd5dc30)

#DKSET(ANDROIDNDK_VERSION r22b)
#DKSET(ANDROIDNDK_NAME android-ndk-r22b-windows-x86_64)
#DKSET(ANDROIDNDK_BUILD 22.1.7171670)
#DKSET(ANDROIDNDK_FILE android-ndk-r22b-windows-x86_64.zip)
#DKSET(ANDROIDNDK_DL https://dl.google.com/android/repository/android-ndk-r22b-windows-x86_64.zip)
#DKSET(ANDROIDNDK_SHA1 96ba1a049303cf6bf3ee84cfd64d6bcd43486a50)

DKSET(ANDROIDNDK ${ANDROIDSDK}/ndk/${ANDROIDNDK_BUILD})
DKSETENV("NDK_ROOT" ${ANDROIDNDK})

file(MAKE_DIRECTORY ${3RDPARTY}/android-sdk/ndk)
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
