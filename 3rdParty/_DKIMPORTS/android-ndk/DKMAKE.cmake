## NOTES:  Android NDK r16b - Boost FileSystem fails to build



if(NOT ANDROID)
	return()
endif()

### VERSION ###
#DKSET(NDK_VERSION r16b)
DKSET(NDK_VERSION r17c)
##DKSET(NDK_VERSION r21e)
##DKSET(NDK_VERSION r22b)


### INSTALL ###
if(CMAKE_HOST_WIN32)
	## https://dl.google.com/android/repository/android-ndk-r21e-windows-x86_64.zip
	DKINSTALL(https://dl.google.com/android/repository/android-ndk-${NDK_VERSION}-windows-x86_64.zip android-ndk android-ndk-${NDK_VERSION}-windows-x86_64)
	DKSET(NDK ${3RDPARTY}/android-ndk-${NDK_VERSION}-windows-x86_64)
endif()

if(CMAKE_HOST_APPLE)
	## https://dl.google.com/android/repository/android-ndk-r21e-darwin-x86_64.dmg
	DKINSTALL(https://dl.google.com/android/repository/android-ndk-${NDK_VERSION}-darwin-x86_64.zip android-ndk android-ndk-${NDK_VERSION}-darwin-x86_64)
	DKSET(NDK ${3RDPARTY}/android-ndk-${NDK_VERSION}-darwin-x86_64)
endif()

if(CMAKE_HOST_LINUX)
	## https://dl.google.com/android/repository/android-ndk-r21e-linux-x86_64.zip
	DKINSTALL(https://dl.google.com/android/repository/android-ndk-${NDK_VERSION}-linux-x86_64.zip android-ndk android-ndk-${NDK_VERSION}-linux-x86_64)
	DKSET(NDK ${3RDPARTY}/android-ndk-${NDK_VERSION}-linux-x86_64)
endif()
