include_guard()

#################### SETTINGS ############################
set(BACKUP_APP_EXECUTABLES		0		CACHE INTERNAL "")	# backup previous app executable when rebuilding
#set(BACKUP_APP_USER_DATA		0		CACHE INTERNAL "")	# preserve assets/USER folder when building 
set(BYPASS_DISABLE				0		CACHE INTERNAL "")	# bypass dk_disable() commands
set(DKDEBUGFUNC_ENABLED			0		CACHE INTERNAL "")	# enable DKDEBUGFUNC() function to print function calls
set(DKDEBUG_ENABLED				1		CACHE INTERNAL "")	# enable dk_debug() functions
set(PRINT_DKRETURNS				1		CACHE INTERNAL "")	# dk_return() will print the current cmake file
set(DKTODO_ENABLED				1		CACHE INTERNAL "")	# enable dk_todo() functions
set(DKVERBOSE_ENABLED			0		CACHE INTERNAL "")	# enable dk_verbose() functions
set(HALT_ON_ERRORS				0		CACHE INTERNAL "")	# halt cmake build script on errors
set(HALT_ON_WARNINGS			0		CACHE INTERNAL "")	# halt cmake build script on warnings
set(INSTALL_DKLIBS              0		CACHE INTERNAL "")	# install header files and libraries to DKInstall directory
set(MAC_TERMINAL_WRAPPER        1		CACHE INTERNAL "")	# open app with terminal
set(PRINT_CALL_DETAILS 			1		CACHE INTERNAL "")	# print function call details
set(PRINT_FILE_NAMES 			1 		CACHE INTERNAL "")	# print function call file names
set(PRINT_FUNCTION_ARGUMENTS 	1 		CACHE INTERNAL "")	# print function call arguments
set(PRINT_FUNCTION_NAMES 		1 		CACHE INTERNAL "")	# print function call function names
set(PRINT_LINE_NUMBERS 			1		CACHE INTERNAL "")	# print function call file line numbers
set(WAIT_ON_ERRORS				0		CACHE INTERNAL "")	# pause cmake build script on errors
set(WAIT_ON_WARNINGS			0		CACHE INTERNAL "")	# pause cmake build script on warnings


## PRE DEFINED VARIABLES
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
endif()


## Set the DIGITALKNOB and DKCMAKE environment variables 
get_filename_component(path ${CMAKE_SOURCE_DIR} ABSOLUTE)
string(FIND "${path}" "digitalknob" pos)
string(SUBSTRING ${path} 0 ${pos} path)
set(DIGITALKNOB ${path}digitalknob CACHE INTERNAL "")
set(DKCMAKE ${DIGITALKNOB}/DK/DKCMake CACHE INTERNAL "")
set(ENV{DIGITALKNOB} ${DIGITALKNOB})
set(ENV{DKCMAKE} ${DKCMAKE})
if(WIN_HOST)
	execute_process(COMMAND cmd /c setx DIGITALKNOB ${DIGITALKNOB})
	execute_process(COMMAND cmd /c setx DKCMAKE ${DKCMAKE})
endif()


##### Load Function files #################
include(${DKCMAKE}/functions/dk_load.cmake)
#include(${DKCMAKE}/functions/dk_call.cmake)
#dk_load(dk_listReplace)
#dk_load(dk_getArgIdentifiers)
#dk_load(dk_debugFunc)
#dk_load(dk_color)
#dk_load(dk_updateLogInfo)
#dk_load(dk_assert)
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


# POST DEFINED VARIABLES
