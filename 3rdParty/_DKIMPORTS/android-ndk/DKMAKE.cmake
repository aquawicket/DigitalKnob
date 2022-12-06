# https://developer.android.com/ndk
# https://github.com/android/ndk
# https://mirrors.cloud.tencent.com/AndroidSDK/
# https://android.googlesource.com/platform/ndk/+/refs/heads/ndk-release-r21/docs/BuildSystemMaintainers.md
# https://androidsdkoffline.blogspot.com/p/android-ndk-side-by-side-direct-download.html


if(NOT ANDROID)
	dk_undepend(android-ndk)
	return()
endif()


### DEPEND ###
dk_depend(android-sdk)

# NOTE: these variables are rquired by DKBuild.js

# r21e
#dk_set(ANDROID-NDK_VERSION r21e)
#dk_set(ANDROID-NDK_BUILD 21.4.7075529)
#dk_set(ANDROID-NDK_WIN_DL https://dl.google.com/android/repository/android-ndk-r21e-windows-x86_64.zip)
#dk_set(ANDROID-NDK_MAC_DL https://dl.google.com/android/repository/android-ndk-r21e-darwin-x86_64.dmg)
#dk_set(ANDROID-NDK_LINUX_DL https://dl.google.com/android/repository/android-ndk-r21e-linux-x86_64.zip)

# r22b
dk_set(ANDROID-NDK_VERSION r22b)
dk_set(ANDROID-NDK_BUILD 22.1.7171670)
dk_set(ANDROID-NDK_WIN_DL https://dl.google.com/android/repository/android-ndk-r22b-windows-x86_64.zip)
dk_set(ANDROID-NDK_MAC_DL http://mirrors.cloud.tencent.com/AndroidSDK/android-ndk-r22b-darwin-x86_64.zip) #FIXME https: not working in DKCurl
dk_set(ANDROID-NDK_LINUX_DL http://dl.google.com/android/repository/android-ndk-r22b-linux-x86_64.zip)  #FIXME https: not working in DKCurl

# r23b
#dk_set(ANDROID-NDK_VERSION r23b)
#dk_set(ANDROID-NDK_BUILD 23.1.7779620)
#dk_set(ANDROID-NDK_WIN_DL https://dl.google.com/android/repository/android-ndk-r23b-windows.zip)
#dk_set(ANDROID-NDK_MAC_DL https://dl.google.com/android/repository/android-ndk-r23b-darwin.zip)
#dk_set(ANDROID-NDK_LINUX_DL https://dl.google.com/android/repository/android-ndk-r23b-linux.zip)

# r23c
#dk_set(ANDROID-NDK_VERSION r23c)
#dk_set(ANDROID-NDK_BUILD 23.2.8568313)
#dk_set(ANDROID-NDK_WIN_DL https://dl.google.com/android/repository/android-ndk-r23c-windows.zip)
#dk_set(ANDROID-NDK_MAC_DL https://dl.google.com/android/repository/android-ndk-r23c-darwin.zip)
#dk_set(ANDROID-NDK_LINUX_DL https://dl.google.com/android/repository/android-ndk-r23c-linux.zip)

# r24
#dk_set(ANDROID-NDK_VERSION r24)
#dk_set(ANDROID-NDK_BUILD 24.0.8215888)
#dk_set(ANDROID-NDK_WIN_DL https://dl.google.com/android/repository/android-ndk-r24-windows.zip)
#dk_set(ANDROID-NDK_MAC_DL https://dl.google.com/android/repository/android-ndk-r24-darwin.zip)
#dk_set(ANDROID-NDK_LINUX_DL https://dl.google.com/android/repository/android-ndk-r24-linux.zip)

# r25
#dk_set(ANDROID-NDK_VERSION r25)
#dk_set(ANDROID-NDK_BUILD 25.0.8775105)
#dk_set(ANDROID-NDK_WIN_DL https://dl.google.com/android/repository/android-ndk-r25-windows.zip)
#dk_set(ANDROID-NDK_MAC_DL https://dl.google.com/android/repository/android-ndk-r25-darwin.zip)
#dk_set(ANDROID-NDK_LINUX_DL https://dl.google.com/android/repository/android-ndk-r25-linux.zip)


dk_makeDirectory(${ANDROID-SDK}/ndk)
WIN_HOST_dk_import	(${ANDROID-NDK_WIN_DL} PATH ${ANDROID-SDK}/ndk/${ANDROID-NDK_BUILD} PATCH)
MAC_HOST_dk_import	(${ANDROID-NDK_MAC_DL} PATH ${ANDROID-SDK}/ndk/${ANDROID-NDK_BUILD} PATCH)
LINUX_HOST_dk_import(${ANDROID-NDK_LINUX_DL} PATH ${ANDROID-SDK}/ndk/${ANDROID-NDK_BUILD} PATCH)

dk_setEnv("NDK_ROOT" ${ANDROID-NDK})
dk_setEnv("VS_NdkRoot" ${ANDROID-NDK})
