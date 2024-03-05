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

include("${DKCMAKE_DIR}/DK.cmake")

# FIXME: work to remove this
if(COMMAND cmake_policy)
	cmake_policy(SET CMP0003 NEW) ##https://cmake.org/cmake/help/latest/policy/CMP0003.html
endif(COMMAND cmake_policy)


###############################################################
## Set variables for paths
###############################################################
dk_set(CURRENT_DIR ${DIGITALKNOB_DIR})

dk_set(CMAKE_SUPPRESS_REGENERATION true)

### Install DKBIN binary directory ###
if(INSTALL_DKLIBS)
	dk_set(CMAKE_INSTALL_PREFIX ${DIGITALKNOB_DIR}/DKBIN)
endif()


###########################################################################
## Set the IDE variable
###########################################################################
if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
	dk_set(GNU ON)
endif()
string(FIND "${CMAKE_GENERATOR}" "Visual Studio" index)
#if(${index} GREATER -1)
#	dk_set(VISUAL_STUDIO ON)
#endif()


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


###########################################################################################
###########################################################################################
## NOTICE ##
## WORK IN PROGRESS ##
## Working to consolidate and remove the need for seperate raspberry pi functions
## The build setup is almost Identicle to linux. We will try to compile Rpi by excluding
## the RASPBERRY flag variables in place of the LINUX functions. In this conversion,
## Raspberry will listen to LINUX x86/64 and RPI x86/64.   The RASPBERRY flags will do nothing
## and we should be able to remove them once everythng is working.

########### Set DK_BINARY_ and DK_PROJECT_ variables ####################
if(CMAKE_BINARY_DIR)
	get_filename_component(CMAKE_BINARY_DIR ${CMAKE_BINARY_DIR} ABSOLUTE)
	dk_debug(CMAKE_BINARY_DIR	PRINTVAR)
	
	### Get DK_BINARY_DIR ###
	dk_set(DK_BINARY_DIR ${CMAKE_BINARY_DIR})
	dk_debug(DK_BINARY_DIR	PRINTVAR)
	
	### Get DK_BINARY_FOLDER ###
	get_filename_component(DK_BINARY_FOLDER ${DK_BINARY_DIR} NAME)     
	dk_debug(DK_BINARY_FOLDER	PRINTVAR)
	
	### Get DK_BINARY_OS_DIR
	### Get DK_BINARY_TYPE ###
	if(${DK_BINARY_DIR} MATCHES "Debug$")
		dk_set(DK_BINARY_TYPE Debug)
		get_filename_component(DK_BINARY_OS_DIR ${DK_BINARY_DIR} DIRECTORY)
	elseif(${DK_BINARY_DIR} MATCHES "Release$")
		dk_set(DK_BINARY_TYPE Release)
		get_filename_component(DK_BINARY_OS_DIR ${DK_BINARY_DIR} DIRECTORY)
	else()
		dk_set(DK_BINARY_OS_DIR ${CMAKE_BINARY_DIR})
	endif()
	dk_debug(DK_BINARY_OS_DIR	PRINTVAR)
	dk_debug(DK_BINARY_TYPE	PRINTVAR)
	
	### Get DK_BINARY_OS_FOLDER
	get_filename_component(DK_BINARY_OS_FOLDER ${DK_BINARY_OS_DIR} NAME)     
	dk_debug(DK_BINARY_OS_FOLDER	PRINTVAR)
	
	dk_set(DK_BINARY_OS ${DK_BINARY_OS_FOLDER})
	### Get DK_BINARY_ENV 
	if(${DK_BINARY_OS} MATCHES "_gcc$")
		dk_set(DK_BINARY_ENV gcc)
		string(REPLACE _gcc "" DK_BINARY_OS "${DK_BINARY_OS}")
	endif()
	if(${DK_BINARY_OS} MATCHES "_clang$")
		dk_set(DK_BINARY_ENV clang)
		string(REPLACE _clang "" DK_BINARY_OS "${DK_BINARY_OS}")
	endif()
	dk_debug(DK_BINARY_ENV	PRINTVAR)
	
	### Get DK_BINARY_ARCH
	if(${DK_BINARY_OS} MATCHES "_arm32$")
		dk_set(DK_BINARY_ARCH arm32)
		string(REPLACE _arm32 "" DK_BINARY_OS "${DK_BINARY_OS}")
	endif()
	if(${DK_BINARY_OS} MATCHES "_arm64$")
		dk_set(DK_BINARY_ARCH arm64)
		string(REPLACE _arm64 "" DK_BINARY_OS "${DK_BINARY_OS}")
	endif()
	if(${DK_BINARY_OS} MATCHES "_x86$")
		dk_set(DK_BINARY_ARCH x86)
		string(REPLACE _x86 "" DK_BINARY_OS "${DK_BINARY_OS}")
	endif()
	if(${DK_BINARY_OS} MATCHES "_x86_64$")
		dk_set(DK_BINARY_ARCH x86_64)
		string(REPLACE _x86_64 "" DK_BINARY_OS "${DK_BINARY_OS}")
	endif()
	dk_debug(DK_BINARY_ARCH	PRINTVAR)
	
	### Get DK_BINARY_OS
	dk_debug(DK_BINARY_OS	PRINTVAR)
	
	
	### Set DK_BINARY_OS_ARCH ###
	dk_set(DK_BINARY_OS_ARCH "${DK_BINARY_OS}_${DK_BINARY_ARCH}")  
	dk_debug(DK_BINARY_OS_ARCH	PRINTVAR)
	
	### Set DK_PROJECT_DIR ###
	get_filename_component(DK_PROJECT_DIR ${DK_BINARY_OS_DIR} DIRECTORY)
	dk_debug(DK_PROJECT_DIR	PRINTVAR)
