# This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
#
# For the latest information, see https://github.com/aquawicket/DigitalKnob
#
# Copyright(c) 2010 - 2023 Digitalknob Team, and contributors
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files(the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions :
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
include_guard()
message(STATUS "****** LOADING: ${CMAKE_CURRENT_LIST_FILE} ******")


### Get CMAKE_SOURCE_DIR ###
if(NOT CMAKE_SOURCE_DIR)
	message(FATAL_ERROR "CMAKE_SOURCE_DIR invalid!")
endif()
get_filename_component(CMAKE_SOURCE_DIR ${CMAKE_SOURCE_DIR} ABSOLUTE)
message(STATUS "CMAKE_SOURCE_DIR = ${CMAKE_SOURCE_DIR}")


### Get CMAKE_BINARY_DIR ###
if(NOT CMAKE_BINARY_DIR)
	message(FATAL_ERROR "CMAKE_BINARY_DIR invalid!")
endif()
get_filename_component(CMAKE_BINARY_DIR ${CMAKE_BINARY_DIR} ABSOLUTE)
message(STATUS "CMAKE_BINARY_DIR = ${CMAKE_BINARY_DIR}")


### Set DKCMAKE_DIR ###
set(DKCMAKE_DIR ${CMAKE_SOURCE_DIR} CACHE INTERNAL "" FORCE)
message(STATUS "DKCMAKE_DIR = ${DKCMAKE_DIR}")

### Set DKBRANCH_DIR
string(FIND "${DKCMAKE_DIR}" "DKCMake" pos)
math(EXPR pos "${pos}-1")
string(SUBSTRING ${DKCMAKE_DIR} 0 ${pos} DKBRANCH_DIR)
set(DKBRANCH_DIR ${DKBRANCH_DIR} CACHE INTERNAL "" FORCE)
message(STATUS "DKBRANCH_DIR = ${DKBRANCH_DIR}")

### Set DIGITALKNOB_DIR
string(FIND "${DKBRANCH_DIR}" "digitalknob" pos)
string(SUBSTRING ${DKBRANCH_DIR} 0 ${pos} DIGITALKNOB_DIR)
set(DIGITALKNOB_DIR ${DIGITALKNOB_DIR}digitalknob CACHE INTERNAL "" FORCE)
message(STATUS "DIGITALKNOB_DIR = ${DIGITALKNOB_DIR}")

### Set DK3RDPARTY_DIR
set(DK3RDPARTY_DIR ${DKBRANCH_DIR}/3rdParty CACHE INTERNAL "" FORCE)

### Set DK_BINARY_DIR ###
set(DK_BINARY_DIR ${CMAKE_BINARY_DIR} CACHE INTERNAL "" FORCE)
message(STATUS "DK_BINARY_DIR = ${DK_BINARY_DIR}")

### Set DK_BINARY_OSARCH_DIR ###
if(${CMAKE_BINARY_DIR} MATCHES "Debug$")
	get_filename_component(DK_BINARY_OSARCH_DIR ${CMAKE_BINARY_DIR} DIRECTORY)
elseif(${CMAKE_BINARY_DIR} MATCHES "Release$")
	get_filename_component(DK_BINARY_OSARCH_DIR ${CMAKE_BINARY_DIR} DIRECTORY)
else()
	set(DK_BINARY_OSARCH_DIR ${DK_BINARY_DIR} CACHE INTERNAL "" FORCE)
endif()
message(STATUS "DK_BINARY_OSARCH_DIR = ${DK_BINARY_OSARCH_DIR}")
	
### Set DK_BINARY_OSARCH ###
get_filename_component(DK_BINARY_OSARCH ${DK_BINARY_OSARCH_DIR} NAME)     
message(STATUS "DK_BINARY_OSARCH = ${DK_BINARY_OSARCH}")

### Set DK_BINARY_OS ###
string(FIND "${DK_BINARY_OSARCH}" "_" first_underscore)
string(SUBSTRING "${DK_BINARY_OSARCH}" 0 ${first_underscore} DK_BINARY_OS)
message(STATUS "DK_BINARY_OS = ${DK_BINARY_OS}")
	
## Set DK_BINARY_ARCH ###
string(FIND "${DK_BINARY_OSARCH}" "_" first_underscore)
math(EXPR after_underscore "${first_underscore}+1" OUTPUT_FORMAT DECIMAL)
string(SUBSTRING "${DK_BINARY_OSARCH}" ${after_underscore} -1 DK_BINARY_ARCH)
message(STATUS "DK_BINARY_ARCH = ${DK_BINARY_ARCH}")

### Set DK_PROJECT_DIR ###
get_filename_component(DK_PROJECT_DIR ${DK_BINARY_OSARCH_DIR} DIRECTORY)
message(STATUS "DK_PROJECT_DIR = ${DK_PROJECT_DIR}")
	
	
	
# android_arm32
if(${DK_BINARY_OSARCH} MATCHES "android_arm32")
	set(ANDROID_NDK 					"${DK3RDPARTY_DIR}/android-sdk/ndk/23.1.7779620" 						CACHE INTERNAL "" FORCE)
	set(ANDROID_NDK_GENERATOR 			"Unix Makefiles" 														CACHE INTERNAL "" FORCE)
	set(ANDROID_NDK_MAKE_PROGRAM 		"${ANDROID_NDK}/prebuilt/windows-x86_64/bin/make.exe" 					CACHE INTERNAL "" FORCE)
	set(ANDROID_NDK_ANDROID_ABI			"armeabi-v7a" 															CACHE INTERNAL "" FORCE)
	set(ANDROID_NDK_ANDROID_PLATFORM 	"31" 																	CACHE INTERNAL "" FORCE)
	set(ANDROID_NDK_TOOLCHAIN_FILE 		"${ANDROID_NDK}/build/cmake/android.toolchain.cmake" 					CACHE INTERNAL "" FORCE)
	set(ANDROID_NDK_ANDROID_TOOLCHAIN 	"clang" 																CACHE INTERNAL "" FORCE)
	set(ANDROID_NDK_ANDROID_STL 		"c++_static" 															CACHE INTERNAL "" FORCE)
	set(ANDROID_NDK_CXX_FLAGS 			"-std=c++1z -frtti -fexceptions" 										CACHE INTERNAL "" FORCE)
	
	
	set(CMAKE_ANDROID_NDK 				"${ANDROID_NDK}" 														CACHE INTERNAL "" FORCE)
	set(CMAKE_GENERATOR 				"${ANDROID_NDK_GENERATOR}" 												CACHE INTERNAL "" FORCE)
	set(CMAKE_MAKE_PROGRAM 				"${ANDROID_NDK_MAKE_PROGRAM}" 											CACHE INTERNAL "" FORCE)
	set(ANDROID_ABI 					"${ANDROID_NDK_ANDROID_ABI}" 											CACHE INTERNAL "" FORCE)
	set(CMAKE_ANDROID_ARCH_ABI 			"${ANDROID_NDK_ANDROID_ABI}" 											CACHE INTERNAL "" FORCE)
	set(ANDROID_PLATFORM 				"${ANDROID_NDK_ANDROID_PLATFORM}" 										CACHE INTERNAL "" FORCE)
	set(CMAKE_TOOLCHAIN_FILE 			"${ANDROID_NDK_TOOLCHAIN_FILE}" 										CACHE INTERNAL "" FORCE)
	set(ANDROID_TOOLCHAIN 				"${ANDROID_NDK_ANDROID_TOOLCHAIN}" 										CACHE INTERNAL "" FORCE)
	set(ANDROID_STL 					"${ANDROID_NDK_ANDROID_STL}" 											CACHE INTERNAL "" FORCE)
	set(CMAKE_ANDROID_STL_TYPE 			"${ANDROID_NDK_ANDROID_STL}" 											CACHE INTERNAL "" FORCE)
	set(CMAKE_CXX_FLAGS 				"${ANDROID_NDK_CXX_FLAGS}" 												CACHE INTERNAL "" FORCE)
endif()

# android_arm64
if(${DK_BINARY_OSARCH} MATCHES "android_arm64")
	set(ANDROID_NDK 					"${DK3RDPARTY_DIR}/android-sdk/ndk/23.1.7779620" 						CACHE INTERNAL "" FORCE)
	set(ANDROID_NDK_GENERATOR 			"Unix Makefiles" 														CACHE INTERNAL "" FORCE)
	set(ANDROID_NDK_MAKE_PROGRAM 		"${ANDROID_NDK}/prebuilt/windows-x86_64/bin/make.exe" 					CACHE INTERNAL "" FORCE)
	set(ANDROID_NDK_ANDROID_ABI			"arm64-v8a" 															CACHE INTERNAL "" FORCE)
	set(ANDROID_NDK_ANDROID_PLATFORM 	"31" 																	CACHE INTERNAL "" FORCE)
	set(ANDROID_NDK_TOOLCHAIN_FILE 		"${ANDROID_NDK}/build/cmake/android.toolchain.cmake" 					CACHE INTERNAL "" FORCE)
	set(ANDROID_NDK_ANDROID_TOOLCHAIN 	"clang" 																CACHE INTERNAL "" FORCE)
	set(ANDROID_NDK_ANDROID_STL 		"c++_static" 															CACHE INTERNAL "" FORCE)
	set(ANDROID_NDK_CXX_FLAGS 			"-std=c++1z -frtti -fexceptions" 										CACHE INTERNAL "" FORCE)
	
	
	set(CMAKE_ANDROID_NDK 				"${ANDROID_NDK}" 														CACHE INTERNAL "" FORCE)
	set(CMAKE_GENERATOR 				"${ANDROID_NDK_GENERATOR}" 												CACHE INTERNAL "" FORCE)
	set(CMAKE_MAKE_PROGRAM 				"${ANDROID_NDK_MAKE_PROGRAM}" 											CACHE INTERNAL "" FORCE)
	set(ANDROID_ABI 					"${ANDROID_NDK_ANDROID_ABI}" 											CACHE INTERNAL "" FORCE)
	set(CMAKE_ANDROID_ARCH_ABI 			"${ANDROID_NDK_ANDROID_ABI}" 											CACHE INTERNAL "" FORCE)
	set(ANDROID_PLATFORM 				"${ANDROID_NDK_ANDROID_PLATFORM}" 										CACHE INTERNAL "" FORCE)
	set(CMAKE_TOOLCHAIN_FILE 			"${ANDROID_NDK_TOOLCHAIN_FILE}" 										CACHE INTERNAL "" FORCE)
	set(ANDROID_TOOLCHAIN 				"${ANDROID_NDK_ANDROID_TOOLCHAIN}" 										CACHE INTERNAL "" FORCE)
	set(ANDROID_STL 					"${ANDROID_NDK_ANDROID_STL}" 											CACHE INTERNAL "" FORCE)
	set(CMAKE_ANDROID_STL_TYPE 			"${ANDROID_NDK_ANDROID_STL}" 											CACHE INTERNAL "" FORCE)
	set(CMAKE_CXX_FLAGS 				"${ANDROID_NDK_CXX_FLAGS}" 												CACHE INTERNAL "" FORCE)
endif()

# emscripten
if(${DK_BINARY_OS} MATCHES "emscripten")
	set(EMSDK 							"${DK3RDPARTY_DIR}/emsdk-main" 											CACHE INTERNAL "" FORCE)
	if(WIN32)
		set(EMSDK_GENERATOR 			"MinGW Makefiles" 														CACHE INTERNAL "" FORCE)
	elseif(UNIX)
		set(EMSDK_GENERATOR 			"Unix Makefiles" 														CACHE INTERNAL "" FORCE)
	endif()
	set(EMSDK_TOOLCHAIN_FILE 			"${EMSDK}/upstream/emscripten/cmake/Modules/Platform/Emscripten.cmake" 	CACHE INTERNAL "" FORCE)
	set(EMSDK_C_COMPILER 				"${EMSDK}/upstream/emscripten/emcc" 									CACHE INTERNAL "" FORCE)
	set(EMSDK_CXX_COMPILER 				"${EMSDK}/upstream/emscripten/em++" 									CACHE INTERNAL "" FORCE)
	
	
	set(CMAKE_GENERATOR 				"${EMSDK_GENERATOR}" 													CACHE INTERNAL "" FORCE)
	set(CMAKE_TOOLCHAIN_FILE 			"${EMSDK_TOOLCHAIN_FILE}" 												CACHE INTERNAL "" FORCE)
	set(CMAKE_C_COMPILER				"${EMSDK_C_COMPILER}" 													CACHE INTERNAL "" FORCE)
	set(CMAKE_CXX_COMPILER				"${EMSDK_CXX_COMPILER}" 												CACHE INTERNAL "" FORCE)
endif()

# ios_arm32
if(${DK_BINARY_OSARCH} MATCHES "ios_arm32")
	set(GENERATOR						"Xcode"	 																CACHE INTERNAL "" FORCE)
	set(IOS_TOOLCHAIN_FILE				"${DKCMAKE_DIR}/ios.toolchain.cmake" 										CACHE INTERNAL "" FORCE)
	set(IOS_PLATFORM 					"OS"																	CACHE INTERNAL "" FORCE)
	set(IOS_SDK_VERSION					"15.0"																	CACHE INTERNAL "" FORCE)
	set(IOS_DEPLOYMENT_TARGET			"13.0"																	CACHE INTERNAL "" FORCE)
		
	set(CMAKE_GENERATOR 				"${XCODE_GENERATOR}" 													CACHE INTERNAL "" FORCE)
	set(CMAKE_TOOLCHAIN_FILE 			"${IOS_TOOLCHAIN_FILE}" 												CACHE INTERNAL "" FORCE)
	set(PLATFORM 						"${IOS_PLATFORM}"														CACHE INTERNAL "" FORCE)
	set(SDK_VERSION						"${IOS_SDK_VERSION}"													CACHE INTERNAL "" FORCE)
	set(DEPLOYMENT_TARGET				"${IOS_DEPLOYMENT_TARGET}"												CACHE INTERNAL "" FORCE)
endif()

# ios_arm64
if(${DK_BINARY_OSARCH} MATCHES "ios_arm64")
	set(GENERATOR						"Xcode"	 																CACHE INTERNAL "" FORCE)
	set(IOS_TOOLCHAIN_FILE				"${DKCMAKE_DIR}/ios.toolchain.cmake" 										CACHE INTERNAL "" FORCE)
	set(IOS_PLATFORM 					"OS64"																	CACHE INTERNAL "" FORCE)
	set(IOS_SDK_VERSION					"15.0"																	CACHE INTERNAL "" FORCE)
	set(IOS_DEPLOYMENT_TARGET			"13.0"																	CACHE INTERNAL "" FORCE)
		
	set(CMAKE_GENERATOR 				"${GENERATOR}" 															CACHE INTERNAL "" FORCE)
	set(CMAKE_TOOLCHAIN_FILE 			"${IOS_TOOLCHAIN_FILE}" 												CACHE INTERNAL "" FORCE)
	set(PLATFORM 						"${IOS_PLATFORM}"														CACHE INTERNAL "" FORCE)
	set(SDK_VERSION						"${IOS_SDK_VERSION}"													CACHE INTERNAL "" FORCE)
	set(DEPLOYMENT_TARGET				"${IOS_DEPLOYMENT_TARGET}"												CACHE INTERNAL "" FORCE)
endif()

# iossim_x86
if(${DK_BINARY_OSARCH} MATCHES "iossim_x86")
	set(GENERATOR						"Xcode"	 																CACHE INTERNAL "" FORCE)
	set(IOS_TOOLCHAIN_FILE				"${DKCMAKE_DIR}/ios.toolchain.cmake" 										CACHE INTERNAL "" FORCE)
	set(IOS_PLATFORM 					"SIMULATOR"																CACHE INTERNAL "" FORCE)
	set(IOS_SDK_VERSION					"15.0"																	CACHE INTERNAL "" FORCE)
	set(IOS_DEPLOYMENT_TARGET			"13.0"																	CACHE INTERNAL "" FORCE)
		
	set(CMAKE_GENERATOR 				"${GENERATOR}" 															CACHE INTERNAL "" FORCE)
	set(CMAKE_TOOLCHAIN_FILE 			"${IOS_TOOLCHAIN_FILE}" 												CACHE INTERNAL "" FORCE)
	set(PLATFORM 						"${IOS_PLATFORM}"														CACHE INTERNAL "" FORCE)
	set(SDK_VERSION						"${IOS_SDK_VERSION}"													CACHE INTERNAL "" FORCE)
	set(DEPLOYMENT_TARGET				"${IOS_DEPLOYMENT_TARGET}"												CACHE INTERNAL "" FORCE)
endif()

# iossim_x86_64
if(${DK_BINARY_OSARCH} MATCHES "iossim_x86_64")
	set(GENERATOR						"Xcode"	 																CACHE INTERNAL "" FORCE)
	set(IOS_TOOLCHAIN_FILE				"${DKCMAKE_DIR}/ios.toolchain.cmake" 										CACHE INTERNAL "" FORCE)
	set(IOS_PLATFORM 					"SIMULATOR64"															CACHE INTERNAL "" FORCE)
	set(IOS_SDK_VERSION					"15.0"																	CACHE INTERNAL "" FORCE)
	set(IOS_DEPLOYMENT_TARGET			"13.0"																	CACHE INTERNAL "" FORCE)
		
	set(CMAKE_GENERATOR 				"${GENERATOR}" 															CACHE INTERNAL "" FORCE)
	set(CMAKE_TOOLCHAIN_FILE 			"${IOS_TOOLCHAIN_FILE}" 												CACHE INTERNAL "" FORCE)
	set(PLATFORM 						"${IOS_PLATFORM}"														CACHE INTERNAL "" FORCE)
	set(SDK_VERSION						"${IOS_SDK_VERSION}"													CACHE INTERNAL "" FORCE)
	set(DEPLOYMENT_TARGET				"${IOS_DEPLOYMENT_TARGET}"												CACHE INTERNAL "" FORCE)
endif()

# linux_x86
if(${DK_BINARY_OSARCH} MATCHES "linux_x86")
	set(GENERATOR						"Unix Makefiles"	 													CACHE INTERNAL "" FORCE)
	set(GCC_C_COMPILER					"/usr/bin/gcc"	 														CACHE INTERNAL "" FORCE)
	set(GCC_CXX_COMPILER				"/usr/bin/g++"	 														CACHE INTERNAL "" FORCE)

	set(CMAKE_GENERATOR 				"${GENERATOR}" 															CACHE INTERNAL "" FORCE)
	set(CMAKE_C_COMPILER				"${GCC_C_COMPILER}" 													CACHE INTERNAL "" FORCE)
	set(CMAKE_CXX_COMPILER				"${GCC_CXX_COMPILER}" 													CACHE INTERNAL "" FORCE)
endif()

# linux_x86_64
if(${DK_BINARY_OSARCH} MATCHES "linux_x86")
	set(GENERATOR						"Unix Makefiles"	 													CACHE INTERNAL "" FORCE)
	set(GCC_C_COMPILER					"/usr/bin/gcc"	 														CACHE INTERNAL "" FORCE)
	set(GCC_CXX_COMPILER				"/usr/bin/g++"	 														CACHE INTERNAL "" FORCE)

	set(CMAKE_GENERATOR 				"${GENERATOR}" 															CACHE INTERNAL "" FORCE)
	set(CMAKE_C_COMPILER				"${GCC_C_COMPILER}" 													CACHE INTERNAL "" FORCE)
	set(CMAKE_CXX_COMPILER				"${GCC_CXX_COMPILER}" 													CACHE INTERNAL "" FORCE)
endif()

# mac_x86
if(${DK_BINARY_OSARCH} MATCHES 	"mac_x86")
	set(GENERATOR						"Xcode"	 																CACHE INTERNAL "" FORCE)

	set(CMAKE_GENERATOR 				"${GENERATOR}" 															CACHE INTERNAL "" FORCE)
	set(CMAKE_OSX_ARCHITECTURES			"i686"																	CACHE INTERNAL "" FORCE)
	set(MAC_X86							"ON"																	CACHE INTERNAL "" FORCE)
endif()

# mac_x86_64
if(${DK_BINARY_OSARCH} MATCHES 	"mac_x86_64")
	set(GENERATOR						"Xcode"	 																CACHE INTERNAL "" FORCE)

	set(CMAKE_GENERATOR 				"${GENERATOR}" 															CACHE INTERNAL "" FORCE)
	set(CMAKE_OSX_ARCHITECTURES			"x86_64"																CACHE INTERNAL "" FORCE)
	set(MAC_X86_64						"ON"																	CACHE INTERNAL "" FORCE)
endif()

# raspberry_arm32
if(${DK_BINARY_OSARCH} MATCHES 	"raspberry_arm32")
	set(GENERATOR						"Unix Makefiles"	 													CACHE INTERNAL "" FORCE)
	set(GCC_C_COMPILER					"/usr/bin/gcc"	 														CACHE INTERNAL "" FORCE)
	set(GCC_CXX_COMPILER				"/usr/bin/g++"	 														CACHE INTERNAL "" FORCE)
	
	set(CMAKE_GENERATOR 				"${GENERATOR}" 															CACHE INTERNAL "" FORCE)
	set(CMAKE_C_COMPILER				"${GCC_C_COMPILER}" 													CACHE INTERNAL "" FORCE)
	set(CMAKE_CXX_COMPILER				"${GCC_CXX_COMPILER}" 													CACHE INTERNAL "" FORCE)
endif()

# raspberry_arm64
if(${DK_BINARY_OSARCH} MATCHES 	"raspberry_arm64")
	set(GENERATOR						"Unix Makefiles"	 													CACHE INTERNAL "" FORCE)
	set(GCC_C_COMPILER					"/usr/bin/gcc"	 														CACHE INTERNAL "" FORCE)
	set(GCC_CXX_COMPILER				"/usr/bin/g++"	 														CACHE INTERNAL "" FORCE)
	
	set(CMAKE_GENERATOR 				"${GENERATOR}" 															CACHE INTERNAL "" FORCE)
	set(CMAKE_C_COMPILER				"${GCC_C_COMPILER}" 													CACHE INTERNAL "" FORCE)
	set(CMAKE_CXX_COMPILER				"${GCC_CXX_COMPILER}" 													CACHE INTERNAL "" FORCE)
endif()

# win_x86
if(${DK_BINARY_OSARCH} MATCHES "win_x86")
	set(MSYS2							"${DK3RDPARTY_DIR}/msys2-x86_64-20231026"								CACHE INTERNAL "" FORCE)
	set(MSYS2_GENERATOR					"MSYS Makefiles"														CACHE INTERNAL "" FORCE)
	set(GCC_C_COMPILER					"${MSYS2}/mingw32/bin/gcc.exe"											CACHE INTERNAL "" FORCE)
	set(GCC_CXX_COMPILER				"${MSYS2}/mingw32/bin/g++.exe"											CACHE INTERNAL "" FORCE)
	set(MAKE_PROGRAM					"${MSYS2}/mingw32/bin/make.exe"											CACHE INTERNAL "" FORCE)
	
	set(CMAKE_GENERATOR 				"${MSYS2_GENERATOR}" 													CACHE INTERNAL "" FORCE)
	set(CMAKE_MAKE_PROGRAM 				"${MAKE_PROGRAM}" 														CACHE INTERNAL "" FORCE)
	set(CMAKE_C_COMPILER				"${GCC_C_COMPILER}" 													CACHE INTERNAL "" FORCE)
	set(CMAKE_CXX_COMPILER				"${GCC_CXX_COMPILER}" 													CACHE INTERNAL "" FORCE)
endif()

# win_x86_64
if(${DK_BINARY_OSARCH} MATCHES "win_x86_64")
	set(MSYS2							"${DK3RDPARTY_DIR}/msys2-x86_64-20231026"								CACHE INTERNAL "" FORCE)
	set(MSYS2_GENERATOR					"MSYS Makefiles"														CACHE INTERNAL "" FORCE)
	set(GCC_C_COMPILER					"${MSYS2}/mingw64/bin/gcc.exe"											CACHE INTERNAL "" FORCE)
	set(GCC_CXX_COMPILER				"${MSYS2}/mingw64/bin/g++.exe"											CACHE INTERNAL "" FORCE)
	set(MAKE_PROGRAM					"${MSYS2}/mingw64/bin/make.exe"											CACHE INTERNAL "" FORCE)
	
	set(CMAKE_GENERATOR 				"${MSYS2_GENERATOR}" 													CACHE INTERNAL "" FORCE)
	set(CMAKE_MAKE_PROGRAM 				"${MAKE_PROGRAM}" 														CACHE INTERNAL "" FORCE)
	set(CMAKE_C_COMPILER				"${GCC_C_COMPILER}" 													CACHE INTERNAL "" FORCE)
	set(CMAKE_CXX_COMPILER				"${GCC_CXX_COMPILER}" 													CACHE INTERNAL "" FORCE)
endif()