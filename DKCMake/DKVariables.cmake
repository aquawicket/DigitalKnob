#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
include_guard()

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
dk_info("****** LOADING: ${CMAKE_CURRENT_LIST_FILE} ******")


if(CMAKE_SCRIPT_MODE_FILE)
	dk_info("")
	dk_info("##################################################")
	dk_info("################# SCRIPT MODE ####################")
	dk_info("##################################################")
	dk_info("")
endif()

#################### GLOBAL DKCMake SETTINGS ############################
dk_set(DKOFFLINE					0) 	# work offline. No Git remote commands or downloading files
dk_set(BACKUP_APP_EXECUTABLES		1)	# backup previous app executable when rebuilding
dk_set(BACKUP_APP_USER_DATA			0)	# preserve assets/USER folder when building
dk_set(BYPASS_DISABLE				0)	# bypass dk_disable() commands
#dk_set(DKDEBUGFUNC_ENABLED			0)	# enable DKDEBUGFUNC() function to print function calls
dk_set(PRINT_DKRETURNS				0)	# dk_return() will print the current cmake file
dk_set(DELETE_DOWNLOADS				0)  # delete downloads after they are extracted or installed
#dk_set(ENABLE_dk_todo				1)	# enable dk_todo() functions
#dk_set(ENABLE_dk_debug				1)	# enable dk_debug() functions
#dk_set(ENABLE_dk_verbose			1)	# enable dk_verbose() functions
#dk_set(CONTINUE_ON_ERRORS			1)	# don't halt cmake build script on errors
#dk_set(HALT_ON_WARNINGS			0)	# halt cmake build script on warnings
dk_set(INSTALL_DKLIBS          		1)	# install header files and libraries to DKBIN directory
dk_set(MAC_TERMINAL_WRAPPER     	1)	# open app with terminal
dk_set(PRINT_CALL_DETAILS 			0)	# print function call details
dk_set(PRINT_FILE_NAMES 			0)	# print function call file names
dk_set(PRINT_FUNCTION_ARGUMENTS 	0)	# print function call arguments
dk_set(PRINT_FUNCTION_NAMES 		0)	# print function call function names
dk_set(PRINT_LINE_NUMBERS 			0)	# print function call file line numbers
dk_set(PAUSE_ON_ERRORS				0)	# pause cmake build script on errors
dk_set(WAIT_ON_WARNINGS				0)	# pause cmake build script on warnings
dk_set(USE_COLOR					1)	# colored text output
dk_set(PROJECT_INCLUDE_DKPLUGINS	1)  # Include DKPlugin libraries in the app project
dk_set(PROJECT_INCLUDE_3RDPARTY		0)  # Include 3rdParty libraries in the app project


###### DKOFFLINE Warning ######
if(${DKOFFLINE})
	dk_notice("!!!!!!!!!! WORKING IN DKOFFLINE MODE !!!!!!!!!")
endif()

###### Get WORKING_DIRECTORY ######
#if(NOT PWD)
#	dk_getFullPath(${CMAKE_CURRENT_SOURCE_DIR} PWD)
#endif()
	
if(NOT CMAKE_SCRIPT_MODE_FILE)
	###### Get CMAKE_SOURCE_DIR ######
	dk_assertVar(CMAKE_SOURCE_DIR)
	dk_getFullPath(${CMAKE_SOURCE_DIR} CMAKE_SOURCE_DIR)
	dk_assertPath(CMAKE_SOURCE_DIR)

	###### Get CMAKE_BINARY_DIR ######
	dk_assertVar(CMAKE_BINARY_DIR)
	dk_getFullPath(${CMAKE_BINARY_DIR} CMAKE_BINARY_DIR)
	dk_assertPath(CMAKE_BINARY_DIR)
endif()


if(DEFINED "ENV{COSMO}")
	dk_set(COSMO "$ENV{COSMO}")
	dk_set(cosmo "cosmo")
endif()
if(COSMO)
	message(COSMO)
	#dk_set(CMAKE_HOST_SYSTEM_NAME "COSMOS")
	#dk_set(CMAKE_HOST_UNIX 1)
	#dk_unset(CMAKE_HOST_WIN32)
	#dk_unset(CMAKE_HOST_APPLE)
	#dk_unset(WIN32)
endif()


###### Set MSYSTEM and ${MSYSTEM} variables ######
if(DEFINED "ENV{MSYSTEM}")
	dk_set(MSYSTEM "$ENV{MSYSTEM}")		
endif()
if(MSYSTEM)
	dk_set(${MSYSTEM} TRUE)
	message(MSYSTEM)
endif()


############ Get Host Variables ############
dk_validate(host_triple   "dk_host_triple()")

############ Get Target Variables ############
dk_validate(CONFIG_PATH   "dk_CONFIG_PATH()")

###############################################################
## Set variables for paths
###############################################################
dk_validate(DIGITALKNOB_DIR  "dk_DIGITALKNOB_DIR()")

dk_cd(${DIGITALKNOB_DIR})

dk_set(CMAKE_SUPPRESS_REGENERATION true)

### Install DKBIN binary directory ###
if(INSTALL_DKLIBS)
	dk_set(CMAKE_INSTALL_PREFIX ${DIGITALKNOB_DIR}/DKBIN)
endif()


dk_haveLongPaths(longPaths)
dk_printVar(longPaths)

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
	message(GNU)
	
