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


# This source file is part of DigitalKnob, the cross-platform C/C++/Javascript/Html/Css Solution
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
dk_debug("****** LOADING: ${CMAKE_CURRENT_LIST_FILE} ******")

if(CMAKE_SCRIPT_MODE_FILE)
	dk_debug("")
	dk_debug("##################################################")
	dk_debug("################# SCRIPT MODE ####################")
	dk_debug("##################################################")
	dk_debug("")
endif()

#################### GLOBAL DKCMake SETTINGS ############################
dk_set(BACKUP_APP_EXECUTABLES		1)	# backup previous app executable when rebuilding
dk_set(BACKUP_APP_USER_DATA			0)	# preserve assets/USER folder when building
dk_set(BYPASS_DISABLE				0)	# bypass dk_disable() commands
dk_set(DELETE_DOWNLOADS				0)  # delete downloads after they are extracted or installed
dk_set(DKOFFLINE					0) 	# work offline. No Git remote commands or downloading files
dk_set(INSTALL_DKLIBS          		1)	# install header files and libraries to DKBIN directory
dk_set(MAC_TERMINAL_WRAPPER     	1)	# open app with terminal
dk_set(PRINT_CALL_DETAILS 			0)	# print function call details
dk_set(PRINT_DKRETURNS				0)	# dk_return() will print the current cmake file
dk_set(PRINT_FILE_NAMES 			0)	# print function call file names
dk_set(PRINT_FUNCTION_ARGUMENTS 	0)	# print function call arguments
dk_set(PRINT_FUNCTION_NAMES 		0)	# print function call function names
dk_set(PRINT_LINE_NUMBERS 			0)	# print function call file line numbers
dk_set(PROJECT_INCLUDE_3RDPARTY		1)  # Include 3rdParty libraries in the app project
dk_set(PROJECT_INCLUDE_DKPLUGINS	1)  # Include DKPlugin libraries in the app project
dk_set(dk_color_ENABLE				1)	# colored text output



###### DKOFFLINE Warning ######
if(${DKOFFLINE})
	dk_notice("!!!!!!!!!! WORKING IN DKOFFLINE MODE !!!!!!!!!")
endif()

###### Get WORKING_DIRECTORY ######
#d_k_getcwd()
	
if(NOT CMAKE_SCRIPT_MODE_FILE)
	###### Get CMAKE_SOURCE_DIR ######
	dk_assertVar(CMAKE_SOURCE_DIR)
	dk_load(dk_getFullPath)
	dk_getFullPath(${CMAKE_SOURCE_DIR} CMAKE_SOURCE_DIR)
	dk_assertPath(CMAKE_SOURCE_DIR)
	dk_debug("CMAKE_SOURCE_DIR:             '${CMAKE_SOURCE_DIR}'")

	###### Get CMAKE_BINARY_DIR ######
	dk_assertVar(CMAKE_BINARY_DIR)
	dk_getFullPath(${CMAKE_BINARY_DIR} CMAKE_BINARY_DIR)
	dk_assertPath(CMAKE_BINARY_DIR)
	dk_debug("CMAKE_BINARY_DIR:             '${CMAKE_BINARY_DIR}'")
endif()


if((NOT DEFINED Cosmopolitan) AND (DEFINED "ENV{Cosmopolitan}"))
	dk_set(Cosmopolitan "$ENV{Cosmopolitan}")
endif()
if(Cosmopolitan)
	dk_debug("Cosmopolitan")
	#dk_set(CMAKE_HOST_SYSTEM_NAME "Cosmopolitan")
	#dk_set(CMAKE_HOST_UNIX 1)
	#dk_unset(CMAKE_HOST_WIN32)
	#dk_unset(CMAKE_HOST_APPLE)
	#dk_unset(WIN32)
endif()


###### Set MSYSTEM and ${MSYSTEM} variables ######
if((NOT DEFINED MSYSTEM) AND (DEFINED "ENV{MSYSTEM}"))
	dk_set(MSYSTEM "$ENV{MSYSTEM}")		
endif()
if(MSYSTEM)
	dk_set(${MSYSTEM} 1)
endif()
dk_debug("MSYSTEM:                      '${MSYSTEM}'")
dk_debug("${MSYSTEM}:                   '${${MSYSTEM}}'")


############ Get Host Variables ############
dk_validate(Host_Tuple   "dk_Host_Tuple()")
dk_debug("Host_Os:                      '${Host_Os}'")
dk_debug("Host_Arch:                    '${Host_Arch}'")
dk_debug("Host_Tuple:                   '${Host_Tuple}'")

