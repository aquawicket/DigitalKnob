include_guard()
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
#
# https://dl.google.com/android/repository/android-ndk-r22b-windows-x86_64.zip
# https://dl.google.com/android/repository/android-ndk-r22b-darwin-x86_64.dmg
# https://dl.google.com/android/repository/android-ndk-r22b-linux-x86_64.zip
#
# https://dl.google.com/android/repository/android-ndk-r23b-windows.zip        LTS
# https://dl.google.com/android/repository/android-ndk-r23b-darwin-x86_64.dmg  LTS
# https://dl.google.com/android/repository/android-ndk-r23b-linux-x86_64.zip   LTS

if(NOT WIN_HOST)
	return()
endif()


# r21e LTS
#dk_set(ANDROID-NDK_VERSION r21e)
#dk_set(ANDROID-NDK_BUILD 21.4.7075529)
#WIN_HOST_dk_set(ANDROID-NDK_DL https://dl.google.com/android/repository/android-ndk-r21e-windows-x86_64.zip)
#MAC_HOST_dk_set(ANDROID-NDK_DL https://dl.google.com/android/repository/android-ndk-r21e-darwin-x86_64.dmg)
#LINUX_HOST_dk_set(ANDROID-NDK_DL https://dl.google.com/android/repository/android-ndk-r21e-linux-x86_64.zip)

# r22b
dk_set(ANDROID-NDK_VERSION r22b)
dk_set(ANDROID-NDK_BUILD 22.1.7171670)
WIN_HOST_dk_set(ANDROID-NDK_DL https://dl.google.com/android/repository/android-ndk-r22b-windows-x86_64.zip)
MAC_HOST_dk_set(ANDROID-NDK_DL https://dl.google.com/android/repository/android-ndk-r22b-darwin-x86_64.dmg)
LINUX_HOST_dk_set(ANDROID-NDK_DL https://dl.google.com/android/repository/android-ndk-r22b-linux-x86_64.zip)
#WIN_HOST_dk_import(ANDROID-NDK_DL https://dl.google.com/android/repository/android-ndk-r22b-windows-x86_64.zip)
#MAC_HOST_dk_import(ANDROID-NDK_DL https://dl.google.com/android/repository/android-ndk-r22b-darwin-x86_64.dmg)
#LINUX_HOST_dk_import(ANDROID-NDK_DL https://dl.google.com/android/repository/android-ndk-r22b-linux-x86_64.zip)

# r23b LTS
#dk_set(ANDROID-NDK_VERSION r23b)
#dk_set(ANDROID-NDK_BUILD 23.1.7779620)
#WIN_HOST_dk_set(ANDROID-NDK_DL https://dl.google.com/android/repository/android-ndk-r23b-windows-x86_64.zip)
#MAC_HOST_dk_set(ANDROID-NDK_DL https://dl.google.com/android/repository/android-ndk-r23b-darwin-x86_64.dmg)
#LINUX_HOST_dk_set(ANDROID-NDK_DL https://dl.google.com/android/repository/android-ndk-r23b-linux-x86_64.zip)

dk_set(ANDROID-NDK ${3RDPARTY}/android-sdk/ndk/${ANDROID-NDK_BUILD})


### INSTALL ###
#file(MAKE_DIRECTORY ${3RDPARTY}/android-sdk/ndk)
dk_makeDirectory(${3RDPARTY}/android-sdk/ndk)
dk_install(${ANDROID-NDK_DL} ${ANDROID-NDK} PATCH)

dk_setEnv("NDK_ROOT" ${ANDROID-NDK})
dk_setEnv("VS_NdkRoot" ${ANDROID-NDK})
