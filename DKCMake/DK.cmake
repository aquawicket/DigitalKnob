include_guard()
message(STATUS "****** LOADING: ${CMAKE_CURRENT_LIST_FILE} ******")

###### Set DKCMAKE_DIR ######
if(NOT DKCMAKE_DIR)
	set(DKCMAKE_DIR ${CMAKE_SOURCE_DIR} CACHE INTERNAL "" FORCE)
endif()
message(STATUS "DKCMAKE_DIR = ${DKCMAKE_DIR}")

include(${DKCMAKE_DIR}/functions/dk_load.cmake)

if(CMAKE_SCRIPT_MODE_FILE)
message(STATUS "")
message(STATUS "##################################################")
message(STATUS "################# SCRIPT MODE ####################")
message(STATUS "##################################################")
message(STATUS "")
endif()


#################### GLOBAL DKCMake SETTINGS ############################
set(DKOFFLINE					0		CACHE INTERNAL "")	# work offline. No Git remote commands or downloading files
set(BACKUP_APP_EXECUTABLES		1		CACHE INTERNAL "")	# backup previous app executable when rebuilding
set(BACKUP_APP_USER_DATA		0		CACHE INTERNAL "")	# preserve assets/USER folder when building
set(BYPASS_DISABLE				0		CACHE INTERNAL "")	# bypass dk_disable() commands
set(DKDEBUGFUNC_ENABLED			0		CACHE INTERNAL "")	# enable DKDEBUGFUNC() function to print function calls
set(DKDEBUG_ENABLED				1		CACHE INTERNAL "")	# enable dk_debug() functions
set(PRINT_DKRETURNS				0		CACHE INTERNAL "")	# dk_return() will print the current cmake file
set(DELETE_DOWNLOADS			0		CACHE INTERNAL "")  # delete downloads after they are extracted or installed
set(DKTODO_ENABLED				1		CACHE INTERNAL "")	# enable dk_todo() functions
set(DKVERBOSE_ENABLED			0		CACHE INTERNAL "")	# enable dk_verbose() functions
set(HALT_ON_ERRORS				1		CACHE INTERNAL "")	# halt cmake build script on errors
set(HALT_ON_WARNINGS			0		CACHE INTERNAL "")	# halt cmake build script on warnings
set(INSTALL_DKLIBS              0		CACHE INTERNAL "")	# install header files and libraries to DKBIN directory
set(MAC_TERMINAL_WRAPPER        1		CACHE INTERNAL "")	# open app with terminal
set(PRINT_CALL_DETAILS 			1		CACHE INTERNAL "")	# print function call details
set(PRINT_FILE_NAMES 			1 		CACHE INTERNAL "")	# print function call file names
set(PRINT_FUNCTION_ARGUMENTS 	1 		CACHE INTERNAL "")	# print function call arguments
set(PRINT_FUNCTION_NAMES 		1 		CACHE INTERNAL "")	# print function call function names
set(PRINT_LINE_NUMBERS 			1		CACHE INTERNAL "")	# print function call file line numbers
set(WAIT_ON_ERRORS				0		CACHE INTERNAL "")	# pause cmake build script on errors
set(WAIT_ON_WARNINGS			0		CACHE INTERNAL "")	# pause cmake build script on warnings
set(USE_COLOR					1		CACHE INTERNAL "")	# colored text output
set(PROJECT_INCLUDE_DKPLUGINS	1		CACHE INTERNAL "")  # Include DKPlugin libraries in the app project
set(PROJECT_INCLUDE_3RDPARTY	0		CACHE INTERNAL "")  # Include 3rdParty libraries in the app project

dk_load(DKColor)
#include(${DKCMAKE_DIR}/DKColor.cmake)

###### DKOFFLINE Warning ######
if(${DKOFFLINE})
	dk_warn("!!!!!!!!!! WORKING IN DKOFFLINE MODE !!!!!!!!!")
endif()



