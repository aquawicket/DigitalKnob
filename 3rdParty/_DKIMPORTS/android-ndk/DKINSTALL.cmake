#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


###### android-ndk ######
# https://developer.android.com/ndk
# https://github.com/android/ndk
# https://mirrors.cloud.tencent.com/AndroidSDK/
# https://android.googlesource.com/platform/ndk/+/refs/heads/ndk-release-r21/docs/BuildSystemMaintainers.md
# https://androidsdkoffline.blogspot.com/p/android-ndk-side-by-side-direct-download.html
# https://github.com/jzinferno2/termux-ndk/releases

### r17c ###
#dk_set(ANDROID_NDK_ANDROID_IMPORT  https://github.com/jzinferno2/termux-ndk/releases/download/v1/android-ndk-r17c-aarch64.zip)

### r18b ###
#dk_set(ANDROID_NDK_ANDROID_IMPORT  https://github.com/jzinferno2/termux-ndk/releases/download/v1/android-ndk-r18b-aarch64.zip)

### r19c ###
#dk_set(ANDROID_NDK_ANDROID_IMPORT  https://github.com/jzinferno2/termux-ndk/releases/download/v1/android-ndk-r19c-aarch64.zip)

### r20b ###
#dk_set(ANDROID_NDK_ANDROID_IMPORT  https://github.com/jzinferno2/termux-ndk/releases/download/v1/android-ndk-r20b-aarch64.zip)

### r21e ###
#dk_set(ANDROID_NDK_VERSION 	r21e)
#dk_set(ANDROID_NDK_BUILD 		21.4.7075529)
#dk_set(ANDROID_NDK_WIN_IMPORT 		https://dl.google.com/android/repository/android-ndk-r21e-windows-x86_64.zip)
#dk_set(ANDROID_NDK_MAC_IMPORT 		https://dl.google.com/android/repository/android-ndk-r21e-darwin-x86_64.dmg)
#dk_set(ANDROID_NDK_LINUX_IMPORT 	https://dl.google.com/android/repository/android-ndk-r21e-linux-x86_64.zip)
#dk_set(ANDROID_NDK_ANDROID_IMPORT	https://github.com/jzinferno2/termux-ndk/releases/download/v1/android-ndk-r21e-aarch64.zip)

### r22b ###
#dk_set(ANDROID_NDK_VERSION 	r22b)
#dk_set(ANDROID_NDK_BUILD 		22.1.7171670)
#dk_set(ANDROID_NDK_WIN_IMPORT 		https://dl.google.com/android/repository/android-ndk-r22b-windows-x86_64.zip)
#dk_set(ANDROID_NDK_MAC_IMPORT 		http://mirrors.cloud.tencent.com/AndroidSDK/android-ndk-r22b-darwin-x86_64.zip)
#dk_set(ANDROID_NDK_LINUX_IMPORT 	http://dl.google.com/android/repository/android-ndk-r22b-linux-x86_64.zip)
#dk_set(ANDROID_NDK_ANDROID_IMPORT  https://github.com/jzinferno2/termux-ndk/releases/download/v1/android-ndk-r22b-aarch64.zip)

### r23b ###
#dk_set(ANDROID_NDK_VERSION 	r23b)
#dk_set(ANDROID_NDK_BUILD 		23.1.7779620)
#dk_set(ANDROID_NDK_WIN_IMPORT 		https://dl.google.com/android/repository/android-ndk-r23b-windows.zip)
#dk_set(ANDROID_NDK_MAC_IMPORT 		http://dl.google.com/android/repository/android-ndk-r23b-darwin.zip)
#dk_set(ANDROID_NDK_LINUX_IMPORT 	http://dl.google.com/android/repository/android-ndk-r23b-linux.zip)
#dk_set(ANDROID_NDK_ANDROID_IMPORT  https://github.com/jzinferno2/termux-ndk/releases/download/v1/android-ndk-r23b-aarch64.zip)

### r23c ###
#dk_set(ANDROID_NDK_VERSION		r23c)
#dk_set(ANDROID_NDK_BUILD 		"23.2.8568313")
#dk_set(ANDROID_NDK_WIN_IMPORT 		https://dl.google.com/android/repository/android-ndk-r23c-windows.zip)
#dk_set(ANDROID_NDK_MAC_IMPORT 		https://dl.google.com/android/repository/android-ndk-r23c-darwin.zip)
#dk_set(ANDROID_NDK_LINUX_IMPORT 	https://dl.google.com/android/repository/android-ndk-r23c-linux.zip)
#dk_set(ANDROID_NDK_ANDROID_IMPORT 	https://web.archive.org/web/20230512191806/https://github.com/lzhiyong/termux-ndk/releases/download/ndk-r23/android-ndk-r23c-aarch64.zip)

