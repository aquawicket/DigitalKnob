include_guard()

#################### GLOBAL DKCMake SETTINGS ############################
set(DKOFFLINE					0		CACHE INTERNAL "")	# work offline. No Git remote commands or downloading files
set(BACKUP_APP_EXECUTABLES		1		CACHE INTERNAL "")	# backup previous app executable when rebuilding
#set(BACKUP_APP_USER_DATA		0		CACHE INTERNAL "")	# preserve assets/USER folder when building
set(BYPASS_DISABLE				0		CACHE INTERNAL "")	# bypass dk_disable() commands
set(DKDEBUGFUNC_ENABLED			0		CACHE INTERNAL "")	# enable DKDEBUGFUNC() function to print function calls
set(DKDEBUG_ENABLED				1		CACHE INTERNAL "")	# enable dk_debug() functions
set(PRINT_DKRETURNS				0		CACHE INTERNAL "")	# dk_return() will print the current cmake file
set(DELETE_DOWNLOADS			1		CACHE INTERNAL "")  # delete downloads after they are extracted or installed
set(DKTODO_ENABLED				1		CACHE INTERNAL "")	# enable dk_todo() functions
set(DKVERBOSE_ENABLED			0		CACHE INTERNAL "")	# enable dk_verbose() functions
set(HALT_ON_ERRORS				0		CACHE INTERNAL "")	# halt cmake build script on errors
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
set(INCLUDE_DKPLUGINS			1		CACHE INTERNAL "")  # Include the DKPlugins to the main app project


if(${DKOFFLINE})
	dk_warn("!!!!!!!!!! WORKING IN DKOFFLINE MODE !!!!!!!!!")
endif()

###### DEFINED EXTRA OS_HOST VARIABLES ######
if(CMAKE_HOST_WIN32)
	set(WIN_HOST 	TRUE 	CACHE INTERNAL "")
endif()
if(CMAKE_HOST_APPLE)
	set(UNIX_HOST 	TRUE 	CACHE INTERNAL "")
	set(MAC_HOST 	TRUE 	CACHE INTERNAL "")
endif()
if(CMAKE_HOST_UNIX AND NOT CMAKE_HOST_APPLE)
	set(UNIX_HOST 	TRUE 	CACHE INTERNAL "")
	set(LINUX_HOST 	TRUE 	CACHE INTERNAL "")
	if("${CMAKE_HOST_SYSTEM_NAME}" STREQUAL "Android")
		set(ANDROID_HOST 	TRUE 	CACHE INTERNAL "")
	endif()
endif()

###### DEFINED EXTRA MSYS2 VARIABLES #######
if(DEFINED "ENV{MSYSTEM}")
	set(MSYSTEM "$ENV{MSYSTEM}"	CACHE INTERNAL "")		
endif()
if(MSYSTEM)
	set(${MSYSTEM} TRUE			CACHE INTERNAL "")
endif()

##### DEFINED ProgramFiles VARIABLES ######
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
if(DEFINED "ENV{ProgramFiles\(x86\)}")
	file(TO_CMAKE_PATH "$ENV{ProgramFiles\(x86\)}" ProgramFiles_x86)
	set(ProgramFiles_x86 "${ProgramFiles_x86}")
endif()

###### DEFINED MULTI_CONFIG / SINGLE_CONFIG VARIABLES ######
get_property(MULTI_CONFIG GLOBAL PROPERTY GENERATOR_IS_MULTI_CONFIG)
if(MULTI_CONFIG)
	set(MULTI_CONFIG TRUE CACHE INTERNAL "")
	message(STATUS "*** Generator is Multi-Config ***")
else()
	set(SINGLE_CONFIG TRUE CACHE INTERNAL "")
	message(STATUS "*** Generator is Single-Config ***")
endif()


###### Set the DIGITALKNOB, DKBRANCH and DKCMAKE variables ######
get_filename_component(path ${CMAKE_SOURCE_DIR} ABSOLUTE)
set(DKCMAKE ${path} CACHE INTERNAL "")
#message(STATUS "\n DKCMAKE =  ${DKCMAKE}\n")

string(FIND "${DKCMAKE}" "DKCMake" pos)
math(EXPR pos "${pos}-1")
string(SUBSTRING ${DKCMAKE} 0 ${pos} DKBRANCH)
set(DKBRANCH ${DKBRANCH} CACHE INTERNAL "")
#message(STATUS "\n DKBRANCH =  ${DKBRANCH}\n")

string(FIND "${DKBRANCH}" "digitalknob" pos)
string(SUBSTRING ${DKBRANCH} 0 ${pos} DIGITALKNOB)
set(DIGITALKNOB ${DIGITALKNOB}digitalknob CACHE INTERNAL "")
#message(STATUS "\n DIGITALKNOB =  ${DIGITALKNOB}\n")


##### Load Function files #################
include(${DKCMAKE}/functions/dk_load.cmake)
#include(${DKCMAKE}/functions/dk_call.cmake)
#dk_load(dk_listReplace)
#dk_load(dk_getArgIdentifiers)
#dk_load(dk_debugFunc)
#dk_load(dk_color)
#dk_load(dk_updateLogInfo)
#dk_load(DKASSERT)
#dk_load(dk_error)
#dk_load(dk_warn)
#dk_load(dk_info)
#dk_load(dk_debug)
#dk_load(dk_verbose)
#dk_load(dk_trace)
dk_load(DKColor)
dk_load(DKFunctions)
dk_load(DKFileSystem)
dk_load(DKVariables)
#dk_load(DKDisabled)
#dk_load(dk_findLibrary)
#dk_load(dk_importVariables)
include(${DKCMAKE}/functions/dk_importVariables.cmake)
#dk_load(dk_findFiles)


##### Load 3rdParty Tools #################
dk_depend(cmake)
dk_depend(git)
dk_depend(msys2)

dk_msys2("echo MSYSTEM = $MSYSTEM")
