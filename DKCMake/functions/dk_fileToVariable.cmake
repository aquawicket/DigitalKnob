#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
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

	dk_fileToVariable("${DKCMAKE_FUNCTIONS_DIR_}fileToVariable.txt")
	dk_printVar(dk_fileToVariable)
	
	dk_fileToVariable("${DKCMAKE_FUNCTIONS_DIR_}fileToVariable.txt" myVar)
	dk_printVar(myVar)
endfunction()