############ Get Target Variables ############
dk_validate(Target_Config   "dk_Target_Config()")
dk_debug("Target_Config:     '${Target_Config}'")


###############################################################
## Set variables for paths
###############################################################
dk_validate(DIGITALKNOB_DIR "dk_DIGITALKNOB_DIR()")
dk_debug("DIGITALKNOB_DIR:              '$ENV{DIGITALKNOB_DIR}'")

dk_set(CMAKE_SUPPRESS_REGENERATION 1)
dk_debug("CMAKE_SUPPRESS_REGENERATION:  '${CMAKE_SUPPRESS_REGENERATION}'")

### Install DKBIN binary directory ###
if(INSTALL_DKLIBS)
	dk_set(CMAKE_INSTALL_PREFIX $ENV{DIGITALKNOB_DIR}/DKBIN)
endif()
dk_debug("CMAKE_INSTALL_PREFIX:     '${CMAKE_INSTALL_PREFIX}'")


#dk_haveLongPaths()
#dk_debug("dk_haveLongPaths: '${dk_haveLongPaths}'")


#########################################################################
## Set the IDE variable
#########################################################################
dk_debug("CMAKE_C_COMPILER_ID:          '${CMAKE_C_COMPILER_ID}'")
dk_debug("CMAKE_CXX_COMPILER_ID:        '${CMAKE_CXX_COMPILER_ID}'")
dk_debug("CMAKE_GENERATOR:              '${CMAKE_GENERATOR}'")
dk_debug("CMAKE_GENERATOR_PLATFORM:     '${CMAKE_GENERATOR_PLATFORM}'")

if((CMAKE_CXX_COMPILER_ID STREQUAL "GNU") OR (DEFINED ENV{GNU}))
	if(GNU)
		dk_warning("GNU was allready set")
	endif()
	dk_set(GNU 1)
	dk_debug("GNU:                          '${GNU}'")
elseif((CMAKE_GENERATOR MATCHES "Visual Studio") OR (DEFINED ENV{MSVC}))
	if(MSVC)
		dk_warning("MSVC was allready set")
	endif()
	dk_set(MSVC 1)
	dk_debug("MSVC:                         '${MSVC}'")
elseif((CMAKE_GENERATOR STREQUAL "MinGW Makefiles") OR (DEFINED ENV{MINGW}))
	if(MINGW)
		dk_warning("MINGW was allready set")
	endif()
	dk_set(MINGW 1)
	dk_debug("MINGW:                        '${MINGW}'")
elseif((CMAKE_GENERATOR STREQUAL "MSYS Makefiles") OR (DEFINED ENV{MSYS}))
	if(MSYS)
		dk_warning("MSYS was allready set")
	endif()
	dk_set(MSYS 1)
	dk_debug("MSYS:                         '${MSYS}'")
elseif((CMAKE_GENERATOR STREQUAL "Xcode") OR (DEFINED ENV{XCODE}))
	if(XCODE)
		dk_warning("XCODE was allready set")
	endif()
	dk_set(XCODE 1)
	dk_debug("XCODE:                        '${XCODE}'")
elseif((CMAKE_GENERATOR STREQUAL "Unix Makefiles") OR (DEFINED ENV{GNU}))
	if(GNU)
		dk_warning("GNU was allready set")
	endif()
	dk_set(GNU 1)
	dk_debug("GNU:                          '${GNU}'")
elseif((CMAKE_GENERATOR STREQUAL "NMake Makefiles") OR (DEFINED ENV{MSVC}))
	if(MSVC)
		dk_fatal("MSVC was allready set")
	endif()
	dk_set(MSVC 1)
	dk_debug("MSVC:                         '${MSVC}'")
else()
	if(NOT CMAKE_SCRIPT_MODE_FILE)
		dk_fatal("Could not determin IDE Environment Variable")
	endif()
endif()

if(NOT CMAKE_SCRIPT_MODE_FILE)
	math(EXPR error "${GNU} + ${MSVC} + ${MINGW} + ${MSYS} + ${XCODE} - 1" OUTPUT_FORMAT DECIMAL)
	if(error)
		dk_debug("error = ${error}")
		dk_debug("GNU   = ${GNU}")
		dk_debug("MSVC  = ${MSVC}")
		dk_debug("MINGW = ${MINGW}")
		dk_debug("MSYS  = ${MSYS}")
		dk_debug("XCODE = ${XCODE}")

		dk_error("Either not enough, or too many compiler Flags are set")
		dk_notice("FIXME: Cosmopolitan causes both GNU and MINGW flags to be set. we will let this error pass for now.")
	endif()
