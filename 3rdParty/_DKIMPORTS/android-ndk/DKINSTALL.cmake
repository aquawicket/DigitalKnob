#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################

dk_assertVar	(CURRENT_PLUGIN)
dk_fileVariables	("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")
dk_assertVar	(android-ndk_Build)

dk_validate(android-sdk "dk_depend(android-sdk)")
dk_set			(android-ndk "${android-sdk}/ndk/${android-ndk_Build}")
dk_set			(ANDROID_NDK "${android-ndk}")
#dk_mkdir		("${android-sdk}/ndk")

if(Windows_Host)
	dk_import	(${android-ndk_Windows_Import} 	INSTALL_PATH "${android-ndk}") # PATCH)
	set(exe ".exe")
elseif(Mac_Host)
	dk_import	(${android-ndk_Mac_Import} 		INSTALL_PATH "${android-ndk}") # PATCH)
elseif(Android_Host OR Linux_Arm64_Host)
	dk_import	(${android-ndk_Android_Import} 	INSTALL_PATH "${android-ndk}" NO_HALT) # NO_HALT because file fails to extact under sdcard storage
elseif(Linux_Host)
	dk_import	(${android-ndk_Linux_Import} 	INSTALL_PATH "${android-ndk}") # PATCH)
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

dk_assertVar(Android_Host_Tag)
dk_debug("Android_Host_Tag = ${Android_Host_Tag}")


###### ANDROID_ CMAKE_ VARIABLES ######
dk_set(ANDROID_GENERATOR 			"Unix Makefiles")
dk_debug("ANDROID_GENERATOR = ${ANDROID_GENERATOR}")

#dk_set(ANDROID_GENERATOR_PLATRORM 	"ARM;ARM64;X86;X64") 	# MSVC

dk_set(ANDROID_NDK_ROOT	"${android-ndk}")
dk_assertPath("${ANDROID_NDK_ROOT}")
dk_debug("ANDROID_NDK_ROOT = ${ANDROID_NDK_ROOT}")

dk_set(ANDROID_TOOLCHAIN_FILE "${android-ndk}/build/cmake/android.toolchain.cmake")
dk_assertPath("${ANDROID_TOOLCHAIN_FILE}")
dk_debug("ANDROID_TOOLCHAIN_FILE = ${ANDROID_TOOLCHAIN_FILE}")

#dk_set(ANDROID_MAKE_PROGRAM "${android-ndk}/prebuilt/${Android_Host_Tag}/bin/make${exe}")
dk_set(ANDROID_MAKE_PROGRAM	"${android-ndk}/prebuilt/windows-x86_64/bin/make${exe}")
dk_assertPath("${ANDROID_MAKE_PROGRAM}")
dk_debug("ANDROID_MAKE_PROGRAM = ${ANDROID_MAKE_PROGRAM}")

dk_set(ANDROID_BIN "${android-ndk}/toolchains/llvm/prebuilt/${Android_Host_Tag}/bin")
dk_assertPath("${ANDROID_BIN}")
dk_debug("ANDROID_BIN = ${ANDROID_BIN}")

dk_set(ANDROID_AR "${android-ndk}/toolchains/llvm/prebuilt/${Android_Host_Tag}/bin/llvm-ar${exe}")
dk_assertPath("${ANDROID_AR}")
dk_debug("ANDROID_AR = ${ANDROID_AR}")

dk_set(ANDROID_C_COMPILER "${android-ndk}/toolchains/llvm/prebuilt/${Android_Host_Tag}/bin/clang${exe}")
dk_assertPath("${ANDROID_C_COMPILER}")
dk_debug("ANDROID_C_COMPILER = ${ANDROID_C_COMPILER}")

dk_set(ANDROID_CXX_COMPILER "${android-ndk}/toolchains/llvm/prebuilt/${Android_Host_Tag}/bin/clang++${exe}")
dk_assertPath("${ANDROID_CXX_COMPILER}")
dk_debug("ANDROID_CXX_COMPILER = ${ANDROID_CXX_COMPILER}")

dk_set(ANDROID_INCLUDE "${android-ndk}/toolchains/llvm/prebuilt/${Android_Host_Tag}/sysroot/usr/include")
dk_assertPath("${ANDROID_INCLUDE}")
dk_debug("ANDROID_INCLUDE = ${ANDROID_INCLUDE}")

dk_set(VS_NdkRoot	"${android-ndk}")
dk_set(NDK_ROOT		"${android-ndk}")


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
	dk_setEnv						("ANDROID_NDK" 		"${android-ndk}")
	dk_setEnv						("ANDROID_NDK_ROOT" "${ANDROID_NDK_ROOT}")
	dk_prependEnvPath				("${ANDROID_BIN}")
	dk_prependEnvPath				("${ANDROID_INCLUDE}")
#endif()
