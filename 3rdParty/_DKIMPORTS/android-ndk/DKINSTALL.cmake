#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


###### android-ndk ######
#

dk_depend(android-sdk)

#dk_getFileParams("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")

dk_set(ANDROID_NDK "${ANDROID_SDK}/ndk/${ANDROID_NDK_BUILD}")

dk_mkdir		("${ANDROID_SDK}/ndk")
if(Windows_Host)
	dk_import	(${android_ndk_Windows_Import} 	_PATH_ "${ANDROID_NDK}" VERSION "${android_ndk_Build}" PATCH)
elseif(Mac_Host)
	dk_import	(${android_ndk_Mac_Import} _PATH_ "${ANDROID_NDK}" PATCH)
elseif(Android_Host OR Linux_Arm64_Host)
	dk_import	(${android_ndk_Android_Import} _PATH_ "${ANDROID_NDK}" NO_HALT) # NO_HALT because file fails to extact under sdcard storage
elseif(Linux_Host)
	dk_import	(${android_ndk_Linux_Import} _PATH_ "${ANDROID_NDK}" PATCH)
endif()


###### Android_Host_Tag ######
if(Apple_Arm32_Host)
	dk_set(Android_Host_Tag darwin-armv7a)
elseif(Apple_Arm32_Host)
	dk_set(Android_Host_Tag darwin-aarch64)
elseif(Apple_X86_Host)
	dk_set(Android_Host_Tag darwin-x86)
elseif(Apple_X86_64_Host)
	dk_set(Android_Host_Tag darwin-x86_64)
elseif(Android_Arm32_Host)
	dk_set(Android_Host_Tag linux-armv7a)
elseif(Android_Arm64_Host)
	dk_set(Android_Host_Tag linux-aarch64)
elseif(Android_X86_Host)
	dk_set(Android_Host_Tag linux-x86)
elseif(Android_X86_64_Host)
	dk_set(Android_Host_Tag linux-x86_64)
elseif(Emscripten_X86_Host)
	dk_set(Android_Host_Tag linux-x86)
elseif(Emscripten_X86_64_Host)
	dk_set(Android_Host_Tag linux-x86_64)
elseif(Ios_Arm32_Host)
	dk_set(Android_Host_Tag darwin-armv7a)
elseif(Ios_Arm64_Host)
	dk_set(Android_Host_Tag darwin-aarch64)
elseif(Ios_X86_Host)
	dk_set(Android_Host_Tag darwin-x86)
elseif(Ios_X86_64_Host)
	dk_set(Android_Host_Tag darwin-x86_64)
elseif(Iossim_X86_Host)
	dk_set(Android_Host_Tag darwin-x86)
elseif(Iossim_X86_64_Host)
	dk_set(Android_Host_Tag darwin-x86_64)
elseif(Linux_Arm32_Host)
	dk_set(Android_Host_Tag linux-armv7a)
elseif(Linux_Arm64_Host)
	dk_set(Android_Host_Tag linux-aarch64)
elseif(Linux_X86_Host)
	dk_set(Android_Host_Tag linux-x86)
elseif(Linux_X86_64_Host)
	dk_set(Android_Host_Tag linux-x86_64)
elseif(Mac_Arm32_Host)
	dk_set(Android_Host_Tag darwin-armv7a)
elseif(Mac_Arm64_Host)
	dk_set(Android_Host_Tag darwin-aarch64)
elseif(Mac_X86_Host)
	dk_set(Android_Host_Tag darwin-x86)
elseif(Mac_X86_64_Host)
	dk_set(Android_Host_Tag darwin-x86_64)
elseif(Raspberry_Arm32_Host)
	dk_set(Android_Host_Tag linux-armv7a)
elseif(Raspberry_Arm64_Host)
	dk_set(Android_Host_Tag linux-aarch64)
elseif(Windows_Arm32_Host)
	dk_set(Android_Host_Tag windows-armv7a)
elseif(Windows_Arm64_Host)
	dk_set(Android_Host_Tag windows-aarch64)
elseif(Windows_X86_Host)
	dk_set(Android_Host_Tag windows-x86)
elseif(Windows_X86_64_Host)
	dk_set(Android_Host_Tag windows-x86_64)
else()
	dk_fatal("could not set Android_Host_Tag!")
endif()


###### ANDROID_ CMAKE_ VARIABLES ######
dk_set(ANDROID_GENERATOR 			"Unix Makefiles")
#dk_set(ANDROID_GENERATOR_PLATRORM 	"ARM;ARM64;X86;X64") 	# MSVC
dk_set(ANDROID_NDK_ROOT				"${ANDROID_NDK}")
dk_set(ANDROID_TOOLCHAIN_FILE 		"${ANDROID_NDK}/build/cmake/android.toolchain.cmake")
dk_set(ANDROID_MAKE_PROGRAM 		"${ANDROID_NDK}/prebuilt/${Android_Host_Tag}/bin/make${exe}")
dk_set(ANDROID_BIN					"${ANDROID_NDK}/toolchains/llvm/prebuilt/${Android_Host_Tag}/bin")
dk_set(ANDROID_AR					"${ANDROID_NDK}/toolchains/llvm/prebuilt/${Android_Host_Tag}/bin/llvm-ar${exe}")
dk_set(ANDROID_C_COMPILER			"${ANDROID_NDK}/toolchains/llvm/prebuilt/${Android_Host_Tag}/bin/clang${exe}")
dk_set(ANDROID_CXX_COMPILER			"${ANDROID_NDK}/toolchains/llvm/prebuilt/${Android_Host_Tag}/bin/clang++${exe}")
dk_set(ANDROID_INCLUDE				"${ANDROID_NDK}/toolchains/llvm/prebuilt/${Android_Host_Tag}/sysroot/usr/include")

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


###### Android TARGET ENVIRONMENT VARIABLES ######
#if(Android)
	dk_setEnv						("AR"				"${ANDROID_AR}")
	dk_setEnv						("CC" 				"${ANDROID_C_COMPILER}")
	dk_setEnv						("CXX"				"${ANDROID_CXX_COMPILER}")
	dk_setEnv						("NDK_ROOT" 		"${NDK_ROOT}")
	dk_setEnv						("VS_NdkRoot" 		"${VS_NdkRoot}")
	dk_setEnv						("ANDROID_NDK" 		"${ANDROID_NDK}")
	dk_setEnv						("ANDROID_NDK_ROOT" "${ANDROID_NDK_ROOT}")
	dk_prependEnvPath				("${ANDROID_BIN}")
	dk_prependEnvPath				("${ANDROID_INCLUDE}")
#endif()
