#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ xcode ############
# https://developer.apple.com/xcode/
# https://pewpewthespells.com/blog/buildsettings.html
# Apple Frameworks https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/OSX_Technology_Overview/SystemFrameworks/SystemFrameworks.html

dk_load(dk_builder)

if(NOT MAC_HOST)
	dk_undepend(xcode)
	dk_return()
endif()

# Xcode variables
dk_set(XCODE_GENERATOR		"Xcode")
dk_set(XCODE_DEVROOT		"/Applications/Xcode.app/Contents/Developer")
dk_set(XCODE_C_COMPILER		"${XCODE_DEVROOT}/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang")
dk_set(XCODE_CXX_COMPILER	"${XCODE_DEVROOT}/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang++")
dk_set(XCODE_LIBTOOL		"${XCODE_DEVROOT}/Toolchains/XcodeDefault.xctoolchain/usr/bin/libtool")
find_program(XCODEBUILD_EXE xcodebuild)
if(NOT XCODEBUILD_EXE)
	dk_fatal("xcodebuild not found. Please install either the standalone commandline tools or Xcode.")
endif()

# iOS variables
dk_set(IOS_TOOLCHAIN_FILE	"${DKCMAKE_DIR}/ios.toolchain.cmake")
dk_set(IOS_DARWIN			darwin20.6.0)
dk_set(IOS_SDK				15.0)
dk_set(IOS_MIN_SDK			13.0)
dk_set(IOS_SYSROOT			"${XCODE_DEVROOT}/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS${IOS_SDK}.sdk")
dk_set(IOSSIM_SYSROOT		"${XCODE_DEVROOT}/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator${IOS_SDK}.sdk")

###### set GLOBAL CMAKE VARIABLES ######
dk_set(CMAKE_GENERATOR		${XCODE_GENERATOR})
dk_set(CMAKE_MAKE_PROGRAM	${XCODEBUILD_EXE})
dk_set(CMAKE_C_COMPILER		${XCODE_C_COMPILER})
dk_set(CMAKE_CXX_COMPILER	${XCODE_CXX_COMPILER})

dk_set(DKCONFIGURE_CC		${CMAKE_C_COMPILER})
dk_set(DKCONFIGURE_CXX		${CMAKE_CXX_COMPILER})
