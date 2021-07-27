## REPLACED BY android-sdk 3rdParty library
return()

if(NOT ANDROID)
	return()
endif()

DKDEPEND(jdk)


### VERSION ###
#DKSET(ANDROIDNDK_VERSION r16b)
#DKSET(ANDROIDNDK_VERSION r17c)
#DKSET(ANDROIDNDK_VERSION r18b)
#DKSET(ANDROIDNDK_VERSION r19c)
#DKSET(ANDROIDNDK_VERSION r20b)
DKSET(ANDROIDNDK_VERSION r21e)
#DKSET(ANDROIDNDK_VERSION r22b)


### INSTALL ###
if(CMAKE_HOST_WIN32)
	## https://dl.google.com/android/repository/android-ndk-r21e-windows-x86_64.zip
	DKINSTALL(https://dl.google.com/android/repository/android-ndk-${ANDROIDNDK_VERSION}-windows-x86_64.zip android-ndk android-ndk-${ANDROIDNDK_VERSION}-windows-x86_64)
	DKSET(NDK ${3RDPARTY}/android-ndk-${ANDROIDNDK_VERSION}-windows-x86_64)
endif()

if(CMAKE_HOST_APPLE)
	## https://dl.google.com/android/repository/android-ndk-r21e-darwin-x86_64.dmg
	DKINSTALL(https://dl.google.com/android/repository/android-ndk-${ANDROIDNDK_VERSION}-darwin-x86_64.zip android-ndk android-ndk-${ANDROIDNDK_VERSION}-darwin-x86_64)
	DKSET(NDK ${3RDPARTY}/android-ndk-${ANDROIDNDK_VERSION}-darwin-x86_64)
endif()

if(CMAKE_HOST_LINUX)
	## https://dl.google.com/android/repository/android-ndk-r21e-linux-x86_64.zip
	DKINSTALL(https://dl.google.com/android/repository/android-ndk-${ANDROIDNDK_VERSION}-linux-x86_64.zip android-ndk android-ndk-${ANDROIDNDK_VERSION}-linux-x86_64)
	DKSET(NDK ${3RDPARTY}/android-ndk-${ANDROIDNDK_VERSION}-linux-x86_64)
endif()
