#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
return()
# This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
#
# For the latest information, see https://github.com/aquawicket/DigitalKnob
#
# Copyright(c) 2010 - 2025 Digitalknob Team, and contributors
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


### Get CMAKE_SOURCE_DIR ###
if(NOT CMAKE_SOURCE_DIR)
	dk_fatal("CMAKE_SOURCE_DIR invalid!")
endif()
dk_getFullPath(${CMAKE_SOURCE_DIR} CMAKE_SOURCE_DIR)
dk_info("CMAKE_SOURCE_DIR = ${CMAKE_SOURCE_DIR}")


### Get CMAKE_BINARY_DIR ###
if(NOT CMAKE_BINARY_DIR)
	dk_fatal("CMAKE_BINARY_DIR invalid!")
endif()
dk_getFullPath(${CMAKE_BINARY_DIR} CMAKE_BINARY_DIR)
dk_info("CMAKE_BINARY_DIR = ${CMAKE_BINARY_DIR}")


### Set DKCMAKE_DIR ###
dk_set(ENV{DKCMAKE_DIR} ${CMAKE_SOURCE_DIR})
dk_info("DKCMAKE_DIR = $ENV{DKCMAKE_DIR}")

### Set DKBRANCH_DIR
string(FIND "$ENV{DKCMAKE_DIR}" "DKCMake" pos)
math(EXPR pos "${pos}-1")
string(SUBSTRING $ENV{DKCMAKE_DIR} 0 ${pos} DKBRANCH_DIR)
dk_set(ENV{DKBRANCH}_DIR $ENV{DKBRANCH_DIR})
dk_info("DKBRANCH_DIR = $ENV{DKBRANCH_DIR}")

### Set DIGITALKNOB_DIR
string(FIND "$ENV{DKBRANCH_DIR}" "digitalknob" pos)
string(SUBSTRING $ENV{DKBRANCH_DIR} 0 ${pos} DIGITALKNOB_DIR)
dk_set(DIGITALKNOB_DIR $ENV{DIGITALKNOB_DIR}digitalknob)
dk_info("DIGITALKNOB_DIR = $ENV{DIGITALKNOB_DIR}")

### Set DK3RDPARTY_DIR
dk_set(DK3RDPARTY_DIR $ENV{DKBRANCH_DIR}/3rdParty)

### Set DK_BINARY_DIR ###
dk_set(DK_BINARY_DIR ${CMAKE_BINARY_DIR})
dk_info("DK_BINARY_DIR = ${DK_BINARY_DIR}")

### Set DK_BINARY_OSARCH_DIR ###
if(${CMAKE_BINARY_DIR} MATCHES "Debug$")
	dk_dirname(${CMAKE_BINARY_DIR} DK_BINARY_OSARCH_DIR)
elseif(${CMAKE_BINARY_DIR} MATCHES "Release$")
	dk_dirname(${CMAKE_BINARY_DIR} DK_BINARY_OSARCH_DIR)
else()
	dk_set(DK_BINARY_OSARCH_DIR ${DK_BINARY_DIR})
endif()
dk_info("DK_BINARY_OSARCH_DIR = ${DK_BINARY_OSARCH_DIR}")
	
### Set DK_BINARY_OSARCH ###
dk_basename(${DK_BINARY_OSARCH_DIR} DK_BINARY_OSARCH)     
dk_info("DK_BINARY_OSARCH = ${DK_BINARY_OSARCH}")

### Set DK_BINARY_OS ###
string(FIND "${DK_BINARY_OSARCH}" "_" first_underscore)
string(SUBSTRING "${DK_BINARY_OSARCH}" 0 ${first_underscore} DK_BINARY_OS)
dk_info("DK_BINARY_OS = ${DK_BINARY_OS}")
	
## Set DK_BINARY_ARCH ###
string(FIND "${DK_BINARY_OSARCH}" "_" first_underscore)
math(EXPR after_underscore "${first_underscore}+1" OUTPUT_FORMAT DECIMAL)
string(SUBSTRING "${DK_BINARY_OSARCH}" ${after_underscore} -1 DK_BINARY_ARCH)
dk_info("DK_BINARY_ARCH = ${DK_BINARY_ARCH}")

### Set DK_Project_Dir ###
dk_dirname(${DK_BINARY_OSARCH_DIR} DK_Project_Dir)
dk_info("DK_Project_Dir = ${DK_Project_Dir}")
	
	
if(1)
	
