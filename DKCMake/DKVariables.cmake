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

if(EXISTS $ENV{DKCMAKE})
	set(ENV{DKCMAKE} "$ENV{DKCMAKE}/")
endif()
include("$ENV{DKCMAKE}DK.cmake")


# FIXME: work to remove this
if(COMMAND cmake_policy)
	cmake_policy(SET CMP0003 NEW) ##https://cmake.org/cmake/help/latest/policy/CMP0003.html
endif(COMMAND cmake_policy)


###############################################################
## Set variables for paths
###############################################################
dk_set(DKCMAKE ${DIGITALKNOB}/DK/DKCMake)
dk_set(DKPLUGINS ${DIGITALKNOB}/DK/DKPlugins)
dk_set(3RDPARTY ${DIGITALKNOB}/DK/3rdParty)
dk_set(DKIMPORTS ${3RDPARTY}/_DKIMPORTS)
dk_set(DKDOWNLOAD ${DIGITALKNOB}/download)
dk_set(DKWEB "http://127.0.0.1")
dk_set(CURRENT_DIR ${DIGITALKNOB})

dk_set(CMAKE_SUPPRESS_REGENERATION true)

### Install DBIN binary directory ###
if(INSTALL_DKLIBS)
	dk_set(CMAKE_INSTALL_PREFIX ${DIGITALKNOB}/DKBIN)
endif()


###########################################################################
## Bulid the TARGET passed from the command line
###########################################################################
if(TARGET)
	dk_info("Building ${TARGET}\n")
	dk_findTarget("${TARGET}" target_path target_type)
	if(NOT target_path)
		dk_error("ERROR: Could not find target ${TARGET}")
		dk_wait("press any key to exit")
		dk_exit()
	endif()
	dk_info("found ${TARGET}:(${target_type}) at ${target_path}")
	dk_set(BYPASS_DISABLE ON)
	dk_set(QUEUE_BUILD ON)
	WIN_dk_depend(visualstudio)
	#if(NOT "${target_type}" STREQUAL "DKAPP")
	#	dk_depend(${TARGET})
	#else()
		project(${TARGET})
		dk_set(DKAPP 1)
		file(WRITE ${DKCMAKE}/temp/${TARGET}.cmd "\"${MSBUILD}\" ${CMAKE_BINARY_DIR}/DigitalKnob.sln /p:Configuration=Release\n")
		file(APPEND ${DKCMAKE}/temp/${TARGET}.cmd "${CMAKE_BINARY_DIR}/${RELEASE_DIR}/${TARGET}.exe")
	#endif()
endif()


###########################################################################
## Set the IDE variable
###########################################################################
string(FIND "${CMAKE_GENERATOR}" "Visual Studio" index)
if(${index} GREATER -1)
	dk_set(VISUAL_STUDIO_IDE ON)
endif()
string(FIND "${CMAKE_GENERATOR}" "Xcode" index)
if(${index} GREATER -1)
	dk_set(XCODE_IDE ON)
endif()


###########################################################################
## Get variables for Build Type
###########################################################################
option(DEBUG "Build Debug Output" ON)
option(RELEASE "Build Release Output" ON)
if(NOT DEBUG)
if(NOT RELEASE)
	dk_info("No Build type selected. Defaulting to DEBUG and RELEASE")
	dk_set(DEBUG ON)
	dk_set(RELEASE ON)
endif()
endif()


###########################################################################
## Get variables for Build Level
###########################################################################
option(BUILD "Simpily build the app or library" OFF)
option(REBUILD "Rebuild the app" OFF)
option(REBUILDALL "Rebuild the app and all dependencies" OFF)
if(NOT BUILD)
if(NOT REBUILD)
if(NOT REBUILDALL)
	dk_info("No Build level selected, defaulting to REBUILDALL")
	dk_set(REBUILDALL ON)
endif()
endif()
endif()


###########################################################################
## Get variables for Library Build Type (STATIC or SHARED)
###########################################################################
option(STATIC "Build Static Libraries and Plugins" OFF)
option(SHARED "Build Shared Libraries and Plugins" OFF)
if(NOT STATIC)
if(NOT SHARED)
	dk_set(STATIC ON)
endif()
endif()


###########################################################################
## Get variables for CEF
###########################################################################
option(DKCEF "Use Chromium Embeded Framework" OFF)
if(${DKCEF} STREQUAL "ON")
	add_definitions(-DHAVE_DKCef)
endif()


