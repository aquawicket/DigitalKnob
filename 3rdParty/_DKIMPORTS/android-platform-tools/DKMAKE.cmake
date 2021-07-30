if(NOT ANDROID)
	return()
endif()

DKDEPEND(android-sdk)

if(CMAKE_HOST_WIN32)
	DKSET(ANDROIDPLATFORM_TAG windows-x86_64)
endif()
if(CMAKE_HOST_APPLE)
	DKSET(ANDROIDPLATFORM_TAG darwin-x86_64)
endif()
if(CMAKE_HOST_LINUX)
	DKSET(ANDROIDPLATFORM_TAG linux-x86_64)
endif()

### VERSION ###
DKSET(ANDROIDPLATFORM_VERSION 31.0.3)
DKSET(ANDROIDPLATFORM_NAME android-ndk-r21e-windows-x86_64)
DKSET(ANDROIDPLATFORM_FILE android-ndk-r21e-windows-x86_64.zip)
DKSET(ANDROIDPLATFORM_DL https://dl.google.com/android/repository/platform-tools_r31.0.3-windows.zip)
DKSET(ANDROIDPLATFORM_SHA1 ???)
DKSET(ANDROIDPLATFORM ${ANDROIDSDK}/platform-tools/${ANDROIDPLATFORM_BUILD})


### INSTALL ###
if(CMAKE_HOST_WIN32)
	## https://dl.google.com/android/repository/platform-tools_r31.0.3-windows.zip
	DKINSTALL(ANDROIDPLATFORM_DL android-platform-tools android-sdk/platform-tools/${ANDROIDPLATFORM_BUILD})
endif()

if(CMAKE_HOST_APPLE)
	## https://dl.google.com/android/repository/platform-tools_r31.0.3-darwin.zip
	DKINSTALL(ANDROIDPLATFORM_DL android-platform-tools android-sdk/platform-tools/${ANDROIDPLATFORM_BUILD})
endif()

if(CMAKE_HOST_LINUX)
	## https://dl.google.com/android/repository/platform-tools_r31.0.3-linux.zip
	DKINSTALL(ANDROIDPLATFORM_DL android-platform-tools android-sdk/platform-tools/${ANDROIDPLATFORM_BUILD})
endif()