### r24 ###
#dk_set(ANDROID_NDK_VERSION 	r24)
#dk_set(ANDROID_NDK_BUILD 		24.0.8215888)
#dk_set(ANDROID_NDK_WIN_IMPORT 		https://dl.google.com/android/repository/android-ndk-r24-windows.zip)
#dk_set(ANDROID_NDK_MAC_IMPORT 		https://dl.google.com/android/repository/android-ndk-r24-darwin.zip)
#dk_set(ANDROID_NDK_LINUX_IMPORT 	https://dl.google.com/android/repository/android-ndk-r24-linux.zip)
#dk_set(ANDROID_NDK_LINUX_IMPORT 	https://github.com/jzinferno2/termux-ndk/releases/download/v1/android-ndk-r24-aarch64.zip)

### r25 ###
#dk_set(ANDROID_NDK_VERSION 	r25)
#dk_set(ANDROID_NDK_BUILD 		25.0.8775105)
#dk_set(ANDROID_NDK_WIN_IMPORT 		https://dl.google.com/android/repository/android-ndk-r25-windows.zip)
#dk_set(ANDROID_NDK_MAC_IMPORT 		https://dl.google.com/android/repository/android-ndk-r25-darwin.zip)
#dk_set(ANDROID_NDK_LINUX_IMPORT 	https://dl.google.com/android/repository/android-ndk-r25-linux.zip)

### DEPEND ###
dk_depend(android-sdk)

dk_validate(ENV{DKIMPORTS_DIR} "dk_DKIMPORTS_DIR()")
dk_getFileParams("$ENV{DKIMPORTS_DIR}/android-ndk/dkconfig.txt")

###### INSTALL ######

###### ANDROID_NDK ######
dk_set(ANDROID_NDK "${ANDROID_SDK_DIR}/ndk/${ANDROID_NDK_BUILD}")

dk_mkdir	("${ANDROID_SDK_DIR}/ndk")
if(Windows_Host)
	dk_import		(${ANDROID_NDK_WIN_IMPORT} 		PATH "${ANDROID_NDK}" VERSION "${ANDROID_NDK_BUILD}" PATCH)
elseif(Mac_Host)
	dk_import		(${ANDROID_NDK_MAC_IMPORT} 		PATH "${ANDROID_NDK}" PATCH)
elseif(Android_Host OR Linux_Arm64_Host)
	dk_import		(${ANDROID_NDK_ANDROID_IMPORT} 	PATH "${ANDROID_NDK}" NO_HALT) # NO_HALT because file fails to extact under sdcard storage
elseif(Linux_Arm64_Host)
	dk_import		(${ANDROID_NDK_ANDROID_IMPORT} 	PATH "${ANDROID_NDK}")
elseif(Linux_Host)
	dk_import		(${ANDROID_NDK_LINUX_IMPORT} 	PATH "${ANDROID_NDK}" PATCH)
endif()


###### ANDROID_HOST_TAG ######
if(Apple_Arm32_Host)
	dk_set(ANDROID_HOST_TAG darwin-armv7a)
elseif(Apple_Arm32_Host)
	dk_set(ANDROID_HOST_TAG darwin-aarch64)
elseif(Apple_X86_Host)
	dk_set(ANDROID_HOST_TAG darwin-x86)
elseif(Apple_X86_64_Host)
	dk_set(ANDROID_HOST_TAG darwin-x86_64)
elseif(Android_Arm32_Host)
	dk_set(ANDROID_HOST_TAG linux-armv7a)
elseif(Android_Arm64_Host)
	dk_set(ANDROID_HOST_TAG linux-aarch64)
elseif(Android_X86_Host)
	dk_set(ANDROID_HOST_TAG linux-x86)
elseif(Android_X86_64_Host)
	dk_set(ANDROID_HOST_TAG linux-x86_64)
elseif(Emscripten_X86_Host)
	dk_set(ANDROID_HOST_TAG linux-x86)
elseif(Emscripten_X86_64_Host)
	dk_set(ANDROID_HOST_TAG linux-x86_64)
elseif(Ios_Arm32_Host)
	dk_set(ANDROID_HOST_TAG darwin-armv7a)
elseif(Ios_Arm64_Host)
	dk_set(ANDROID_HOST_TAG darwin-aarch64)
elseif(Ios_X86_Host)
	dk_set(ANDROID_HOST_TAG darwin-x86)
elseif(Ios_X86_64_Host)
	dk_set(ANDROID_HOST_TAG darwin-x86_64)
elseif(Iossim_X86_Host)
	dk_set(ANDROID_HOST_TAG darwin-x86)
elseif(Iossim_X86_64_Host)
	dk_set(ANDROID_HOST_TAG darwin-x86_64)
elseif(Linux_Arm32_Host)
	dk_set(ANDROID_HOST_TAG linux-armv7a)
elseif(Linux_Arm64_Host)
	dk_set(ANDROID_HOST_TAG linux-aarch64)
elseif(Linux_X86_Host)
	dk_set(ANDROID_HOST_TAG linux-x86)
elseif(Linux_X86_64_Host)
	dk_set(ANDROID_HOST_TAG linux-x86_64)
