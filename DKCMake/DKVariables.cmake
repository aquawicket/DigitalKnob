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

include("${DKCMAKE}/DK.cmake")

# FIXME: work to remove this
if(COMMAND cmake_policy)
	cmake_policy(SET CMP0003 NEW) ##https://cmake.org/cmake/help/latest/policy/CMP0003.html
endif(COMMAND cmake_policy)


###############################################################
## Set variables for paths
###############################################################
dk_set(DKPLUGINS ${DKBRANCH}/DKPlugins)
dk_set(3RDPARTY ${DKBRANCH}/3rdParty)
dk_set(DKIMPORTS ${3RDPARTY}/_DKIMPORTS)
dk_set(DKDOWNLOAD ${DIGITALKNOB}/download)
dk_set(DKWEB "http://127.0.0.1")
dk_set(CURRENT_DIR ${DIGITALKNOB})

dk_set(CMAKE_SUPPRESS_REGENERATION true)

### Install DKBIN binary directory ###
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

	#WIN_dk_depend(visualstudio)
	#if(NOT "${target_type}" STREQUAL "DKAPP")
	#	dk_depend(${TARGET})
	#else()
		project(${TARGET})
		dk_set(DKAPP 1)
		#file(WRITE ${DKCMAKE}/temp/${TARGET}.cmd "\"${MSBUILD}\" ${CMAKE_BINARY_DIR}/DigitalKnob.sln /p:Configuration=Debug\n")
		#file(WRITE ${DKCMAKE}/temp/${TARGET}.cmd "%CMAKE_COMMAND%" --build %TARGET_PATH%\%TARGET_OS%\Debug --target ${TARGET} --config Debug --verbose
		#file(APPEND ${DKCMAKE}/temp/${TARGET}.cmd "${CMAKE_BINARY_DIR}/${RELEASE_DIR}/${TARGET}.exe")
	#endif()
endif()


###########################################################################
## Set the IDE variable
###########################################################################
if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
	dk_set(GNU ON)
endif()
string(FIND "${CMAKE_GENERATOR}" "Visual Studio" index)
if(${index} GREATER -1)
	dk_set(VISUAL_STUDIO ON)
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
option(REBUILDALL "Rebuild the app and all dependencies" ON)
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


########### Set DK_BINARY_ and DK_PROJECT_ variables ####################
if(CMAKE_BINARY_DIR)
	dk_debug("CMAKE_BINARY_DIR = ${CMAKE_BINARY_DIR}")
	
	### Set DK_BINARY_DIR ###
	dk_set(DK_BINARY_DIR ${CMAKE_BINARY_DIR})
	dk_debug("DK_BINARY_DIR = ${DK_BINARY_DIR}")
	
	### Set DK_BINARY_OSARCH_DIR ###
	if(${CMAKE_BINARY_DIR} MATCHES "Debug$")
		get_filename_component(DK_BINARY_OSARCH_DIR ${CMAKE_BINARY_DIR} DIRECTORY)
	elseif(${CMAKE_BINARY_DIR} MATCHES "Release$")
		get_filename_component(DK_BINARY_OSARCH_DIR ${CMAKE_BINARY_DIR} DIRECTORY)
	else()
		dk_set(DK_BINARY_OSARCH_DIR ${DK_BINARY_DIR})
	endif()
	dk_debug("DK_BINARY_OSARCH_DIR = ${DK_BINARY_OSARCH_DIR}")
	
	### Set DK_BINARY_OSARCH ###
	get_filename_component(DK_BINARY_OSARCH ${DK_BINARY_OSARCH_DIR} NAME)     
	dk_debug("DK_BINARY_OSARCH = ${DK_BINARY_OSARCH}")
	
	### Set DK_BINARY_OS ###
	string(FIND "${DK_BINARY_OSARCH}" "_" first_underscore)
	string(SUBSTRING "${DK_BINARY_OSARCH}" 0 ${first_underscore} DK_BINARY_OS)
	dk_debug("DK_BINARY_OS = ${DK_BINARY_OS}")
	
	### Set DK_BINARY_ARCH ###
	string(FIND "${DK_BINARY_OSARCH}" "_" first_underscore)
	math(EXPR after_underscore "${first_underscore}+1" OUTPUT_FORMAT DECIMAL)
	string(SUBSTRING "${DK_BINARY_OSARCH}" ${after_underscore} -1 DK_BINARY_ARCH)
	dk_debug("DK_BINARY_ARCH = ${DK_BINARY_ARCH}")
	
	### Set DK_PROJECT_DIR ###
	get_filename_component(DK_PROJECT_DIR ${DK_BINARY_OSARCH_DIR} DIRECTORY)
	dk_debug("DK_PROJECT_DIR = ${DK_PROJECT_DIR}")
