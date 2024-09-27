#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

##################################################################################
# dk_file_setDigitalknobPath()
#
#	Set the digitalknob root directory environment variable
#
function(dk_setDigitalknobPath)
	dk_debugFunc("\${ARGV}")
	
	
	# Set the DIGITALKNOB_DIR environment variable 
	dk_getFullPath(${CMAKE_SOURCE_DIR} path)
	string(FIND "${path}" "digitalknob" pos)
	string(SUBSTRING ${path} 0 ${pos} path)
	set(DIGITALKNOB_DIR ${path}digitalknob CACHE INTERNAL "")
	set(DKCMAKE_DIR ${DIGITALKNOB_DIR}/Development/DKCMake/ CACHE INTERNAL "")
	set(ENV{DIGITALKNOB_DIR} ${DIGITALKNOB_DIR})
	set(ENV{DKCMAKE_DIR} ${DKCMAKE_DIR})
	if(WIN_HOST)
		execute_process(COMMAND cmd /c setx DIGITALKNOB_DIR ${DIGITALKNOB_DIR})
		execute_process(COMMAND cmd /c setx DKCMAKE_DIR ${DKCMAKE_DIR})
	endif()
	#dk_printVar(DIGITALKNOB_DIR)
	#dk_printVar(DKCMAKE_DIR)
	#dk_printVar(ENV{DIGITALKNOB_DIR})
	#dk_printVar(ENV{DKCMAKE_DIR})
endfunction()
dk_setDigitalknobPath()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	dk_todo()
endfunction()
