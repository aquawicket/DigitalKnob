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

################################################################################
# dk_fileToVariable(<path>, <var>:optional)
#
#
function(dk_fileToVariable)
	dk_debugFunc(1 2)

	set(file ${ARGV0})
	set(rtn_var ${ARGV1})
	file(READ "${file}" dk_fileToVariable)

	set(dk_fileToVariable ${dk_fileToVariable} PARENT_SCOPE)
	if(rtn_var)
		set(${rtn_var} ${dk_fileToVariable} PARENT_SCOPE)
	endif()
endfunction()



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)

	dk_fileToVariable("$ENV{DKCMAKE_FUNCTIONS_DIR_}fileToVariable.txt")
	dk_printVar(dk_fileToVariable)
	
	dk_fileToVariable("$ENV{DKCMAKE_FUNCTIONS_DIR_}fileToVariable.txt" myVar)
	dk_printVar(myVar)
endfunction()