###### Get CURRENT_DIRECTORY ######
#if(NOT CURRENT_DIR)
#	get_filename_component(CURRENT_DIR ${CMAKE_CURRENT_SOURCE_DIR} ABSOLUTE)
#	message(STATUS "CURRENT_DIR = ${CURRENT_DIR}")
#endif()
	
if(NOT CMAKE_SCRIPT_MODE_FILE)
	###### Get CMAKE_SOURCE_DIR ######
	if(NOT CMAKE_SOURCE_DIR)
		message(FATAL_ERROR "CMAKE_SOURCE_DIR invalid!")
	endif()
	get_filename_component(CMAKE_SOURCE_DIR ${CMAKE_SOURCE_DIR} ABSOLUTE)
	message(STATUS "CMAKE_SOURCE_DIR = ${CMAKE_SOURCE_DIR}")


	###### Get CMAKE_BINARY_DIR ######
	if(NOT CMAKE_BINARY_DIR)
		message(FATAL_ERROR "CMAKE_BINARY_DIR invalid!")
	endif()
	get_filename_component(CMAKE_BINARY_DIR ${CMAKE_BINARY_DIR} ABSOLUTE)
	message(STATUS "CMAKE_BINARY_DIR = ${CMAKE_BINARY_DIR}")
endif()





###### Set DKBRANCH_DIR ######
string(FIND "${DKCMAKE_DIR}" "DKCMake" pos)
math(EXPR pos "${pos}-1")
string(SUBSTRING ${DKCMAKE_DIR} 0 ${pos} BRANCH_DIR)
set(DKBRANCH_DIR ${BRANCH_DIR} CACHE INTERNAL "" FORCE)
message(STATUS "DKBRANCH_DIR = ${DKBRANCH_DIR}")


###### Set DIGITALKNOB_DIR ######
string(FIND "${DKBRANCH_DIR}" "digitalknob" pos)
string(SUBSTRING ${DKBRANCH_DIR} 0 ${pos} DK_DIR)
set(DIGITALKNOB_DIR ${DK_DIR}digitalknob CACHE INTERNAL "" FORCE)
message(STATUS "DIGITALKNOB_DIR = ${DIGITALKNOB_DIR}")


##### Set DKTOOLS_DIR ######
set(DKTOOLS_DIR ${DIGITALKNOB_DIR}/DKTools CACHE INTERNAL "" FORCE)
message(STATUS "DKTOOLS_DIR = ${DKTOOLS_DIR}")


##### Set DK3RDPARTY_DIR ######
set(DK3RDPARTY_DIR ${DKBRANCH_DIR}/3rdParty CACHE INTERNAL "" FORCE)
message(STATUS "DK3RDPARTY_DIR = ${DK3RDPARTY_DIR}")


###### Set DKIMPORTS_DIR ######
set(DKIMPORTS_DIR ${DK3RDPARTY_DIR}/_DKIMPORTS CACHE INTERNAL "" FORCE)
message(STATUS "DKIMPORTS_DIR = ${DKIMPORTS_DIR}")


###### Set DKAPPS_DIR ######
set(DKAPPS_DIR ${DKBRANCH_DIR}/DKApps CACHE INTERNAL "" FORCE)
message(STATUS "DKAPPS_DIR = ${DKAPPS_DIR}")


###### Set DKPLUGINS_DIR ######
set(DKPLUGINS_DIR ${DKBRANCH_DIR}/DKPlugins CACHE INTERNAL "" FORCE)
message(STATUS "DKPLUGINS_DIR = ${DKPLUGINS_DIR}")

###### Set DKDOWNLOAD_DIR ######
set(DKDOWNLOAD_DIR ${DIGITALKNOB_DIR}/download CACHE INTERNAL "" FORCE)
message(STATUS "DKDOWNLOAD_DIR = ${DKDOWNLOAD_DIR}")

###### Set DKWEB ######
set(DKWEB "http://127.0.0.1" CACHE INTERNAL "" FORCE)
message(STATUS "DKWEB = ${DKWEB}")


###### Set <SYSTEM_NAME>_HOST variables ######
if(CMAKE_HOST_WIN32)
	set(WIN_HOST 				TRUE 							CACHE INTERNAL "")
