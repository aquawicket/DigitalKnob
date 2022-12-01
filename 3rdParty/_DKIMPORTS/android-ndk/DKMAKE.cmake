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

dk_depend(android-sdk)

# r21e LTS
#WIN_HOST_dk_import		(https://dl.google.com/android/repository/android-ndk-r21e-windows-x86_64.zip ${ANDROID-SDK}/ndk/21.4.7075529 PATCH)
#MAC_HOST_dk_import		(https://dl.google.com/android/repository/android-ndk-r21e-darwin-x86_64.dmg ${ANDROID-SDK}/ndk/21.4.7075529 PATCH)
#LINUX_HOST_dk_import	(https://dl.google.com/android/repository/android-ndk-r21e-linux-x86_64.zip ${ANDROID-SDK}/ndk/21.4.7075529 PATCH)

# r22b
dk_set(ANDROID-NDK_VERSION r22b)
dk_set(ANDROID-NDK_BUILD 22.1.7171670)
#dk_set(ANDROID-NDK_DL https://dl.google.com/android/repository/android-ndk-r22b-windows-x86_64.zip)
dk_makeDirectory(${ANDROID-SDK}/ndk)
WIN_HOST_dk_import	(https://dl.google.com/android/repository/android-ndk-r22b-windows-x86_64.zip PATH ${ANDROID-SDK}/ndk/22.1.7171670 PATCH)
#MAC_HOST_dk_import	(https://dl.google.com/android/repository/android-ndk-r22b-darwin-x86_64.dmg PATH ${ANDROID-SDK}/ndk/22.1.7171670 PATCH)
MAC_HOST_dk_import	(https://mirrors.cloud.tencent.com/AndroidSDK/android-ndk-r22b-darwin-x86_64.zip PATH ${ANDROID-SDK}/ndk/22.1.7171670 PATCH)
LINUX_HOST_dk_import(https://dl.google.com/android/repository/android-ndk-r22b-linux-x86_64.zip PATH ${ANDROID-SDK}/ndk/22.1.7171670 PATCH)

# r23b LTS
#WIN_HOST_dk_import		(https://dl.google.com/android/repository/android-ndk-r23b-windows-x86_64.zip ${ANDROID-SDK}/ndk/23.1.7779620 PATCH)
#MAC_HOST_dk_import		(https://dl.google.com/android/repository/android-ndk-r23b-darwin-x86_64.dmg ${ANDROID-SDK}/ndk/23.1.7779620 PATCH)
#LINUX_HOST_dk_import	(https://dl.google.com/android/repository/android-ndk-r23b-linux-x86_64.zip ${ANDROID-SDK}/ndk/23.1.7779620 PATCH)


dk_setEnv("NDK_ROOT" ${ANDROID-NDK})
dk_setEnv("VS_NdkRoot" ${ANDROID-NDK})