elseif(Mac_Arm32_Host)
	dk_set(ANDROID_HOST_TAG darwin-armv7a)
elseif(Mac_Arm64_Host)
	dk_set(ANDROID_HOST_TAG darwin-aarch64)
elseif(Mac_X86_Host)
	dk_set(ANDROID_HOST_TAG darwin-x86)
elseif(Mac_X86_64_Host)
	dk_set(ANDROID_HOST_TAG darwin-x86_64)
elseif(Raspberry_Arm32_Host)
	dk_set(ANDROID_HOST_TAG linux-armv7a)
elseif(Raspberry_Arm64_Host)
	dk_set(ANDROID_HOST_TAG linux-aarch64)
elseif(Windows_Arm32_Host)
	dk_set(ANDROID_HOST_TAG windows-armv7a)
elseif(Windows_Arm64_Host)
	dk_set(ANDROID_HOST_TAG windows-aarch64)
elseif(Windows_X86_Host)
	dk_set(ANDROID_HOST_TAG windows-x86)
elseif(Windows_X86_64_Host)
	dk_set(ANDROID_HOST_TAG windows-x86_64)
else()
	dk_fatal("could not set ANDROID_HOST_TAG!")
endif()


###### ANDROID_ CMAKE_ VARIABLES ######
dk_set(ANDROID_GENERATOR 			"Unix Makefiles")
#dk_set(ANDROID_GENERATOR_PLATRORM 	"ARM;ARM64;X86;X64") 	# MSVC
dk_set(ANDROID_NDK_ROOT				"${ANDROID_NDK}")
dk_set(ANDROID_TOOLCHAIN_FILE 		"${ANDROID_NDK}/build/cmake/android.toolchain.cmake")
dk_set(ANDROID_MAKE_PROGRAM 		"${ANDROID_NDK}/prebuilt/${ANDROID_HOST_TAG}/bin/make${exe}")
dk_set(ANDROID_BIN					"${ANDROID_NDK}/toolchains/llvm/prebuilt/${ANDROID_HOST_TAG}/bin")
dk_set(ANDROID_AR					"${ANDROID_NDK}/toolchains/llvm/prebuilt/${ANDROID_HOST_TAG}/bin/llvm-ar${exe}")
dk_set(ANDROID_C_COMPILER			"${ANDROID_NDK}/toolchains/llvm/prebuilt/${ANDROID_HOST_TAG}/bin/clang${exe}")
dk_set(ANDROID_CXX_COMPILER			"${ANDROID_NDK}/toolchains/llvm/prebuilt/${ANDROID_HOST_TAG}/bin/clang++${exe}")
dk_set(ANDROID_INCLUDE				"${ANDROID_NDK}/toolchains/llvm/prebuilt/${ANDROID_HOST_TAG}/sysroot/usr/include")

dk_set(VS_NdkRoot					"${ANDROID_NDK}")
dk_set(NDK_ROOT						"${ANDROID_NDK}")


###### ANDROID_ABI ######			# https://developer.android.com/ndk/guides/abis
#dk_set(ANDROID_ABI					arm64-v8a)
#dk_set(ANDROID_ABI					armeabi)
#dk_set(ANDROID_ABI					armeabi-v7a)
#dk_set(ANDROID_ABI					mips)
#dk_set(ANDROID_ABI					mips64)
#dk_set(ANDROID_ABI					x86)
#dk_set(ANDROID_ABI					x86_64)


###### ANDROID_API ######			# https://developer.android.com/reference
dk_set(ANDROID_MIN_API 				19)
dk_set(ANDROID_API 					31)
dk_set(ANDROID_NATIVE_API_LEVEL		31)
dk_set(ANDROID_PLATFORM				31)
#dk_set(__ANDROID_MIN_SDK_VERSION__ 31)
dk_set(ANDROID_BASH					"export ANDROID_NDK_ROOT=${ANDROID_NDK_ROOT};"
									"export PATH=${ANDROID_BIN}:$PATH;"
									"export PATH=${ANDROID_INCLUDE}:$PATH;")


###### ANDROID TARGET ENVIRONMENT VARIABLES ######
if(ANDROID)
	dk_setEnv						("AR"				"${ANDROID_AR}")
	dk_setEnv						("CC" 				"${ANDROID_C_COMPILER}")
	dk_setEnv						("CXX"				"${ANDROID_CXX_COMPILER}")
	dk_setEnv						("NDK_ROOT" 		"${NDK_ROOT}")
	dk_setEnv						("VS_NdkRoot" 		"${VS_NdkRoot}")
	dk_setEnv						("ANDROID_NDK" 		"${ANDROID_NDK}")
	dk_setEnv						("ANDROID_NDK_ROOT" "${ANDROID_NDK_ROOT}")
	dk_prependEnvPath				("${ANDROID_BIN}")
	dk_prependEnvPath				("${ANDROID_INCLUDE}")
endif()