endif()
if(CMAKE_HOST_APPLE)
	set(UNIX_HOST 				TRUE 							CACHE INTERNAL "")
	set(MAC_HOST 				TRUE 							CACHE INTERNAL "")
endif()
if(CMAKE_HOST_UNIX AND NOT CMAKE_HOST_APPLE)
	set(UNIX_HOST 				TRUE 							CACHE INTERNAL "")
	set(LINUX_HOST 				TRUE 							CACHE INTERNAL "")
	
	if("${CMAKE_HOST_SYSTEM_NAME}" STREQUAL "Android")
		set(ANDROID_HOST 		TRUE 							CACHE INTERNAL "")
	endif()
endif()


###### Set HOST ######
#message(STATUS "CMAKE_HOST_SYSTEM_NAME = ${CMAKE_HOST_SYSTEM_NAME}")
if(CMAKE_HOST_WIN32)
	set(HOST		WIN			CACHE INTERNAL "")
elseif(CMAKE_HOST_APPLE)
	set(HOST		APPLE		CACHE INTERNAL "")
elseif(CMAKE_HOST_UNIX AND NOT CMAKE_HOST_APPLE)
	if("${CMAKE_HOST_SYSTEM_NAME}" STREQUAL "Android")
		set(HOST	ANDROID		CACHE INTERNAL "")
	else()
		set(HOST	LINUX		CACHE INTERNAL "")
	endif()
else()
	message(FATAL_ERROR "CMAKE_HOST: Unknown host")
endif()
message(STATUS "HOST = ${HOST}")


###### Set MSYSTEM and ${MSYSTEM} variables ######
if(DEFINED "ENV{MSYSTEM}")
	set(MSYSTEM "$ENV{MSYSTEM}"	CACHE INTERNAL "")		
endif()
if(MSYSTEM)
	message(STATUS "MSYSTEM = ${MSYSTEM}")
	
	set(${MSYSTEM} TRUE			CACHE INTERNAL "")
	message(STATUS "${MSYSTEM} = ${${MSYSTEM}}")
endif()


##### Set ProgramFiles_<> variables ######
if(DEFINED "ENV{HOMEDRIVE}")
	# TODO
endif()
if(DEFINED "ENV{ProgramW6432}")
	file(TO_CMAKE_PATH "$ENV{ProgramW6432}" ProgramFiles)
	set(ProgramFiles "${ProgramFiles}")
elseif(DEFINED "ENV{ProgramFiles}")
	file(TO_CMAKE_PATH "$ENV{ProgramFiles}" ProgramFiles)
	set(ProgramFiles "${ProgramFiles}")
endif()
#if(DEFINED "ENV{ProgramFiles\(x86\)}")
#	file(TO_CMAKE_PATH "$ENV{ProgramFiles\(x86\)}" ProgramFiles_x86)
#	set(ProgramFiles_x86 "${ProgramFiles_x86}")
#endif()
if(ProgramFiles)
	message(STATUS "ProgramFiles = ${ProgramFiles}")
endif()
if(ProgramFiles_x86)
	message(STATUS "ProgramFiles_x86 = ${ProgramFiles_x86}")
endif()


###### set MULTI_CONFIG / SINGLE_CONFIG variables ######
get_property(MULTI_CONFIG GLOBAL PROPERTY GENERATOR_IS_MULTI_CONFIG)
if(MULTI_CONFIG)
	set(MULTI_CONFIG TRUE CACHE INTERNAL "")
	message(STATUS "*** ${CMAKE_GENERATOR}: Generator is Multi-Config ***")
else()
	set(SINGLE_CONFIG TRUE CACHE INTERNAL "")
	message(STATUS "*** ${CMAKE_GENERATOR}: Generator is Single-Config ***")
endif()
if(MULTI_CONFIG)
	message(STATUS "MULTI_CONFIG = ${MULTI_CONFIG}")
endif()
if(SINGLE_CONFIG)
	message(STATUS "SINGLE_CONFIG = ${SINGLE_CONFIG}")