########### Determine if we are building a DKApp, DKPlugin or 3rdParty #############
#string(FIND "${CMAKE_BINARY_DIR}" "/DKApps/" index)
#if(${index} GREATER -1)
#	dk_info("Building DKApp . . .")
#	dk_set(DKAPP ON)
#	add_definitions(-DDKAPP)
#endif()
#string(FIND "${CMAKE_BINARY_DIR}" "/DKPlugin/" index)
#if(${index} GREATER -1)
#	dk_info("Building DKPlugin . . .")
#endif()
#string(FIND "${CMAKE_BINARY_DIR}" "/3rdParty/" index)
#if(${index} GREATER -1)
#	dk_info("Building 3rdParty . . .")
#endif()


########### Determine the OS we are building for ####################

# WIN 32
string(FIND "${CMAKE_BINARY_DIR}" "/win32" index)
if(${index} GREATER -1)
	dk_info("Creating Windows x32 Project Files")
	dk_set(WIN ON)
	dk_set(WIN_32 ON)
	dk_set(OS "win32")
	dk_set(DEBUG_DIR Debug)
	dk_set(RELEASE_DIR Release)
	dk_set(CMAKE_SKIP_RPATH ON)
	string(REPLACE "/win32" "" DKPROJECT ${CMAKE_BINARY_DIR})
endif()

# WIN 64
string(FIND "${CMAKE_BINARY_DIR}" "/win64" index)
if(${index} GREATER -1)
	dk_info("*** Creating Windows x64 Project Files ***")
	dk_set(WIN ON)
	dk_set(WIN_64 ON)
	dk_set(OS "win64")
	dk_set(DEBUG_DIR Debug)
	dk_set(RELEASE_DIR Release)
	dk_set(CMAKE_SKIP_RPATH ON)
	string(REPLACE "/win64" "" DKPROJECT ${CMAKE_BINARY_DIR})
endif()

# MAC 32
string(FIND "${CMAKE_BINARY_DIR}" "/mac32" index)
if(${index} GREATER -1)
	dk_info("*** Creating Mac x32 Project Files ***")
	dk_set(MAC ON)
	dk_set(MAC_32 ON)
	dk_set(OS "mac32")
	dk_set(DEBUG_DIR Debug)
	dk_set(RELEASE_DIR Release)
	dk_set(CMAKE_SKIP_RPATH ON)
	string(REPLACE "/mac32" "" DKPROJECT ${CMAKE_BINARY_DIR})
endif()

# MAC 64
string(FIND "${CMAKE_BINARY_DIR}" "/mac64" index)
if(${index} GREATER -1)
	dk_info("*** Creating Mac x64 Project Files ***")
	dk_set(MAC ON)
	dk_set(MAC_64 ON)
	dk_set(OS "mac64")
	dk_set(DEBUG_DIR Debug)
	dk_set(RELEASE_DIR Release)
	dk_set(CMAKE_SKIP_RPATH ON)
	string(REPLACE "/mac64" "" DKPROJECT ${CMAKE_BINARY_DIR})
endif()

# IOS 32
string(FIND "${CMAKE_BINARY_DIR}" "/ios32" index)
if(${index} GREATER -1)
	dk_info("*** Creating iOS x32 Project Files ***")
	dk_set(IOS ON)
	dk_set(IOS_32 ON)
	dk_set(OS "ios32")
	dk_set(DEBUG_DIR Debug-iphoneos)
	dk_set(RELEASE_DIR Release-iphoneos)
	#dk_set(DEBUG_DIR Debug)
	#dk_set(RELEASE_DIR Release)
	dk_set(CMAKE_SKIP_RPATH ON)
	string(REPLACE "/ios32" "" DKPROJECT ${CMAKE_BINARY_DIR})
endif()

# IOS 64
string(FIND "${CMAKE_BINARY_DIR}" "/ios64" index)
if(${index} GREATER -1)
	dk_info("*** Creating iOS x64 Project Files ***")
	dk_set(IOS ON)
	dk_set(IOS_64 ON)
	dk_set(OS "ios64")
	dk_set(DEBUG_DIR Debug-iphoneos)
	dk_set(RELEASE_DIR Release-iphoneos)
	#dk_set(DEBUG_DIR Debug)
	#dk_set(RELEASE_DIR Release)
	dk_set(CMAKE_SKIP_RPATH ON)
	string(REPLACE "/ios64" "" DKPROJECT ${CMAKE_BINARY_DIR})
endif()