endif()


### Set OS ###
dk_set(OS "${DK_BINARY_OSARCH}")
dk_debug("OS = ${OS}")

### Set ${OS} variable ON ##
string(TOUPPER ${DK_BINARY_OS} DK_BINARY_OS_UPPER)
dk_set(${DK_BINARY_OS_UPPER} ON)
dk_debug("${DK_BINARY_OS_UPPER} = ${${DK_BINARY_OS_UPPER}}")

### Set ${ARCH} variable ON ##
string(TOUPPER ${DK_BINARY_ARCH} DK_BINARY_ARCH_UPPER)
dk_set(${DK_BINARY_ARCH_UPPER} ON)
dk_debug("${DK_BINARY_ARCH_UPPER} = ${${DK_BINARY_ARCH_UPPER}}")

### Set ${OS_ARCH} variable ON ##
string(TOUPPER ${DK_BINARY_ARCH} DK_BINARY_ARCH_UPPER)
dk_set(${DK_BINARY_OS_UPPER}_${DK_BINARY_ARCH_UPPER} ON)
dk_debug("${DK_BINARY_OS_UPPER}_${DK_BINARY_ARCH_UPPER} = ${${DK_BINARY_OS_UPPER}_${DK_BINARY_ARCH_UPPER}}")

### Set DEBUG_DIR and RELEASE_DIR variables
if(${DK_BINARY_OS} MATCHES "ios")
	dk_set(DEBUG_DIR Debug-iphoneos)
	dk_set(RELEASE_DIR Release-iphoneos)
elseif(${DK_BINARY_OS} MATCHES "iossim")
	dk_set(DEBUG_DIR Debug-iphonesimulator)
	dk_set(RELEASE_DIR Release-iphonesimulator)
else()
	dk_set(DEBUG_DIR Debug)
	dk_set(RELEASE_DIR Release)
endif()
dk_debug("DEBUG_DIR = ${DEBUG_DIR}")
dk_debug("RELEASE_DIR = ${RELEASE_DIR}")

### Set other OS Specific variables ###
# RPI and RPI32
if(${DK_BINARY_OSARCH} MATCHES "raspberry_arm32")
	dk_set(RPI ON)
	dk_set(RPI32 ON)
	dk_debug("RPI = ${RPI}")
	dk_debug("RPI32 = ${RPI32}")
endif()
# RPI and RPI64
if(${DK_BINARY_OSARCH} MATCHES "raspberry_arm64")
	dk_set(RPI ON)
	dk_set(RPI64 ON)
	dk_debug("RPI = ${RPI}")
	dk_debug("RPI64 = ${RPI64}")
endif()
# TINYCORE
string(FIND "${CMAKE_HOST_SYSTEM_VERSION}" "tinycore" contains_tinycore)
if(${contains_tinycore} GREATER -1)
	dk_set(TINYCORE ON)
	dk_debug("TINYCORE = ${TINYCORE}")
endif()	

### Display OS info to user ###
dk_info("*** Creating ${OS} Project Files ***")



### Set CMAKE_SKIP_RPATH ###
dk_set(CMAKE_SKIP_RPATH ON)
dk_debug("CMAKE_SKIP_RPATH = ${CMAKE_SKIP_RPATH}")





# android_arm32
#if(${DK_BINARY_OS_DIR} MATCHES "android_arm32$")
	#dk_info("*** Creating Android x32 Project Files ***")
	#dk_set(ANDROID ON)
	#dk_set(ANDROID_ARM32 ON)
	#dk_set(OS "android_arm32")
	#dk_set(DEBUG_DIR Debug)
	#dk_set(RELEASE_DIR Release)
	#dk_set(CMAKE_SKIP_RPATH ON)
#endif()

