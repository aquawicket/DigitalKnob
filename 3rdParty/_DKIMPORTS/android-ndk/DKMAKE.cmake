if(NOT CMAKE_HOST_WIN32)
	return()
endif()

# https://dl.google.com/android/repository/android-ndk-r21e-windows-x86_64.zip
# https://dl.google.com/android/repository/android-ndk-r21e-darwin-x86_64.dmg
# https://dl.google.com/android/repository/android-ndk-r21e-linux-x86_64.zip

### VERSION ###
#DKSET(ANDROIDNDK_VERSION r22b)
#DKSET(ANDROIDNDK_NAME android-ndk-${ANDROIDNDK_VERSION})
#DKSET(ANDROIDNDK_BUILD 22.1.7171670)
#WIN_DKSET(ANDROIDNDK_DL https://dl.google.com/android/repository/android-ndk-r22b-windows-x86_64.zip)
#MAC_DKSET(ANDROIDNDK_DL https://dl.google.com/android/repository/android-ndk-r22b-darwin-x86_64.zip)
#LINUX_DKSET(ANDROIDNDK_DL https://dl.google.com/android/repository/android-ndk-r22b-linux-x86_64.zip)

DKSET(ANDROIDNDK_VERSION r23b)
DKSET(ANDROIDNDK_BUILD 23.1.7779620)
WIN_DKSET(ANDROIDNDK_DL https://dl.google.com/android/repository/android-ndk-r23b-windows-x86_64.zip)
MAC_DKSET(ANDROIDNDK_DL https://dl.google.com/android/repository/android-ndk-r23b-darwin-x86_64.zip)
LINUX_DKSET(ANDROIDNDK_DL https://dl.google.com/android/repository/android-ndk-r23b-linux-x86_64.zip)

DKSET(ANDROIDNDK ${3RDPARTY}/${ANDROIDSDK}/ndk/${ANDROIDNDK_BUILD})
DKSETENV("NDK_ROOT" ${ANDROIDNDK})
DKSETENV("VS_NdkRoot" ${ANDROIDNDK})

### INSTALL ###
file(MAKE_DIRECTORY ${ANDROIDSDK}/ndk)
DKINSTALL(${ANDROIDNDK_DL} android-ndk ${ANDROIDNDK})
