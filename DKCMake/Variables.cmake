# This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
#
# For the latest information, see https://github.com/aquawicket/DigitalKnob
#
# Copyright(c) 2010 - 2022 Digitalknob Team, and contributors
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files(the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions :
#
# The above copyright noticeand this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

include_guard()

# FIXME: work to remove this
if(COMMAND cmake_policy)
	cmake_policy(SET CMP0003 NEW) ##https://cmake.org/cmake/help/latest/policy/CMP0003.html
endif(COMMAND cmake_policy)

###############################################################
## Set variables for paths
###############################################################
dk_file_getDigitalknobPath(DIGITALKNOB)
DKSET(DKCMAKE ${DIGITALKNOB}/DK/DKCMake)
DKSET(DKPLUGINS ${DIGITALKNOB}/DK/DKPlugins)
DKSET(3RDPARTY ${DIGITALKNOB}/DK/3rdParty)
DKSET(DKIMPORTS ${3RDPARTY}/_DKIMPORTS)
DKSET(DKDOWNLOAD ${DIGITALKNOB}/Download)
DKSET(DKWEB "http://127.0.0.1")
DKSET(CURRENT_DIR ${DIGITALKNOB})

DKSET(CMAKE_SUPPRESS_REGENERATION true)

### INSTALL DBIN ###
DKSET(INSTALL_DKLIBS 0)
if(INSTALL_DKLIBS)
	DKSET(CMAKE_INSTALL_PREFIX ${DIGITALKNOB}/DKBIN)
endif()


###########################################################################
## Bulid the TARGET passed from the command line
###########################################################################
if(TARGET)
	DKINFO("Building ${TARGET}\n")
	dk_FindTarget("${TARGET}" target_path target_type)
	if(NOT target_path)
		DKINFO("ERROR: Could not find target ${TARGET}")
		Wait("press any key to exit")
		dk_exit()
	endif()
	DKINFO("found ${TARGET}:(${target_type}) at ${target_path}")
	DKSET(BYPASS_DISABLE ON)
	DKSET(QUEUE_BUILD ON)
	WIN_DKDEPEND(visualstudio)
	#if(NOT "${target_type}" STREQUAL "DKAPP")
	#	DKDEPEND(${TARGET})
	#else()
		project(${TARGET})
		DKSET(DKAPP 1)
		file(WRITE ${DKCMAKE}/temp/${TARGET}.cmd "\"${MSBUILD}\" ${CMAKE_BINARY_DIR}/DigitalKnob.sln /p:Configuration=Release\n")
		file(APPEND ${DKCMAKE}/temp/${TARGET}.cmd "${CMAKE_BINARY_DIR}/${RELEASE_DIR}/${TARGET}.exe")
	#endif()
endif()


###########################################################################
## Get variables for Build Type
###########################################################################
option(DEBUG "Build Debug Output" ON)
option(RELEASE "Build Release Output" ON)
if(NOT DEBUG)
if(NOT RELEASE)
	DKINFO("No Build type selected. Defaulting to DEBUG and RELEASE")
	DKSET(DEBUG ON)
	DKSET(RELEASE ON)
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
	DKINFO("No Build level selected, defaulting to REBUILDALL")
	DKSET(REBUILDALL ON)
endif()
endif()
endif()


###########################################################################
## Get variables for Library Build Type (STATIC or SHARED)
###########################################################################
option(STATIC "Build Static Libraries and Plugins" OFF)
option(SHARED "Build SHARED Libraries and Plugins" OFF)
if(NOT STATIC)
if(NOT SHARED)
	DKSET(STATIC ON)
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
#	DKINFO("Building DKApp . . .")
#	DKSET(DKAPP ON)
#	add_definitions(-DDKAPP)
#endif()
#string(FIND "${CMAKE_BINARY_DIR}" "/DKPlugin/" index)
#if(${index} GREATER -1)
#	DKINFO("Building DKPlugin . . .")
#endif()
#string(FIND "${CMAKE_BINARY_DIR}" "/3rdParty/" index)
#if(${index} GREATER -1)
#	DKINFO("Building 3rdParty . . .")
#endif()


########### Determine the OS we are building for ####################
string(FIND "${CMAKE_BINARY_DIR}" "/win32" index)
if(${index} GREATER -1)
	DKINFO("Creating Windows x32 Project Files")
	DKSET(WIN ON)
	DKSET(WIN_32 ON)
	DKSET(OS "win32")
	DKSET(DEBUG_DIR Debug)
	DKSET(RELEASE_DIR Release)
	DKSET(CMAKE_SKIP_RPATH ON)
	string(REPLACE "/win32" "" DKPROJECT ${CMAKE_BINARY_DIR})
endif()
string(FIND "${CMAKE_BINARY_DIR}" "/win64" index)
if(${index} GREATER -1)
	DKINFO("*** Creating Windows x64 Project Files ***")
	DKSET(WIN ON)
	DKSET(WIN_64 ON)
	DKSET(OS "win64")
	DKSET(DEBUG_DIR Debug)
	DKSET(RELEASE_DIR Release)
	DKSET(CMAKE_SKIP_RPATH ON)
	string(REPLACE "/win64" "" DKPROJECT ${CMAKE_BINARY_DIR})
endif()
string(FIND "${CMAKE_BINARY_DIR}" "/mac32" index)
if(${index} GREATER -1)
	DKINFO("*** Creating Mac x32 Project Files ***")
	DKSET(MAC ON)
	DKSET(MAC_32 ON)
	DKSET(OS "mac32")
	DKSET(DEBUG_DIR Debug)
	DKSET(RELEASE_DIR Release)
	DKSET(CMAKE_SKIP_RPATH ON)
	string(REPLACE "/mac32" "" DKPROJECT ${CMAKE_BINARY_DIR})
endif()
string(FIND "${CMAKE_BINARY_DIR}" "/mac64" index)
if(${index} GREATER -1)
	DKINFO("*** Creating Mac x64 Project Files ***")
	DKSET(MAC ON)
	DKSET(MAC_64 ON)
	DKSET(OS "mac64")
	DKSET(DEBUG_DIR Debug)
	DKSET(RELEASE_DIR Release)
	DKSET(CMAKE_SKIP_RPATH ON)
	string(REPLACE "/mac64" "" DKPROJECT ${CMAKE_BINARY_DIR})
endif()
string(FIND "${CMAKE_BINARY_DIR}" "/ios32" index)
if(${index} GREATER -1)
	DKINFO("*** Creating iOS x32 Project Files ***")
	DKSET(IOS ON)
	DKSET(IOS_32 ON)
	DKSET(OS "ios32")
	DKSET(DEBUG_DIR Debug-iphoneos)
	DKSET(RELEASE_DIR Release-iphoneos)
	DKSET(CMAKE_SKIP_RPATH ON)
	string(REPLACE "/ios32" "" DKPROJECT ${CMAKE_BINARY_DIR})
endif()
string(FIND "${CMAKE_BINARY_DIR}" "/ios64" index)
if(${index} GREATER -1)
	DKINFO("*** Creating iOS x64 Project Files ***")
	DKSET(IOS ON)
	DKSET(IOS_64 ON)
	DKSET(OS "ios64")
	DKSET(DEBUG_DIR Debug-iphoneos)
	DKSET(RELEASE_DIR Release-iphoneos)
	DKSET(CMAKE_SKIP_RPATH ON)
	string(REPLACE "/ios64" "" DKPROJECT ${CMAKE_BINARY_DIR})
endif()
string(FIND "${CMAKE_BINARY_DIR}" "/iossim32" index)
if(${index} GREATER -1)
	DKINFO("*** Creating iOS-Simulator x32 Project Files ***")
	DKSET(IOSSIM ON)
	DKSET(IOSSIM_32 ON)
	DKSET(OS "iossim32")
	DKSET(DEBUG_DIR Debug-iphonesimulator)
	DKSET(RELEASE_DIR Release-iphonesimulator)
	DKSET(CMAKE_SKIP_RPATH ON)
	string(REPLACE "/iossim32" "" DKPROJECT ${CMAKE_BINARY_DIR})
endif()
string(FIND "${CMAKE_BINARY_DIR}" "/iossim64" index)
if(${index} GREATER -1)
	DKINFO("*** Creating iOS-Simulator x64 Project Files ***")
	DKSET(IOSSIM ON)
	DKSET(IOSSIM_64 ON)
	DKSET(OS "iossim64")
	DKSET(DEBUG_DIR Debug-iphonesimulator)
	DKSET(RELEASE_DIR Release-iphonesimulator)
	DKSET(CMAKE_SKIP_RPATH ON)
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
string(FIND "${CMAKE_BINARY_DIR}" "/raspberry32" index)
if(${index} GREATER -1)
	DKINFO("*** Creating RASPBERRY x32 Project Files ***")
	DKSET(RASPBERRY ON)     #To be disabled
	DKSET(RASPBERRY_32 ON)  #To be disabled
	#DKSET(LINUX ON)
	#DKSET(LINUX32 ON)
	DKSET(RPI ON)
	DKSET(RPI32 ON)
	DKSET(OS "raspberry32")
	DKSET(DEBUG_DIR Debug)
	DKSET(RELEASE_DIR Release)
	string(REPLACE "/raspberry32" "" DKPROJECT ${CMAKE_BINARY_DIR})
endif()
string(FIND "${CMAKE_BINARY_DIR}" "/raspberry64" index)
if(${index} GREATER -1)
	DKINFO("*** Creating Raspberry x64 Project Files ***")
	DKSET(RASPBERRY ON)     #To be disabled
	DKSET(RASPBERRY_64 ON)  #To be disabled
	#DKSET(LINUX ON)
	#DKSET(LINUX64 ON)
	DKSET(RPI ON)
	DKSET(RPI64 ON)
	DKSET(OS "raspberry64")
	DKSET(DEBUG_DIR Debug)
	DKSET(RELEASE_DIR Release)
	string(REPLACE "/raspberry64" "" DKPROJECT ${CMAKE_BINARY_DIR})
endif()
#########################################################################################
#########################################################################################



string(FIND "${CMAKE_BINARY_DIR}" "/linux32" index)
if(${index} GREATER -1)
if(NOT RASPBERRY)
if(NOT RPI)
	DKINFO("*** Creating Linux x32 Project Files ***")
	DKSET(LINUX ON)
	DKSET(LINUX_32 ON)
	DKSET(OS "linux32")
	DKSET(DEBUG_DIR Debug)
	DKSET(RELEASE_DIR Release)
	string(REPLACE "/linux32" "" DKPROJECT ${CMAKE_BINARY_DIR})
endif()
endif()
endif()
string(FIND "${CMAKE_BINARY_DIR}" "/linux64" index)
if(${index} GREATER -1)
if(NOT RASPBERRY)
if(NOT RPI)
	DKINFO("*** Creating Linux x64 Project Files ***")
	DKSET(LINUX ON)
	DKSET(LINUX_64 ON)
	DKSET(OS "linux64")
	DKSET(DEBUG_DIR Debug)
	DKSET(RELEASE_DIR Release)
	string(REPLACE "/linux64" "" DKPROJECT ${CMAKE_BINARY_DIR})
endif()
endif()
endif()





string(FIND "${CMAKE_BINARY_DIR}" "/android32" index)
if(${index} GREATER -1)
	DKINFO("*** Creating Android x32 Project Files ***")
	DKSET(ANDROID ON)
	DKSET(ANDROID_32 ON)
	DKSET(OS "android32")
	DKSET(DEBUG_DIR Debug)
	DKSET(RELEASE_DIR Release)
	DKSET(CMAKE_SKIP_RPATH ON)
	string(REPLACE "/android32" "" DKPROJECT ${CMAKE_BINARY_DIR})
endif()
string(FIND "${CMAKE_BINARY_DIR}" "/android64" index)
if(${index} GREATER -1)
	DKINFO("*** Creating Android x64 Project Files ***")
	DKSET(ANDROID ON)
	DKSET(ANDROID_64 ON)
	DKSET(OS "android64")
	DKSET(DEBUG_DIR Debug)
	DKSET(RELEASE_DIR Release)
	DKSET(CMAKE_SKIP_RPATH ON)
	string(REPLACE "/android64" "" DKPROJECT ${CMAKE_BINARY_DIR})
endif()

if(NOT CMAKE_SCRIPT_MODE_FILE)
	if(NOT OS)
		DKINFO("CMAKE_BINARY_DIR = ${CMAKE_BINARY_DIR}")
		DKERROR("The binary directory must contain an os folder. \n Valid folders are win32,win64,mac32,mac64,linux32,linux64,ios32,ios64,iossim32,iossim64,android32,android64,raspberry32 or raspberry64 \n 	EXAMPLE: digitalknob/DKApps/MyApp/win32")
		#DKREMOVE(${CMAKE_BINARY_DIR})
	endif()

	## we use /Debug and /Release folders for Linux, Android and Raspberry
	## if they are present, remove them and let DEBUG and RELEASE flags deal with that later.
	string(REPLACE "/Debug" "" DKPROJECT ${DKPROJECT})
	string(REPLACE "/Release" "" DKPROJECT ${DKPROJECT})
endif()


## NEW STYLE
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