# IOSSIM 32
string(FIND "${CMAKE_BINARY_DIR}" "/iossim32" index)
if(${index} GREATER -1)
	dk_info("*** Creating iOS-Simulator x32 Project Files ***")
	dk_set(IOSSIM ON)
	dk_set(IOSSIM_32 ON)
	dk_set(OS "iossim32")
	dk_set(DEBUG_DIR Debug-iphonesimulator)
	dk_set(RELEASE_DIR Release-iphonesimulator)
	#dk_set(DEBUG_DIR Debug)
	#dk_set(RELEASE_DIR Release)
	dk_set(CMAKE_SKIP_RPATH ON)
	string(REPLACE "/iossim32" "" DKPROJECT ${CMAKE_BINARY_DIR})
endif()

# IOSSIM 64
string(FIND "${CMAKE_BINARY_DIR}" "/iossim64" index)
if(${index} GREATER -1)
	dk_info("*** Creating iOS-Simulator x64 Project Files ***")
	dk_set(IOSSIM ON)
	dk_set(IOSSIM_64 ON)
	dk_set(OS "iossim64")
	dk_set(DEBUG_DIR Debug-iphonesimulator)
	dk_set(RELEASE_DIR Release-iphonesimulator)
	#dk_set(DEBUG_DIR Debug)
	#dk_set(RELEASE_DIR Release)
	dk_set(CMAKE_SKIP_RPATH ON)
	string(REPLACE "/iossim64" "" DKPROJECT ${CMAKE_BINARY_DIR})
endif()


###########################################################################################
###########################################################################################
## NOTICE ##
## WORK IN PROGRESS ##
## Working to consolidate and remove the need for seperate raspberry pi functions
## The build setup is almost Identicle to linux. We will try to compile Rpi by excluding
## the RASPBERRY flag variables in place of the LINUX functions. In this conversion,
## Raspberry will listen to LINUX 32/64 and RPI 32/34.   The RASPBERRY flags will do nothing
## and we should be able to remove them once everythng is working.

# RASPBERRY 32
string(FIND "${CMAKE_BINARY_DIR}" "/raspberry32" index)
if(${index} GREATER -1)
	dk_info("*** Creating RASPBERRY x32 Project Files ***")
	dk_set(RASPBERRY ON)     #To be disabled
	dk_set(RASPBERRY_32 ON)  #To be disabled
	#dk_set(LINUX ON)
	#dk_set(LINUX32 ON)
	dk_set(RPI ON)
	dk_set(RPI32 ON)
	dk_set(OS "raspberry32")
	dk_set(DEBUG_DIR Debug)
	dk_set(RELEASE_DIR Release)
	string(REPLACE "/raspberry32" "" DKPROJECT ${CMAKE_BINARY_DIR})
endif()

# RASPBERY 64
string(FIND "${CMAKE_BINARY_DIR}" "/raspberry64" index)
if(${index} GREATER -1)
	dk_info("*** Creating Raspberry x64 Project Files ***")
	dk_set(RASPBERRY ON)     #To be disabled
	dk_set(RASPBERRY_64 ON)  #To be disabled
	#dk_set(LINUX ON)
	#dk_set(LINUX64 ON)
	dk_set(RPI ON)
	dk_set(RPI64 ON)
	dk_set(OS "raspberry64")
	dk_set(DEBUG_DIR Debug)
	dk_set(RELEASE_DIR Release)
	string(REPLACE "/raspberry64" "" DKPROJECT ${CMAKE_BINARY_DIR})
endif()
#########################################################################################
#########################################################################################


# LINUX 32
string(FIND "${CMAKE_BINARY_DIR}" "/linux32" index)
if(${index} GREATER -1)
if(NOT RASPBERRY)
if(NOT RPI)
	dk_info("*** Creating Linux x32 Project Files ***")
	dk_set(LINUX ON)
	dk_set(LINUX_32 ON)
	dk_set(OS "linux32")
	dk_set(DEBUG_DIR Debug)
	dk_set(RELEASE_DIR Release)
	string(REPLACE "/linux32" "" DKPROJECT ${CMAKE_BINARY_DIR})
endif()
endif()
endif()

# LINUX 64
string(FIND "${CMAKE_BINARY_DIR}" "/linux64" index)
if(${index} GREATER -1)
if(NOT RASPBERRY)
if(NOT RPI)
	dk_info("*** Creating Linux x64 Project Files ***")
	dk_set(LINUX ON)
	dk_set(LINUX_64 ON)
	dk_set(OS "linux64")
	dk_set(DEBUG_DIR Debug)
	dk_set(RELEASE_DIR Release)
	string(REPLACE "/linux64" "" DKPROJECT ${CMAKE_BINARY_DIR})
