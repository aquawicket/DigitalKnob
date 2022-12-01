# https://developer.android.com/ndk
# https://github.com/android/ndk
# https://mirrors.cloud.tencent.com/AndroidSDK/
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

if(NOT ANDROID)
	dk_undepend(android-ndk)
	return()
endif()


### DEPEND ###
dk_depend(android-sdk)


# r21e LTS
#dk_set(ANDROID-NDK_VERSION r21e)
#dk_set(ANDROID-NDK_BUILD 21.4.7075529)
#dk_set(ANDROID-NDK_WIN_DL https://dl.google.com/android/repository/android-ndk-r21e-windows-x86_64.zip)
#dk_set(ANDROID-NDK_MAC_DL https://dl.google.com/android/repository/android-ndk-r21e-darwin-x86_64.dmg)
#dk_set(ANDROID-NDK_LINUX_DL https://dl.google.com/android/repository/android-ndk-r21e-linux-x86_64.zip)

# r23b LTS
#dk_set(ANDROID-NDK_VERSION r23b)
#dk_set(ANDROID-NDK_BUILD 23.1.7779620)
#dk_set(ANDROID-NDK_WIN_DL https://dl.google.com/android/repository/android-ndk-r23b-windows-x86_64.zip)
#dk_set(ANDROID-NDK_MAC_DL https://dl.google.com/android/repository/android-ndk-r23b-darwin-x86_64.dmg)
#dk_set(ANDROID-NDK_LINUX_DL https://dl.google.com/android/repository/android-ndk-r23b-linux-x86_64.zip)

# r22b
# NOTE: these variables are rquired by DKBuild.js
dk_set(ANDROID-NDK_VERSION r22b)
dk_set(ANDROID-NDK_BUILD 22.1.7171670)
dk_set(ANDROID-NDK_WIN_DL https://dl.google.com/android/repository/android-ndk-r22b-windows-x86_64.zip)
dk_set(ANDROID-NDK_MAC_DL http://mirrors.cloud.tencent.com/AndroidSDK/android-ndk-r22b-darwin-x86_64.zip) #FIXME https: not working in DKCurl
dk_set(ANDROID-NDK_LINUX_DL http://dl.google.com/android/repository/android-ndk-r22b-linux-x86_64.zip)  #FIXME https: not working in DKCurl

dk_makeDirectory(${ANDROID-SDK}/ndk)
WIN_HOST_dk_import	(${ANDROID-NDK_WIN_DL} PATH ${ANDROID-SDK}/ndk/${ANDROID-NDK_BUILD} PATCH)
MAC_HOST_dk_import	(${ANDROID-NDK_MAC_DL} PATH ${ANDROID-SDK}/ndk/${ANDROID-NDK_BUILD} PATCH)
LINUX_HOST_dk_import(${ANDROID-NDK_LINUX_DL} PATH ${ANDROID-SDK}/ndk/${ANDROID-NDK_BUILD} PATCH)

dk_setEnv("NDK_ROOT" ${ANDROID-NDK})
dk_setEnv("VS_NdkRoot" ${ANDROID-NDK})
