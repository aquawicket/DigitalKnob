include_guard()
message(STATUS "****** LOADING: ${CMAKE_CURRENT_LIST_FILE} ******")

include($ENV{DKCMAKE_DIR}/functions/dk_load.cmake)

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
set(DKVERBOSE_ENABLED			1		CACHE INTERNAL "")	# enable dk_verbose() functions
set(HALT_ON_ERRORS				1		CACHE INTERNAL "")	# halt cmake build script on errors
set(HALT_ON_WARNINGS			0		CACHE INTERNAL "")	# halt cmake build script on warnings
set(INSTALL_DKLIBS              0		CACHE INTERNAL "")	# install header files and libraries to DKBIN directory
set(MAC_TERMINAL_WRAPPER        1		CACHE INTERNAL "")	# open app with terminal
set(PRINT_CALL_DETAILS 			0		CACHE INTERNAL "")	# print function call details
set(PRINT_FILE_NAMES 			0 		CACHE INTERNAL "")	# print function call file names
set(PRINT_FUNCTION_ARGUMENTS 	0 		CACHE INTERNAL "")	# print function call arguments
set(PRINT_FUNCTION_NAMES 		0 		CACHE INTERNAL "")	# print function call function names
set(PRINT_LINE_NUMBERS 			0		CACHE INTERNAL "")	# print function call file line numbers
set(WAIT_ON_ERRORS				0		CACHE INTERNAL "")	# pause cmake build script on errors
set(WAIT_ON_WARNINGS			0		CACHE INTERNAL "")	# pause cmake build script on warnings
set(USE_COLOR					1		CACHE INTERNAL "")	# colored text output
set(PROJECT_INCLUDE_DKPLUGINS	1		CACHE INTERNAL "")  # Include DKPlugin libraries in the app project
set(PROJECT_INCLUDE_3RDPARTY	0		CACHE INTERNAL "")  # Include 3rdParty libraries in the app project

dk_load(${DKCMAKE_DIR}/DKColor.cmake)

###### DKOFFLINE Warning ######
if(${DKOFFLINE})
	dk_notice("!!!!!!!!!! WORKING IN DKOFFLINE MODE !!!!!!!!!")
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



##### Load Function files #################
dk_getHostTriple()
dk_load(${DKCMAKE_DIR}/DKVariables.cmake)
dk_load(dk_importVariables)