endif()
endif()
endif()

# ANDROID 32
string(FIND "${CMAKE_BINARY_DIR}" "/android32" index)
if(${index} GREATER -1)
	dk_info("*** Creating Android x32 Project Files ***")
	dk_set(ANDROID ON)
	dk_set(ANDROID_32 ON)
	dk_set(OS "android32")
	dk_set(DEBUG_DIR Debug)
	dk_set(RELEASE_DIR Release)
	dk_set(CMAKE_SKIP_RPATH ON)
	string(REPLACE "/android32" "" DKPROJECT ${CMAKE_BINARY_DIR})
endif()

# ANDROID 64
string(FIND "${CMAKE_BINARY_DIR}" "/android64" index)
if(${index} GREATER -1)
	dk_info("*** Creating Android x64 Project Files ***")
	dk_set(ANDROID ON)
	dk_set(ANDROID_64 ON)
	dk_set(OS "android64")
	dk_set(DEBUG_DIR Debug)
	dk_set(RELEASE_DIR Release)
	dk_set(CMAKE_SKIP_RPATH ON)
	string(REPLACE "/android64" "" DKPROJECT ${CMAKE_BINARY_DIR})
endif()

# EMSCRIPTEN
string(FIND "${CMAKE_BINARY_DIR}" "/emscripten" index)
if(${index} GREATER -1)
	dk_info("*** Creating Emscripten Project Files ***")
	dk_set(EMSCRIPTEN ON)
	dk_set(OS "emscripten")
	dk_set(DEBUG_DIR Debug)
	dk_set(RELEASE_DIR Release)
	string(REPLACE "/emscripten" "" DKPROJECT ${CMAKE_BINARY_DIR})
endif()


if(NOT CMAKE_SCRIPT_MODE_FILE)
	if(NOT OS)
		dk_error(CMAKE_BINARY_DIR)
		dk_assert("The binary directory must contain an os folder. \n Valid folders are win32,win64,mac32,mac64,linux32,linux64,ios32,ios64,iossim32,iossim64,android32,android64,raspberry32 or raspberry64 \n 	EXAMPLE: digitalknob/DKApps/MyApp/win32")
		#file(REMOVE ${CMAKE_BINARY_DIR})
	endif()

	## we use /Debug and /Release folders for Linux, Android and Raspberry
	## if they are present, remove them and let DEBUG and RELEASE flags deal with that later.
	string(REPLACE "/Debug" "" DKPROJECT ${DKPROJECT})
	string(REPLACE "/Release" "" DKPROJECT ${DKPROJECT})
endif()


## TODO: NEW STYLE
#if(WIN) #OS
#	add_definitions(-DWIN) #OS
#	if(X32) #ARCH
#		add_definitions(-DWIN_X32) #OS_ARCH
#		if(DEBUG)
#			add_definitions(-DWIN_X32_DEBUG) #OS_ARCH_TYPE
#		endif()
#		if(RELEASE)
#			add_definitions(-DWIN_X32_RELEASE) #OS_ARCH_TYPE
#		endif()
#	endif()
#	if(X64) #ARCH
#		add_definitions(-DWIN_X64) #OS_ARCH
#		if(DEBUG)
#			add_definitions(-DWIN_X64_DEBUG) #OS_ARCH_TYPE
#		endif()
#		if(RELEASE)
#			add_definitions(-DWIN_X64_RELEASE) #OS_ARCH_TYPE
#		endif()
#	endif()
#	if(ARM32) #ARCH
#		add_definitions(-DWIN_ARM32) #OS_ARCH
#		if(DEBUG)
#			add_definitions(-DWIN_ARM32_DEBUG) #OS_ARCH_TYPE
#		endif()
#		if(RELEASE)
#			add_definitions(-DWIN_ARM32_RELEASE) #OS_ARCH_TYPE
#		endif()
#	endif()
#	if(ARM64) #ARCH
#		add_definitions(-DWIN_ARM64) #OS_ARCH
#		if(DEBUG)
#			add_definitions(-DWIN_ARM64_DEBUG) #OS_ARCH_TYPE
#		endif()
#		if(RELEASE)
#			add_definitions(-DWIN_ARM64_RELEASE) #OS_ARCH_TYPE
#		endif()
#	endif()
#endif()