# android_arm32
if(${DK_BINARY_OSARCH} MATCHES "android_arm32")
	dk_set(ANDROID_NDK 						"$ENV{DK3RDPARTY_DIR}/android-sdk/ndk/23.1.7779620")
	dk_set(ANDROID_NDK_GENERATOR 			"Unix Makefiles")
	dk_set(ANDROID_NDK_MAKE_PROGRAM 		"${ANDROID_NDK}/prebuilt/windows-x86_64/bin/make.exe")
	dk_set(ANDROID_NDK_ANDROID_ABI			"armeabi-v7a")
	dk_set(ANDROID_NDK_ANDROID_PLATFORM 	"31")
	dk_set(ANDROID_NDK_TOOLCHAIN_FILE 		"${ANDROID_NDK}/build/cmake/android.toolchain.cmake")
	dk_set(ANDROID_NDK_ANDROID_TOOLCHAIN 	"clang")
	dk_set(ANDROID_NDK_ANDROID_STL 			"c++_static")
	dk_set(ANDROID_NDK_CXX_FLAGS 			"-std=c++1z -frtti -fexceptions")
	
	
	dk_set(CMAKE_ANDROID_NDK 				"${ANDROID_NDK}")
	dk_set(CMAKE_GENERATOR 					"${ANDROID_NDK_GENERATOR}")
	dk_set(CMAKE_MAKE_PROGRAM 				"${ANDROID_NDK_MAKE_PROGRAM}")
	dk_set(ANDROID_ABI 						"${ANDROID_NDK_ANDROID_ABI}")
	dk_set(CMAKE_ANDROID_ARCH_ABI 			"${ANDROID_NDK_ANDROID_ABI}")
	dk_set(ANDROID_PLATFORM 				"${ANDROID_NDK_ANDROID_PLATFORM}")
	dk_set(CMAKE_TOOLCHAIN_FILE 			"${ANDROID_NDK_TOOLCHAIN_FILE}")
	dk_set(ANDROID_TOOLCHAIN 				"${ANDROID_NDK_ANDROID_TOOLCHAIN}")
	dk_set(ANDROID_STL 						"${ANDROID_NDK_ANDROID_STL}")
	dk_set(CMAKE_ANDROID_STL_TYPE 			"${ANDROID_NDK_ANDROID_STL}")
	dk_set(CMAKE_CXX_FLAGS 					"${ANDROID_NDK_CXX_FLAGS}")
endif()

# android_arm64
if(${DK_BINARY_OSARCH} MATCHES "android_arm64")
	dk_set(ANDROID_NDK 						"$ENV{DK3RDPARTY_DIR}/android-sdk/ndk/23.1.7779620")
	dk_set(ANDROID_NDK_GENERATOR 			"Unix Makefiles")
	dk_set(ANDROID_NDK_MAKE_PROGRAM 		"${ANDROID_NDK}/prebuilt/windows-x86_64/bin/make.exe")
	dk_set(ANDROID_NDK_ANDROID_ABI			"arm64-v8a")
	dk_set(ANDROID_NDK_ANDROID_PLATFORM 	"31")
	dk_set(ANDROID_NDK_TOOLCHAIN_FILE 		"${ANDROID_NDK}/build/cmake/android.toolchain.cmake")
	dk_set(ANDROID_NDK_ANDROID_TOOLCHAIN 	"clang")
	dk_set(ANDROID_NDK_ANDROID_STL 			"c++_static")
	dk_set(ANDROID_NDK_CXX_FLAGS 			"-std=c++1z -frtti -fexceptions")
	
	
	dk_set(CMAKE_ANDROID_NDK 				"${ANDROID_NDK}")
	dk_set(CMAKE_GENERATOR 					"${ANDROID_NDK_GENERATOR}")
	dk_set(CMAKE_MAKE_PROGRAM 				"${ANDROID_NDK_MAKE_PROGRAM}")
	dk_set(ANDROID_ABI 						"${ANDROID_NDK_ANDROID_ABI}")
	dk_set(CMAKE_ANDROID_ARCH_ABI 			"${ANDROID_NDK_ANDROID_ABI}")
	dk_set(ANDROID_PLATFORM 				"${ANDROID_NDK_ANDROID_PLATFORM}")
	dk_set(CMAKE_TOOLCHAIN_FILE 			"${ANDROID_NDK_TOOLCHAIN_FILE}")
	dk_set(ANDROID_TOOLCHAIN 				"${ANDROID_NDK_ANDROID_TOOLCHAIN}")
	dk_set(ANDROID_STL 						"${ANDROID_NDK_ANDROID_STL}")
	dk_set(CMAKE_ANDROID_STL_TYPE 			"${ANDROID_NDK_ANDROID_STL}")
	dk_set(CMAKE_CXX_FLAGS 					"${ANDROID_NDK_CXX_FLAGS}")
