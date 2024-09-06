include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

# This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
#
# For the latest information, see https://github.com/aquawicket/DigitalKnob
#
# Copyright(c) 2010 - 2024 Digitalknob Team, and contributors
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


###############################################################
## Set variables for paths
###############################################################
dk_validate(DIGITALKNOB_DIR  "dk_getDKPaths()")

dk_cd(${DIGITALKNOB_DIR})

dk_set(CMAKE_SUPPRESS_REGENERATION true)

### Install DKBIN binary directory ###
if(INSTALL_DKLIBS)
	dk_set(CMAKE_INSTALL_PREFIX ${DIGITALKNOB_DIR}/DKBIN)
endif()

###########################################################################
## Set the IDE variable
###########################################################################
dk_printVar(CMAKE_C_COMPILER_ID)
dk_printVar(CMAKE_CXX_COMPILER_ID)
dk_printVar(CMAKE_GENERATOR)
dk_printVar(CMAKE_GENERATOR_PLATFORM)

if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
	if(GNU)
		dk_warning("GNU was allready set")
	endif()
	dk_set(GNU 1)

elseif(CMAKE_GENERATOR MATCHES "Visual Studio")
	if(MSVC)
		dk_warning("MSVC was allready set")
	endif()
	dk_set(MSVC 1)

elseif(CMAKE_GENERATOR STREQUAL "MinGW Makefiles")
	if(MINGW)
		dk_warning("MINGW was allready set")
	endif()
	dk_set(MINGW 1)

elseif(CMAKE_GENERATOR STREQUAL "MSYS Makefiles")
	if(MSYS)
		dk_warning("MSYS was allready set")
	endif()
	dk_set(MSYS 1)

elseif(CMAKE_GENERATOR STREQUAL "Xcode")
	if(XCODE)
		dk_warning("XCODE was allready set")
	endif()
	dk_set(XCODE 1)
	
elseif(CMAKE_GENERATOR STREQUAL "Unix Makefiles")
	if(UNIX)
		dk_warning("UNIX was allready set")
	endif()
	dk_set(UNIX 1)
	
else()
	dk_fatal("Could not determin Environment Variable")
endif()

math(EXPR error "${GNU} + ${MSVC} + ${MINGW} + ${MSYS} + ${XCODE} + ${UNIX} - 1" OUTPUT_FORMAT DECIMAL)
if(error)
	dk_fatal("More than one Environment Flags are set")
endif()

###########################################################################
## Get variables for Build Type
###########################################################################
option(DEBUG "Build Debug Output" OFF)
option(RELEASE "Build Release Output" OFF)
if(NOT DEBUG AND NOT RELEASE)
	dk_info("No Build type selected. Defaulting to DEBUG and RELEASE")
	dk_set(DEBUG ON)
	dk_set(RELEASE ON)
endif()


###########################################################################
## Get variables for Build Level
###########################################################################
option(BUILD "Simpily build the app or library" OFF)
option(REBUILD "Rebuild the app" OFF)
option(REBUILDALL "Rebuild the app and all dependencies" ON)
if(NOT BUILD AND NOT REBUILD AND NOT REBUILDALL)
	dk_info("No Build level selected, defaulting to REBUILDALL")
	dk_set(REBUILDALL ON)
endif()


###########################################################################
## Get variables for Library Build Type (STATIC or SHARED)
###########################################################################
option(STATIC "Build Static Libraries and Plugins" OFF)
option(SHARED "Build Shared Libraries and Plugins" OFF)
if(NOT STATIC AND NOT SHARED)
	dk_set(STATIC ON)
endif()


###########################################################################
## Get variables for CEF
###########################################################################
option(DKCEF "Use Chromium Embeded Framework" OFF)
if(${DKCEF} STREQUAL "ON")
	add_definitions(-DHAVE_DKCef)
endif()



###########################################################################
## Get HOST_TRIPLE and TARGET_TRIPLE
###########################################################################
dk_getHostTriple()
dk_getTargetTriple()



########### Determine if we are building a DKApp, DKPlugin or 3rdParty #############
#string(FIND "${CMAKE_BINARY_DIR}" "/DKApps/" index)
#if(${index} GREATER -1)
#	dk_info("Building DKApp . . .")
#	dk_set(DKAPP ON)
#	dk_printVar(DKAPP)
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
dk_getTargetTriple()


### Set other OS Specific variables ###
# RPI and RPI32
#if(DK_BINARY_OS_ARCH MATCHES "raspberry_arm32")
#	dk_set(RPI ON)
#	dk_set(RPI32 ON)
#	dk_printVar(RPI)
#	dk_printVar(RPI32)
#endif()
# RPI and RPI64
#if(DK_BINARY_OS_ARCH MATCHES "raspberry_arm64")
#	dk_set(RPI ON)
#	dk_set(RPI64 ON)
#	dk_printVar(RPI)
#	dk_printVar(RPI64)
#endif()

# TINYCORE
if(CMAKE_HOST_SYSTEM_VERSION)
	string(FIND "${CMAKE_HOST_SYSTEM_VERSION}" "tinycore" contains_tinycore)
	if(${contains_tinycore} GREATER -1)
		dk_set(TINYCORE ON)
	endif()
endif()

### Display OS info to user ###
dk_info("")
dk_info("")
dk_info("*** Creating ${triple} Project Files ***")
dk_info("")


### Set CMAKE_SKIP_RPATH ###
dk_set(CMAKE_SKIP_RPATH ON)

if(WIN_HOST)
	dk_set(exe .exe)
	dk_set(bat .bat)
endif()





if(NOT CMAKE_SCRIPT_MODE_FILE)
	#if(NOT OS)
	if(NOT TARGET_OS)
		#dk_printVar(CMAKE_BINARY_DIR)	
		dk_error("The binary directory must contain a valid os folder. \n Valid folders are android_arm32,android_arm64,emscripten,ios_arm32,ios_arm64,iossim_x86,iossim_x86_64,linux_x86,linux_x86_64,mac_x86,mac_x86_64,raspberry_arm32,raspberry_arm64,win_x86,win_x86_64 \n 	EXAMPLE: digitalknob/Development/DKApps/MyApp/win_x86")
		#dk_delete(${CMAKE_BINARY_DIR})
	endif()
endif()