endif()


### Set HOST_ARCH
if(NOT CMAKE_HOST_SYSTEM_PROCESSOR)
	if(CMAKE_HOST_WIN32)
		if (DEFINED ENV{PROCESSOR_ARCHITEW6432})
		  set (CMAKE_HOST_SYSTEM_PROCESSOR "$ENV{PROCESSOR_ARCHITEW6432}")
		else()
		  set (CMAKE_HOST_SYSTEM_PROCESSOR "$ENV{PROCESSOR_ARCHITECTURE}")
		endif()
	else()
		execute_process(COMMAND uname -m OUTPUT_VARIABLE CMAKE_HOST_SYSTEM_PROCESSOR)
	endif()
endif()
string(STRIP "${CMAKE_HOST_SYSTEM_PROCESSOR}" CMAKE_HOST_SYSTEM_PROCESSOR)
#message(STATUS "CMAKE_HOST_SYSTEM_PROCESSOR = \"${CMAKE_HOST_SYSTEM_PROCESSOR}\"")
if("${CMAKE_HOST_SYSTEM_PROCESSOR}" STREQUAL "aarch64")
	set(ARM64 TRUE CACHE INTERNAL "")
	set(HOST_ARCH arm64	CACHE INTERNAL "")
elseif("${CMAKE_HOST_SYSTEM_PROCESSOR}" STREQUAL "AMD64")
	set(X86_64 TRUE CACHE INTERNAL "")
	set(HOST_ARCH x86_64 CACHE INTERNAL "")
elseif("${CMAKE_HOST_SYSTEM_PROCESSOR}" STREQUAL "ARM64")
	set(ARM64 TRUE CACHE INTERNAL "")
	set(HOST_ARCH arm64	CACHE INTERNAL "")
elseif("${CMAKE_HOST_SYSTEM_PROCESSOR}" STREQUAL "EM64T")
	set(X86_64 TRUE CACHE INTERNAL "")
	set(HOST_ARCH x86_64 CACHE INTERNAL "")
elseif("${CMAKE_HOST_SYSTEM_PROCESSOR}" STREQUAL "IA64")
	set(X86_64 TRUE CACHE INTERNAL "")
	set(HOST_ARCH x86_64 CACHE INTERNAL "")
elseif("${CMAKE_HOST_SYSTEM_PROCESSOR}" STREQUAL "x86")
	set(X86 TRUE CACHE INTERNAL "")
	set(HOST_ARCH x86 CACHE INTERNAL "")
elseif("${CMAKE_HOST_SYSTEM_PROCESSOR}" STREQUAL "x86_64")
	set(X86_64 TRUE CACHE INTERNAL "")
	set(HOST_ARCH x86_64 CACHE INTERNAL "")
else()
	message(FATAL_ERROR "CMAKE_HOST_SYSTEM_PROCESSOR: Unknown arch: \"${CMAKE_HOST_SYSTEM_PROCESSOR}\"")
endif()
#string(STRIP "${HOST_ARCH}" HOST_ARCH)
message(STATUS "HOST_ARCH = ${HOST_ARCH}")


### set [HOST]_[HOST_ARCH] variable
string(TOUPPER ${HOST} HOST_UPPER)
string(TOUPPER ${HOST_ARCH} HOST_ARCH_UPPER)
set(${HOST_UPPER}_${HOST_ARCH_UPPER}_HOST TRUE)
#string(STRIP "${${HOST_UPPER}_${HOST_ARCH_UPPER}_HOST}" ${HOST_UPPER}_${HOST_ARCH_UPPER}_HOST)
message(STATUS "${HOST_UPPER}_${HOST_ARCH_UPPER}_HOST = ${${HOST_UPPER}_${HOST_ARCH_UPPER}_HOST}")







##### Load Function files #################

#dk_load(DKFunctions)
#dk_load(DKFileSystem)
dk_load(DKVariables)
dk_load(dk_importVariables)
#include(${DKCMAKE_DIR}/functions/dk_importVariables.cmake)