endif()

# ios_arm32
if(${DK_BINARY_OSARCH} MATCHES "ios_arm32")
	dk_set(IOS_PLATFORM 					"OS")
	dk_set(IOS_SDK_VERSION					"15.0")
	dk_set(IOS_DEPLOYMENT_TARGET			"13.0")
		
	dk_set(CMAKE_TOOLCHAIN_FILE 			"${IOS_TOOLCHAIN_FILE}")
	dk_set(PLATFORM 						"${IOS_PLATFORM}")
	dk_set(SDK_VERSION						"${IOS_SDK_VERSION}")
	dk_set(DEPLOYMENT_TARGET				"${IOS_DEPLOYMENT_TARGET}")
endif()

# ios_arm64
if(${DK_BINARY_OSARCH} MATCHES "ios_arm64")
	dk_set(IOS_TOOLCHAIN_FILE				"$ENV{DKCMAKE_DIR}/ios.toolchain.cmake")
	dk_set(IOS_PLATFORM 					"OS64")
	dk_set(IOS_SDK_VERSION					"15.0")
	dk_set(IOS_DEPLOYMENT_TARGET			"13.0")
		
	dk_set(CMAKE_TOOLCHAIN_FILE 			"${IOS_TOOLCHAIN_FILE}")
	dk_set(PLATFORM 						"${IOS_PLATFORM}")
	dk_set(SDK_VERSION						"${IOS_SDK_VERSION}")
	dk_set(DEPLOYMENT_TARGET				"${IOS_DEPLOYMENT_TARGET}")
endif()

# iossim_x86
if(${DK_BINARY_OSARCH} MATCHES "iossim_x86")
	dk_set(IOS_TOOLCHAIN_FILE				"$ENV{DKCMAKE_DIR}/ios.toolchain.cmake")
	dk_set(IOS_PLATFORM 					"SIMULATOR")
	dk_set(IOS_SDK_VERSION					"15.0")
	dk_set(IOS_DEPLOYMENT_TARGET			"13.0")
		
	dk_set(CMAKE_GENERATOR 					"${GENERATOR}")
	dk_set(CMAKE_TOOLCHAIN_FILE 			"${IOS_TOOLCHAIN_FILE}")
	dk_set(PLATFORM 						"${IOS_PLATFORM}")
	dk_set(SDK_VERSION						"${IOS_SDK_VERSION}")
	dk_set(DEPLOYMENT_TARGET				"${IOS_DEPLOYMENT_TARGET}")
endif()

# iossim_x86_64
if(${DK_BINARY_OSARCH} MATCHES "iossim_x86_64")	
	dk_set(IOS_TOOLCHAIN_FILE				"$ENV{DKCMAKE_DIR}/ios.toolchain.cmake")
	dk_set(IOS_PLATFORM 					"SIMULATOR64")
	dk_set(IOS_SDK_VERSION					"15.0")
	dk_set(IOS_DEPLOYMENT_TARGET			"13.0")
		
	dk_set(CMAKE_GENERATOR 					"${GENERATOR}")
	dk_set(CMAKE_TOOLCHAIN_FILE 			"${IOS_TOOLCHAIN_FILE}")
	dk_set(PLATFORM 						"${IOS_PLATFORM}")
	dk_set(SDK_VERSION						"${IOS_SDK_VERSION}")
	dk_set(DEPLOYMENT_TARGET				"${IOS_DEPLOYMENT_TARGET}")
endif()


# mac_x86
if(${DK_BINARY_OSARCH} MATCHES 	"mac_x86")
	dk_set(CMAKE_OSX_ARCHITECTURES			"i686")
	dk_set(MAC_X86							"ON")
endif()

# mac_x86_64
if(${DK_BINARY_OSARCH} MATCHES 	"mac_x86_64")
	dk_set(CMAKE_OSX_ARCHITECTURES			"x86_64")
	dk_set(MAC_X86_64						"ON")
endif()

endif()