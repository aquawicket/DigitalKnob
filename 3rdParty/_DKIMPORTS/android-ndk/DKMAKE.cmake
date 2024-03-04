# https://developer.android.com/ndk
# https://github.com/android/ndk
# https://mirrors.cloud.tencent.com/AndroidSDK/
# https://android.googlesource.com/platform/ndk/+/refs/heads/ndk-release-r21/docs/BuildSystemMaintainers.md
# https://androidsdkoffline.blogspot.com/p/android-ndk-side-by-side-direct-download.html

#if(NOT ANDROID)
#	dk_undepend(android-ndk)
#	dk_return()
#endif()


### DEPEND ###
dk_depend(android-sdk)


### r21e ###
#dk_set(ANDROID_NDK_VERSION 	r21e)
#dk_set(ANDROID_NDK_BUILD 		21.4.7075529)
#dk_set(ANDROID_NDK_WIN_DL 		https://dl.google.com/android/repository/android-ndk-r21e-windows-x86_64.zip)
#dk_set(ANDROID_NDK_MAC_DL 		https://dl.google.com/android/repository/android-ndk-r21e-darwin-x86_64.dmg)
#dk_set(ANDROID_NDK_LINUX_DL 	https://dl.google.com/android/repository/android-ndk-r21e-linux-x86_64.zip)

### r22b ###
#dk_set(ANDROID_NDK_VERSION 	r22b)
#dk_set(ANDROID_NDK_BUILD 		22.1.7171670)
#dk_set(ANDROID_NDK_WIN_DL 		https://dl.google.com/android/repository/android-ndk-r22b-windows-x86_64.zip)
#dk_set(ANDROID_NDK_MAC_DL 		http://mirrors.cloud.tencent.com/AndroidSDK/android-ndk-r22b-darwin-x86_64.zip)
#dk_set(ANDROID_NDK_LINUX_DL 	http://dl.google.com/android/repository/android-ndk-r22b-linux-x86_64.zip)

### r23b ###
#dk_set(ANDROID_NDK_VERSION 	r23b)
#dk_set(ANDROID_NDK_BUILD 		23.1.7779620)
#dk_set(ANDROID_NDK_WIN_DL 		https://dl.google.com/android/repository/android-ndk-r23b-windows.zip)
#dk_set(ANDROID_NDK_MAC_DL 		http://dl.google.com/android/repository/android-ndk-r23b-darwin.zip)
#dk_set(ANDROID_NDK_LINUX_DL 	http://dl.google.com/android/repository/android-ndk-r23b-linux.zip)

