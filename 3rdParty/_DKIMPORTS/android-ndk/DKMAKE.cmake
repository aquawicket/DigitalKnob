# https://developer.android.com/ndk
# https://github.com/android/ndk
#
# Docs
# https://android.googlesource.com/platform/ndk/+/refs/heads/ndk-release-r21/docs/BuildSystemMaintainers.md
# https://androidsdkoffline.blogspot.com/p/android-ndk-side-by-side-direct-download.html
#
# Downloads
# https://dl.google.com/android/repository/android-ndk-r21e-windows-x86_64.zip LTS
# https://dl.google.com/android/repository/android-ndk-r21e-darwin-x86_64.dmg  LTS
# https://dl.google.com/android/repository/android-ndk-r21e-linux-x86_64.zip   LTS
# https://dl.google.com/android/repository/android-ndk-r22b-windows-x86_64.zip
# https://dl.google.com/android/repository/android-ndk-r22b-darwin-x86_64.dmg
# https://dl.google.com/android/repository/android-ndk-r22b-linux-x86_64.zip
# https://dl.google.com/android/repository/android-ndk-r23b-windows.zip        LTS
# https://dl.google.com/android/repository/android-ndk-r23b-darwin-x86_64.dmg  LTS
# https://dl.google.com/android/repository/android-ndk-r23b-linux-x86_64.zip   LTS

if(NOT WIN_HOST)
	return()
endif()

### VERSION ###
# r21e LTS
DKSET(ANDROIDNDK_VERSION r21e)
DKSET(ANDROIDNDK_BUILD 21.4.7075529)
WIN_HOST_DKSET(ANDROIDNDK_DL https://dl.google.com/android/repository/android-ndk-r21e-windows-x86_64.zip)
MAC_HOST_DKSET(ANDROIDNDK_DL https://dl.google.com/android/repository/android-ndk-r21e-darwin-x86_64.dmg)
LINUX_HOST_DKSET(ANDROIDNDK_DL https://dl.google.com/android/repository/android-ndk-r21e-linux-x86_64.zip)

# r23b
#DKSET(ANDROIDNDK_VERSION r22b)
#DKSET(ANDROIDNDK_BUILD 22.1.7171670)
#WIN_HOST_DKSET(ANDROIDNDK_DL https://dl.google.com/android/repository/android-ndk-r22b-windows-x86_64.zip)
#MAC_HOST_DKSET(ANDROIDNDK_DL https://dl.google.com/android/repository/android-ndk-r22b-darwin-x86_64.dmg)
#LINUX_HOST_DKSET(ANDROIDNDK_DL https://dl.google.com/android/repository/android-ndk-r22b-linux-x86_64.zip)

# r23b LTS
#DKSET(ANDROIDNDK_VERSION r23b)
#DKSET(ANDROIDNDK_BUILD 23.1.7779620)
#WIN_HOST_DKSET(ANDROIDNDK_DL https://dl.google.com/android/repository/android-ndk-r23b-windows-x86_64.zip)
#MAC_HOST_DKSET(ANDROIDNDK_DL https://dl.google.com/android/repository/android-ndk-r23b-darwin-x86_64.dmg)
#LINUX_HOST_DKSET(ANDROIDNDK_DL https://dl.google.com/android/repository/android-ndk-r23b-linux-x86_64.zip)

DKSET(ANDROIDNDK ${3RDPARTY}/android-sdk/ndk/${ANDROIDNDK_BUILD})


### INSTALL ###
file(MAKE_DIRECTORY ${3RDPARTY}/android-sdk/ndk)
DKINSTALL(${ANDROIDNDK_DL} android-ndk ${ANDROIDNDK})

DKSETENV("NDK_ROOT" ${ANDROIDNDK})
DKSETENV("VS_NdkRoot" ${ANDROIDNDK})