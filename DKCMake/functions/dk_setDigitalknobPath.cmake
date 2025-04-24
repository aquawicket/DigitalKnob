#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

##################################################################################
# dk_file_setDigitalknobPath()
#
#	Set the digitalknob root directory environment variable
#
function(dk_setDigitalknobPath)
	dk_debugFunc()
	
	
	# Set the DIGITALKNOB_DIR environment variable 
	dk_getFullPath(${CMAKE_SOURCE_DIR} path)
	string(FIND "${path}" "digitalknob" pos)
	string(SUBSTRING ${path} 0 ${pos} path)
	set(DIGITALKNOB_DIR ${path}digitalknob CACHE INTERNAL "")
<<<<<<< HEAD
	set(DKCMAKE_DIR ${DIGITALKNOB_DIR}/Development/DKCMake/ CACHE INTERNAL "")
	set(ENV{DIGITALKNOB_DIR} ${DIGITALKNOB_DIR})
	set(ENV{DKCMAKE_DIR} ${DKCMAKE_DIR})
	if(WIN_HOST)
		execute_process(COMMAND cmd /c setx DIGITALKNOB_DIR ${DIGITALKNOB_DIR})
		execute_process(COMMAND cmd /c setx DKCMAKE_DIR ${DKCMAKE_DIR})
=======
	set(ENV{DKCMAKE_DIR} $ENV{DIGITALKNOB_DIR}/Development/DKCMake/ CACHE INTERNAL "")
	set(ENV{DIGITALKNOB_DIR} $ENV{DIGITALKNOB_DIR})
	set(ENV{DKCMAKE_DIR} $ENV{DKCMAKE_DIR})
	if(WIN_HOST)
		#dk_validate(CMD_EXE "dk_CMD_EXE()")
		dk_depend(cmd)
		execute_process(COMMAND ${CMD_EXE} /c setx DIGITALKNOB_DIR $ENV{DIGITALKNOB_DIR})
		execute_process(COMMAND ${CMD_EXE} /c setx DKCMAKE_DIR $ENV{DKCMAKE_DIR})
>>>>>>> Development
	endif()
	#dk_printVar(DIGITALKNOB_DIR)
	#dk_printVar(DKCMAKE_DIR)
	#dk_printVar(ENV{DIGITALKNOB_DIR})
	#dk_printVar(ENV{DKCMAKE_DIR})
endfunction()
dk_setDigitalknobPath()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
=======
	dk_debugFunc(0)
>>>>>>> Development
	
	dk_todo()
endfunction()