elseif(CMAKE_GENERATOR MATCHES "Visual Studio")
	if(MSVC)
		dk_warning("MSVC was allready set")
	endif()
	dk_set(MSVC 1)
	message(MSVC)
	
elseif(CMAKE_GENERATOR STREQUAL "MinGW Makefiles")
	if(MINGW)
		dk_warning("MINGW was allready set")
	endif()
	dk_set(MINGW 1)
	message(MINGW)
	
elseif(CMAKE_GENERATOR STREQUAL "MSYS Makefiles")
	if(MSYS)
		dk_warning("MSYS was allready set")
	endif()
	dk_set(MSYS 1)
	message(MSYS)
	
elseif(CMAKE_GENERATOR STREQUAL "Xcode")
	if(XCODE)
		dk_warning("XCODE was allready set")
	endif()
	dk_set(XCODE 1)
	message(XCODE)
	
elseif(CMAKE_GENERATOR STREQUAL "Unix Makefiles")
	if(GNU)
		dk_warning("GNU was allready set")
	endif()
	dk_set(GNU 1)
	message(GNU)
	
else()
	dk_fatal("Could not determin Environment Variable")
endif()

math(EXPR error "${GNU} + ${MSVC} + ${MINGW} + ${MSYS} + ${XCODE} - 1" OUTPUT_FORMAT DECIMAL)
if(error)
	dk_printVar(error)
	dk_printVar(GNU)
	dk_printVar(MSVC)
	dk_printVar(MINGW)
	dk_printVar(MSYS)
	dk_printVar(XCODE)

	dk_error("Either not enough, or too many compiler Flags are set")
	dk_notice("FIXME: COSMO causes both GNU and MINGW flags to be set. we will let this error pass for now.")
endif()

###########################################################################
## Get variables for Build Type
###########################################################################
option(DEBUG "Build Debug Binaries" 0)
option(RELEASE "Build Release Binaries" 0)
if(NOT DEBUG AND NOT RELEASE)
	dk_info("No Build type selected. Defaulting to DEBUG and RELEASE")
	dk_set(DEBUG 1)
	dk_set(RELEASE 1)
endif()


###########################################################################
## Get variables for Build Level
###########################################################################
option(BUILD "Simpily build the app or library" 0)
option(REBUILD "Rebuild the app" 0)
option(REBUILDALL "Rebuild the app and all dependencies" 1)
if(NOT BUILD AND NOT REBUILD AND NOT REBUILDALL)
	dk_info("No Build level selected, defaulting to REBUILDALL")
	dk_set(REBUILDALL 1)
endif()


###########################################################################
## Get variables for Library Build Type (STATIC or SHARED)
###########################################################################
option(STATIC "Build Static Libraries and Plugins" 0)
option(SHARED "Build Shared Libraries and Plugins" 0)
if(NOT STATIC AND NOT SHARED)
	dk_set(STATIC 1)
endif()


###########################################################################
## Get variables for CEF
###########################################################################
option(DKCEF "Use Chromium Embeded Framework" 0)
if(${DKCEF} STREQUAL "ON")
	add_definitions(-DHAVE_DKCef)
endif()



########### Determine if we are building a DKApp, DKPlugin or 3rdParty #############
#if(CMAKE_BINARY_DIR MATCHES "/DKApps/")
#	dk_info("Building DKApp . . .")
#	dk_set(DKAPP 1)
#	add_definitions(-DDKAPP)
#	dk_printVar(DKAPP)
#endif()
#if(CMAKE_BINARY_DIR MATCHED "/DKPlugin/")
#	dk_info("Building DKPlugin . . .")
#endif()
#if(CMAKE_BINARY_DIR MATCHES "/3rdParty/")
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

### Set other OS Specific variables ###
# RPI and RPI32
#if(DK_BINARY_OS_ARCH MATCHES "raspberry_arm32")
#	dk_set(RPI 1)
#	dk_set(RPI32 1)
#	dk_printVar(RPI)
#	dk_printVar(RPI32)
#endif()
# RPI and RPI64
#if(DK_BINARY_OS_ARCH MATCHES "raspberry_arm64")
#	dk_set(RPI 1)
#	dk_set(RPI64 1)
#	dk_printVar(RPI)
#	dk_printVar(RPI64)
#endif()

# TINYCORE
if(CMAKE_HOST_SYSTEM_VERSION)
	if(CMAKE_HOST_SYSTEM_VERSION MATCHES "tinycore")
		dk_set(TINYCORE 1)
	endif()
endif()


### Set CMAKE_SKIP_RPATH ###
dk_set(CMAKE_SKIP_RPATH 1)

if(WIN_HOST)
	dk_set(exe .exe)
	dk_set(bat .bat)
endif()





if(NOT CMAKE_SCRIPT_MODE_FILE)
	if(NOT triple)
		dk_printVar(CMAKE_BINARY_DIR)	
		dk_fatal("The binary directory must contain a valid os folder. \n Valid folders are cosmo,android_arm32,android_arm64,emscripten,ios_arm32,ios_arm64,iossim_x86,iossim_x86_64,linux_x86,linux_x86_64,mac_x86,mac_x86_64,raspberry_arm32,raspberry_arm64,win_x86,win_x86_64 \n 	EXAMPLE: digitalknob/Development/DKApps/MyApp/win_x86")
	endif()
endif()