endif()
#########################################################################
## Get variables for Build Type
#########################################################################
option(Debug "Build Debug Binaries" 0)
option(Release "Build Release Binaries" 0)
if(NOT Debug AND NOT Release)
	dk_notice("No Build type selected. Defaulting to Debug and Release")
	dk_set(Debug 1)
	dk_set(Release 1)
endif()
dk_debug("Debug:                        '${Debug}'")
dk_debug("Release:                      '${Release}'")

#########################################################################
## Get variables for Build Level
#########################################################################
option(BUILD "Simpily build the app or library" 0)
option(REBUILD "Rebuild the app" 0)
option(REBUILDALL "Rebuild the app and all dependencies" 1)
if(NOT BUILD AND NOT REBUILD AND NOT REBUILDALL)
	dk_info("No Build level selected, defaulting to REBUILDALL")
	dk_set(REBUILDALL 1)
endif()
dk_debug("Build:                        '${Build}'")
dk_debug("Rebuild:                      '${Rebuild}'")
dk_debug("RebuildAll:                   '${RebuildAll}'")

#########################################################################
## Get variables for Library Build Type (STATIC or SHARED)
#########################################################################
option(STATIC "Build Static Libraries and Plugins" 0)
option(SHARED "Build Shared Libraries and Plugins" 0)
if(NOT STATIC AND NOT SHARED)
	dk_set(STATIC 1)
endif()
dk_debug("Static:                       '${Static}'")
dk_debug("Shared:                       '${Shared}'")

#########################################################################
## Get variables for CEF
#########################################################################
option(DKCEF "Use Chromium Embeded Framework" 0)
if(${DKCEF})
	add_definitions(-DHAVE_DKCef)
endif()
dk_debug("DKCEF:                        '${DKCEF}'")


#########################################################################
#########################################################################
## NOTICE ##
## WORK IN PROGRESS ##
## Working to consolidate and remove the need for seperate Raspberry pi functions
## The build setup is almost Identicle to linux. We will try to compile Rpi by excluding
## the Raspberry flag variables in place of the Linux functions. In this conversion,
## Raspberry will listen to Linux X86/64 and RPI X86/64.   The Raspberry flags will do nothing
## and we should be able to remove them once everythng is working.

########### Set DK_BINARY_ and DK_PROJECT_ variables ####################

### Set other OS Specific variables ###
# RPI32
#if(DK_BINARY_OS_ARCH MATCHES "Raspberry_Arm32")
#	dk_set(RPI 1)
#	dk_set(RPI32 1)
#	dk_debug("RPI   = ${RPI}")
#	dk_debug("RPI32 = ${RPI32}")
#endif()

# RPI64
#if(DK_BINARY_OS_ARCH MATCHES "Raspberry_Arm64")
#	dk_set(RPI 1)
#	dk_set(RPI64 1)
#	dk_debug("RPI   = ${RPI}")
#	dk_debug("RPI64 = ${RPI64}")
#endif()

# TINYCORE
if(CMAKE_HOST_SYSTEM_VERSION AND (CMAKE_HOST_SYSTEM_VERSION MATCHES "tinycore"))
	dk_set(TINYCORE 1)
	dk_debug("TINYCORE = ${TINYCORE}")
endif()
dk_debug("CMAKE_HOST_SYSTEM_VERSION:    '${CMAKE_HOST_SYSTEM_VERSION}'")

### Set CMAKE_SKIP_RPATH ###
dk_set(CMAKE_SKIP_RPATH 1)
dk_debug("CMAKE_SKIP_RPATH:             '${CMAKE_SKIP_RPATH}'")

if(Windows_Host)
	dk_set(exe .exe)
	dk_set(bat .bat)
	dk_set(cmd .cmd)
endif()





if(NOT CMAKE_SCRIPT_MODE_FILE)
	if(NOT Target_Tuple)
		dk_printVar(CMAKE_BINARY_DIR)	
		dk_fatal("The binary directory must contain a valid os folder. \n Valid folders are Cosmo,Android_Arm32,Android_Arm64,Android_X86,Android_X86_64,Emscripten,Ios_Arm32,Ios_Arm64,Iossim_X86,Iossim_X86_64,Linux_X86,Linux_X86_64,Mac_X86,Mac_X86_64,Raspberry_Arm32,Raspberry_Arm64,Windows_X86,Windows_X86_64 \n 	EXAMPLE: DigitalKnob/Development/DKCpp/apps/MyApp/Windows_X86")
	endif()
endif()