# android_arm64
#if(${DK_BINARY_OS_DIR} MATCHES "android_arm64$")
	#dk_info("*** Creating Android x64 Project Files ***")
	#dk_set(ANDROID ON)
	#dk_set(ANDROID_ARM64 ON)
	#dk_set(OS "android_arm64")
	#dk_set(DEBUG_DIR Debug)
	#dk_set(RELEASE_DIR Release)
	#dk_set(CMAKE_SKIP_RPATH ON)
#endif()

# emscripten
#if(${DK_BINARY_OS_DIR} MATCHES "emscripten$")
	#dk_info("*** Creating Emscripten Project Files ***")
	#dk_set(EMSCRIPTEN ON)
	#dk_set(OS "emscripten")
	#dk_set(DEBUG_DIR Debug)
	#dk_set(RELEASE_DIR Release)
#endif()

# ios_arm32
#if(${DK_BINARY_OS_DIR} MATCHES "ios_arm32$")
	#dk_info("*** Creating iOS x32 Project Files ***")
	#dk_set(IOS ON)
	#dk_set(IOS_ARM32 ON)
	#dk_set(OS "ios_arm32")
	#dk_set(DEBUG_DIR Debug-iphoneos)
	#dk_set(RELEASE_DIR Release-iphoneos)
	#dk_set(CMAKE_SKIP_RPATH ON)
#endif()

# ios_arm64
#if(${DK_BINARY_OS_DIR} MATCHES "ios_arm64$")
	#dk_info("*** Creating iOS x64 Project Files ***")
	#dk_set(IOS ON)
	#dk_set(IOS_ARM64 ON)
	#dk_set(OS "ios_arm64")
	#dk_set(DEBUG_DIR Debug-iphoneos)
	#dk_set(RELEASE_DIR Release-iphoneos)
	#dk_set(CMAKE_SKIP_RPATH ON)
#endif()

# iossim_x86
#if(${DK_BINARY_OS_DIR} MATCHES "iossim_x86_64$")
	#dk_info("*** Creating iOS-Simulator x32 Project Files ***")
	#dk_set(IOSSIM ON)
	#dk_set(IOSSIM_X86 ON)
	#dk_set(OS "iossim_x86")
	#dk_set(DEBUG_DIR Debug-iphonesimulator)
	#dk_set(RELEASE_DIR Release-iphonesimulator)
	#dk_set(CMAKE_SKIP_RPATH ON)
#endif()

# iossim_x86_64
#if(${DK_BINARY_OS_DIR} MATCHES "iossim_x86_64$")
	#dk_info("*** Creating iOS-Simulator x64 Project Files ***")
	#dk_set(IOSSIM ON)
	#dk_set(IOSSIM_X86_64 ON)
	#dk_set(OS "iossim_x86_64")
	#dk_set(DEBUG_DIR Debug-iphonesimulator)
	#dk_set(RELEASE_DIR Release-iphonesimulator)
	#dk_set(CMAKE_SKIP_RPATH ON)
#endif()

# linux_x86
#if(${DK_BINARY_OS_DIR} MATCHES "linux_x86$")
#	if(NOT RASPBERRY)
#	if(NOT RPI)
		#dk_info("*** Creating Linux x32 Project Files ***")
		#dk_set(LINUX ON)
		#dk_set(LINUX_X86 ON)
		#dk_set(OS "linux_x86")
		#dk_set(DEBUG_DIR Debug)
		#dk_set(RELEASE_DIR Release)
#	endif()
#	endif()
#endif()

# linux_x86_64
#if(${DK_BINARY_OS_DIR} MATCHES "linux_x86_64$")
#	if(NOT RASPBERRY)
#	if(NOT RPI)
		#dk_info("*** Creating Linux x64 Project Files ***")
		#dk_set(LINUX ON)
		#dk_set(LINUX_X86_64 ON)
		#dk_set(OS "linux_x86_64")
		#dk_set(DEBUG_DIR Debug)
		#dk_set(RELEASE_DIR Release)
#	endif()
#	endif()
#endif()

# mac_x86
#if(${DK_BINARY_OS_DIR} MATCHES "mac_x86$")
	#dk_info("*** Creating Mac x32 Project Files ***")
	#dk_set(MAC ON)
	#dk_set(MAC_X86 ON)
	#dk_set(OS "mac_x86")
	#dk_set(DEBUG_DIR Debug)
	#dk_set(RELEASE_DIR Release)
	#dk_set(CMAKE_SKIP_RPATH ON)