### r23c ###
dk_set(ANDROID_NDK_VERSION		r23c)
dk_set(ANDROID_NDK_BUILD 		23.2.8568313)
dk_set(ANDROID_NDK_WIN_DL 		https://dl.google.com/android/repository/android-ndk-r23c-windows.zip)
dk_set(ANDROID_NDK_MAC_DL 		https://dl.google.com/android/repository/android-ndk-r23c-darwin.zip)
dk_set(ANDROID_NDK_LINUX_DL 	https://dl.google.com/android/repository/android-ndk-r23c-linux.zip)
dk_set(ANDROID_NDK_ANDROID_DL 	https://web.archive.org/web/20230512191806/https://github.com/lzhiyong/termux-ndk/releases/download/ndk-r23/android-ndk-r23c-aarch64.zip)

### r24 ###
#dk_set(ANDROID_NDK_VERSION 	r24)
#dk_set(ANDROID_NDK_BUILD 		24.0.8215888)
#dk_set(ANDROID_NDK_WIN_DL 		https://dl.google.com/android/repository/android-ndk-r24-windows.zip)
#dk_set(ANDROID_NDK_MAC_DL 		https://dl.google.com/android/repository/android-ndk-r24-darwin.zip)
#dk_set(ANDROID_NDK_LINUX_DL 	https://dl.google.com/android/repository/android-ndk-r24-linux.zip)

### r25 ###
#dk_set(ANDROID_NDK_VERSION 	r25)
#dk_set(ANDROID_NDK_BUILD 		25.0.8775105)
#dk_set(ANDROID_NDK_WIN_DL 		https://dl.google.com/android/repository/android-ndk-r25-windows.zip)
#dk_set(ANDROID_NDK_MAC_DL 		https://dl.google.com/android/repository/android-ndk-r25-darwin.zip)
#dk_set(ANDROID_NDK_LINUX_DL 	https://dl.google.com/android/repository/android-ndk-r25-linux.zip)






###### INSTALL ######
dk_set(ANDROID_NDK ${ANDROID_SDK}/ndk/${ANDROID_NDK_BUILD})
dk_debug("ANDROID_NDK = ${ANDROID_NDK}")

dk_makeDirectory			(${ANDROID_SDK}/ndk)
WIN_HOST_dk_import			(${ANDROID_NDK_WIN_DL} PATH ${ANDROID_NDK} PATCH)
MAC_HOST_dk_import			(${ANDROID_NDK_MAC_DL} PATH ${ANDROID_NDK} PATCH)
if(ANDROID_HOST OR LINUX_ARM64_HOST)
	dk_import				(${ANDROID_NDK_ANDROID_DL} PATH ${ANDROID_NDK})
else()
	LINUX_HOST_dk_import		(${ANDROID_NDK_LINUX_DL} PATH ${ANDROID_NDK} PATCH)
endif()
dk_setEnv					("NDK_ROOT" ${ANDROID_NDK})
dk_setEnv					("VS_NdkRoot" ${ANDROID_NDK})

if(APPLE_ARM32_HOST)
	dk_set(ANDROID_HOST_TAG darwin-armv7a)
elseif(APPLE_ARM64_HOST)
	dk_set(ANDROID_HOST_TAG darwin-aarch64)
elseif(APPLE_X86_HOST)
	dk_set(ANDROID_HOST_TAG darwin-x86)
elseif(APPLE_X86_64_HOST)
	dk_set(ANDROID_HOST_TAG darwin-x86_64)
elseif(ANDROID_ARM32_HOST)
	dk_set(ANDROID_HOST_TAG linux-armv7a)
elseif(ANDROID_ARM64_HOST)
	dk_set(ANDROID_HOST_TAG linux-aarch64)
elseif(ANDROID_X86_HOST)
	dk_set(ANDROID_HOST_TAG linux-x86)
elseif(ANDROID_X86_64_HOST)
	dk_set(ANDROID_HOST_TAG linux-x86_64)
#elseif(EMSCRIPTEN_HOST)
#	dk_set(ANDROID_HOST_TAG ???)
elseif(IOS_ARM32_HOST)
	dk_set(ANDROID_HOST_TAG darwin-armv7a)
elseif(IOS_ARM64_HOST)
	dk_set(ANDROID_HOST_TAG darwin-aarch64)
elseif(IOS_X86_HOST)
	dk_set(ANDROID_HOST_TAG darwin-x86)
elseif(IOS_X86_64_HOST)
	dk_set(ANDROID_HOST_TAG darwin-x86_64)
#elseif(IOSSIM_X86_HOST)
#	dk_set(ANDROID_HOST_TAG ???)
#elseif(IOSSIM_X86_64_HOST)
#	dk_set(ANDROID_HOST_TAG ???)
elseif(LINUX_ARM32_HOST)
	dk_set(ANDROID_HOST_TAG linux-armv7a)
elseif(LINUX_ARM64_HOST)
	dk_set(ANDROID_HOST_TAG linux-aarch64)
elseif(LINUX_X86_HOST)
	dk_set(ANDROID_HOST_TAG linux-x86)
elseif(LINUX_X86_64_HOST)
	dk_set(ANDROID_HOST_TAG linux-x86_64)
elseif(MAC_ARM32_HOST)
	dk_set(ANDROID_HOST_TAG darwin-armv7a)
elseif(MAC_ARM64_HOST)
	dk_set(ANDROID_HOST_TAG darwin-aarch64)
elseif(MAC_X86_HOST)
	dk_set(ANDROID_HOST_TAG darwin-x86)
elseif(MAC_X86_64_HOST)
	dk_set(ANDROID_HOST_TAG darwin-x86_64)
elseif(RASPBERRY_ARM32_HOST)
	dk_set(ANDROID_HOST_TAG linux-armv7a)
elseif(RASPBERRY_ARM64_HOST)
	dk_set(ANDROID_HOST_TAG linux-aarch64)
elseif(WIN_ARM32_HOST)
	dk_set(ANDROID_HOST_TAG windows-armv7a)
elseif(WIN_ARM64_HOST)
	dk_set(ANDROID_HOST_TAG windows-aarch64)
elseif(WIN_X86_HOST)
	dk_set(ANDROID_HOST_TAG windows-x86)
elseif(WIN_X86_64_HOST)
	dk_set(ANDROID_HOST_TAG windows-x86_64)
else()
	dk_error("could not set ANDROID_HOST_TAG!")
endif()


if(WIN_HOST)
	dk_set(EXE .exe)
endif()

###### ANDROID VARIABLES ######
dk_set(ANDROID_GENERATOR 			"Unix Makefiles")
dk_set(ANDROID_TOOLCHAIN_FILE 		"${ANDROID_NDK}/build/cmake/android.toolchain.cmake")
#dk_set(__ANDROID_MIN_SDK_VERSION__ 31)
dk_set(ANDROID_API 					31)
dk_set(ANDROID_MIN_API 				19)
dk_set(ANDROID_MAKE_PROGRAM 		"${ANDROID_NDK}/prebuilt/${ANDROID_HOST_TAG}/bin/make")
dk_set(ANDROID_C_COMPILER			"${ANDROID_NDK}/toolchains/llvm/prebuilt/${ANDROID_HOST_TAG}/bin/clang${EXE}")
dk_set(ANDROID_CXX_COMPILER			"${ANDROID_NDK}/toolchains/llvm/prebuilt/${ANDROID_HOST_TAG}/bin/clang${EXE}")

dk_debug("ANDROID_GENERATOR = 		${ANDROID_GENERATOR}")
dk_debug("ANDROID_TOOLCHAIN_FILE = 	${ANDROID_TOOLCHAIN_FILE}")
dk_debug("ANDROID_API = 			${ANDROID_API}")
dk_debug("ANDROID_MIN_API = 		${ANDROID_MIN_API}")
dk_debug("ANDROID_MAKE_PROGRAM = 	${ANDROID_MAKE_PROGRAM}")
dk_debug("ANDROID_C_COMPILER = 		${ANDROID_C_COMPILER}")
dk_debug("ANDROID_CXX_COMPILER = 	${ANDROID_CXX_COMPILER}")
