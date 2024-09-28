#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

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
dk_set(INSTALL_DKLIBS          		0)	# install header files and libraries to DKBIN directory
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
	dk_assert(CMAKE_SOURCE_DIR)
	dk_getFullPath(${CMAKE_SOURCE_DIR} CMAKE_SOURCE_DIR)
	dk_assert(CMAKE_SOURCE_DIR)

	###### Get CMAKE_BINARY_DIR ######
	dk_assert(CMAKE_BINARY_DIR)
	dk_getFullPath(${CMAKE_BINARY_DIR} CMAKE_BINARY_DIR)
	dk_assert(CMAKE_BINARY_DIR)
endif()


###### Set MSYSTEM and ${MSYSTEM} variables ######
if(DEFINED "ENV{MSYSTEM}")
	dk_set(MSYSTEM "$ENV{MSYSTEM}")		
endif()
if(MSYSTEM)
	dk_set(${MSYSTEM} TRUE)
endif()





###### set MULTI_CONFIG / SINGLE_CONFIG variables ######
dk_validate(HOST_TRIPLE   "dk_host_triple()")
dk_validate(TARGET_TRIPLE "dk_TARGET_TRIPLE()")
dk_validate(CONFIG_PATH   "dk_MULTI_CONFIG()")


##### Load Function files #################
dk_assert(DKCMAKE_DIR)
dk_load(${DKCMAKE_DIR}/DKVariables.cmake)
