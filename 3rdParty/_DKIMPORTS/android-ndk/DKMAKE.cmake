if(NOT CMAKE_HOST_WIN32)
	return()
endif()

# https://androidsdkoffline.blogspot.com/p/android-ndk-side-by-side-direct-download.html
# https://dl.google.com/android/repository/android-ndk-r21e-windows-x86_64.zip LTS
# https://dl.google.com/android/repository/android-ndk-r21e-darwin-x86_64.dmg LTS
# https://dl.google.com/android/repository/android-ndk-r21e-linux-x86_64.zip LTS

### VERSION ###
DKSET(ANDROIDNDK_VERSION r21e)
DKSET(ANDROIDNDK_BUILD 21.4.7075529)
WIN_HOST_SET(ANDROIDNDK_DL https://dl.google.com/android/repository/android-ndk-r21e-windows-x86_64.zip)
MAC_HOST_SET(ANDROIDNDK_DL https://dl.google.com/android/repository/android-ndk-r21e-darwin-x86_64.zip)
LINUX_HOST_SET(ANDROIDNDK_DL https://dl.google.com/android/repository/android-ndk-r21e-linux-x86_64.zip)

#DKSET(ANDROIDNDK_VERSION r22b)
#DKSET(ANDROIDNDK_BUILD 22.1.7171670)
#WIN_SET(ANDROIDNDK_DL https://dl.google.com/android/repository/android-ndk-r22b-windows-x86_64.zip)
#MAC_SET(ANDROIDNDK_DL https://dl.google.com/android/repository/android-ndk-r22b-darwin-x86_64.zip)
#LINUX_SET(ANDROIDNDK_DL https://dl.google.com/android/repository/android-ndk-r22b-linux-x86_64.zip)

#DKSET(ANDROIDNDK_VERSION r23b)
#DKSET(ANDROIDNDK_BUILD 23.1.7779620)
#WIN_SET(ANDROIDNDK_DL https://dl.google.com/android/repository/android-ndk-r23b-windows-x86_64.zip)
#MAC_SET(ANDROIDNDK_DL https://dl.google.com/android/repository/android-ndk-r23b-darwin-x86_64.zip)
#LINUX_SET(ANDROIDNDK_DL https://dl.google.com/android/repository/android-ndk-r23b-linux-x86_64.zip)

DKSET(ANDROIDNDK ${3RDPARTY}/android-sdk/ndk/${ANDROIDNDK_BUILD})
DKSETENV("NDK_ROOT" ${ANDROIDNDK})
DKSETENV("VS_NdkRoot" ${ANDROIDNDK})

### INSTALL ###
file(MAKE_DIRECTORY ${3RDPARTY}/android-sdk/ndk)
DKINSTALL(${ANDROIDNDK_DL} android-ndk ${ANDROIDNDK})
