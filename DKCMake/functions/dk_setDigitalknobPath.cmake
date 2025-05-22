#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

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
	set(ENV{DKCMAKE_DIR} $ENV{DIGITALKNOB_DIR}/Development/DKCMake/ CACHE INTERNAL "")
	set(ENV{DIGITALKNOB_DIR} $ENV{DIGITALKNOB_DIR})
	set(ENV{DKCMAKE_DIR} $ENV{DKCMAKE_DIR})
	if(Windows_Host)
		#dk_validate(CMD_EXE "dk_CMD_EXE()")
		dk_depend(cmd)
		execute_process(COMMAND ${CMD_EXE} /c setx DIGITALKNOB_DIR $ENV{DIGITALKNOB_DIR})
		execute_process(COMMAND ${CMD_EXE} /c setx DKCMAKE_DIR $ENV{DKCMAKE_DIR})
	endif()
	#dk_printVar(DIGITALKNOB_DIR)
	#dk_printVar(DKCMAKE_DIR)
	#dk_printVar(ENV{DIGITALKNOB_DIR})
	#dk_printVar(ENV{DKCMAKE_DIR})
endfunction()
dk_setDigitalknobPath()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_todo()
endfunction()