endif()

### Set OS ###
dk_set(OS "${DK_BINARY_OS_ARCH}")
dk_debug(OS	PRINTVAR)

### Set ${OS} variable ON ##
string(TOUPPER ${DK_BINARY_OS} DK_BINARY_OS_UPPER)
dk_set(${DK_BINARY_OS_UPPER} ON)
dk_debug(${DK_BINARY_OS_UPPER}	PRINTVAR)

### Set ${ARCH} variable ON ##
string(TOUPPER ${DK_BINARY_ARCH} DK_BINARY_ARCH_UPPER)
dk_set(${DK_BINARY_ARCH_UPPER} ON)
dk_debug(${DK_BINARY_ARCH_UPPER}	PRINTVAR)

### Set ${OS_ARCH} variable ON ##
string(TOUPPER ${DK_BINARY_ARCH} DK_BINARY_ARCH_UPPER)
dk_set(${DK_BINARY_OS_UPPER}_${DK_BINARY_ARCH_UPPER} ON)
dk_debug(${DK_BINARY_OS_UPPER}_${DK_BINARY_ARCH_UPPER}	PRINTVAR)

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
dk_debug(DEBUG_DIR	PRINTVAR)
dk_debug(RELEASE_DIR	PRINTVAR)

### Set other OS Specific variables ###
# RPI and RPI32
#if(${DK_BINARY_OS_ARCH} MATCHES "raspberry_arm32")
#	dk_set(RPI ON)
#	dk_set(RPI32 ON)
#	dk_debug(RPI	PRINTVAR)
#	dk_debug(RPI32	PRINTVAR)
#endif()
# RPI and RPI64
#if(${DK_BINARY_OS_ARCH} MATCHES "raspberry_arm64")
#	dk_set(RPI ON)
#	dk_set(RPI64 ON)
#	dk_debug(RPI	PRINTVAR)
#	dk_debug(RPI64	PRINTVAR)
#endif()

# TINYCORE
string(FIND "${CMAKE_HOST_SYSTEM_VERSION}" "tinycore" contains_tinycore)
if(${contains_tinycore} GREATER -1)
	dk_set(TINYCORE ON)
	dk_debug(TINYCORE	PRINTVAR)
endif()	

### Display OS info to user ###
dk_info("*** Creating ${OS} Project Files ***")



### Set CMAKE_SKIP_RPATH ###
dk_set(CMAKE_SKIP_RPATH ON)
dk_debug(CMAKE_SKIP_RPATH	PRINTVAR)






if(NOT CMAKE_SCRIPT_MODE_FILE)
	if(NOT OS)
		dk_debug(CMAKE_BINARY_DIR	PRINTVAR)
		dk_error("The binary directory must contain a valid os folder. \n Valid folders are android_arm32,android_arm64,emscripten,ios_arm32,ios_arm64,iossim_x86,iossim_x86_64,linux_x86,linux_x86_64,mac_x86,mac_x86_64,raspberry_arm32,raspberry_arm64,win_x86,win_x86_64 \n 	EXAMPLE: digitalknob/Development/DKApps/MyApp/win_x86")
		#file(REMOVE ${CMAKE_BINARY_DIR})
	endif()
endif()