#endif()

# mac_x86_64
#if(${DK_BINARY_OS_DIR} MATCHES "mac_x86_64$")
	#dk_info("*** Creating Mac x64 Project Files ***")
	#dk_set(MAC ON)
	#dk_set(MAC_X86_64 ON)
	#dk_set(OS "mac_x86_64")
	#dk_set(DEBUG_DIR Debug)
	#dk_set(RELEASE_DIR Release)
	#dk_set(CMAKE_SKIP_RPATH ON)
#endif()

###########################################################################################
###########################################################################################
## NOTICE ##
## WORK IN PROGRESS ##
## Working to consolidate and remove the need for seperate raspberry pi functions
## The build setup is almost Identicle to linux. We will try to compile Rpi by excluding
## the RASPBERRY flag variables in place of the LINUX functions. In this conversion,
## Raspberry will listen to LINUX x86/64 and RPI x86/64.   The RASPBERRY flags will do nothing
## and we should be able to remove them once everythng is working.

# raspberry_arm32
#if(${DK_BINARY_OS_DIR} MATCHES "raspberry_arm32$")
	#dk_info("*** Creating RASPBERRY x32 Project Files ***")
	#dk_set(RASPBERRY ON)     #To be disabled
	#dk_set(RASPBERRY_ARM32 ON)  #To be disabled
	#dk_set(LINUX ON)
	#dk_set(RPI ON)
	#dk_set(RPI32 ON)
	#dk_set(OS "raspberry_arm32")
	#dk_set(DEBUG_DIR Debug)
	#dk_set(RELEASE_DIR Release)
#endif()

# raspberry_arm64
#if(${DK_BINARY_OS_DIR} MATCHES "raspberry_arm64$")
	#dk_info("*** Creating Raspberry x64 Project Files ***")
	#dk_set(RASPBERRY ON)     #To be disabled
	#dk_set(RASPBERRY_ARM64 ON)  #To be disabled
	#dk_set(LINUX ON)
	#dk_set(RPI ON)
	#dk_set(RPI64 ON)
	#dk_set(OS "raspberry_arm64")
	#dk_set(DEBUG_DIR Debug)
	#dk_set(RELEASE_DIR Release)
#endif()
#########################################################################################
#########################################################################################

# TINYCORE
#string(FIND "${CMAKE_HOST_SYSTEM_VERSION}" "tinycore" index)
#if(${index} GREATER -1)
#	dk_info("Detected tinycore OS")
#	dk_set(TINYCORE ON)
#endif()	
	
# win_x86
#if(${DK_BINARY_OS_DIR} MATCHES "win_x86$")
	#dk_info("Creating Windows x32 Project Files")
	#dk_set(WIN ON)
	#dk_set(WIN_X86 ON)
	#dk_set(OS "win_x86")
	#dk_set(DEBUG_DIR Debug)
	#dk_set(RELEASE_DIR Release)
	#dk_set(CMAKE_SKIP_RPATH ON)
#endif()

# win_x86_64
#if(${DK_BINARY_OS_DIR} MATCHES "win_x86_64$")
	#dk_info("*** Creating Windows x64 Project Files ***")
	#dk_set(WIN ON)
	#dk_set(WIN_X86_64 ON)
	#dk_set(OS "win_x86_64")
	#dk_set(DEBUG_DIR Debug)
	#dk_set(RELEASE_DIR Release)
	#dk_set(CMAKE_SKIP_RPATH ON)
#endif()





if(NOT CMAKE_SCRIPT_MODE_FILE)
	if(NOT OS)
		#dk_error(CMAKE_BINARY_DIR)
		dk_error("The binary directory must contain a valid os folder. \n Valid folders are android_arm32,android_arm64,emscripten,ios_arm32,ios_arm64,iossim_x86,iossim_x86_64,linux_x86,linux_x86_64,mac_x86,mac_x86_64,raspberry_arm32,raspberry_arm64,win_x86,win_x86_64 \n 	EXAMPLE: digitalknob/Development/DKApps/MyApp/win_x86")
		#file(REMOVE ${CMAKE_BINARY_DIR})
	endif()
endif()
