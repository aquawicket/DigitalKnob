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


############ xcode ############
# https://developer.apple.com/xcode/
# https://pewpewthespells.com/blog/buildsettings.html
# https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/OSX_Technology_Overview/SystemFrameworks/SystemFrameworks.html

if(NOT Mac_Host)
	dk_disable(xcode)
	dk_return()
endif()

# Xcode variables
dk_set(xcode_GENERATOR		"Xcode")
dk_set(xcode_DEVROOT		"/Applications/Xcode.app/Contents/Developer")
dk_set(xcode_C_COMPILER		"${xcode_DEVROOT}/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang")
dk_set(xcode_CXX_COMPILER	"${xcode_DEVROOT}/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang++")
dk_set(xcode_LIBTOOL		"${xcode_DEVROOT}/Toolchains/XcodeDefault.xctoolchain/usr/bin/libtool")
find_program(xcodebuild_exe xcodebuild)
if(NOT xcodebuild_exe)
	dk_fatal("xcodebuild not found. Please install either the standalone commandline tools or Xcode.")
endif()

# iOS variables
dk_set(IOS_TOOLCHAIN_FILE	"$ENV{DKCMAKE_DIR}/ios.toolchain.cmake")
dk_set(IOS_DARWIN			darwin20.6.0)
dk_set(IOS_SDK				15.0)
dk_set(IOS_MIN_SDK			13.0)
dk_set(IOS_SYSROOT			"${xcode_DEVROOT}/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS${IOS_SDK}.sdk")
dk_set(IOSSIM_SYSROOT		"${xcode_DEVROOT}/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator${IOS_SDK}.sdk")

###### set GLOBAL CMAKE VARIABLES ######
dk_set(CMAKE_GENERATOR		${xcode_GENERATOR})
dk_set(CMAKE_MAKE_PROGRAM	${xcodebuild_exe})
dk_set(CMAKE_C_COMPILER		${xcode_C_COMPILER})
dk_set(CMAKE_CXX_COMPILER	${xcode_CXX_COMPILER})

dk_set(DKCONFIGURE_CC		${CMAKE_C_COMPILER})
dk_set(DKCONFIGURE_CXX		${CMAKE_CXX_COMPILER})
