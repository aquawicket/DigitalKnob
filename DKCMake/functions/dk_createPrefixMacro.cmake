#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development


###############################################################################
# dk_createPrefixMacro(func prefix_list)
#
#	Prefix a function with <prefix_list>_ macros. Calling the <prefix>_function will only be called if the <prefix_list> are variable that evaluate to true.
#
#	@prefix	- The prefix to prepend to the function name.    I.E.    Test_MyFunction()
#	@func	- The func of the function to create aliases for
#
function(dk_createPrefixMacro func) #ARGN
	#dk_debugFunc()
	
	set(${ARGN})
	string(REPLACE ";" "_" prefix_name "${ARGN}")
	string(REPLACE ";" " AND " prefix_if "${ARGN}")
	set(MACRO_STRING "macro(${prefix_name}_${func})\n   if(${prefix_if})\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	
<<<<<<< HEAD
	if(CMAKE_VERSION VERSION_GREATER "3.18")
		cmake_language(EVAL CODE "${MACRO_STRING}")
	endif()
=======
	if(CMAKE_VERSION VERSION_GREATER_EQUAL "3.18")
		cmake_language(EVAL CODE "${MACRO_STRING}")
	endif()
	#dk_eval("${MACRO_STRING}")
>>>>>>> Development
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
=======
	dk_debugFunc(0)
>>>>>>> Development
	
	dk_todo()
endfunction()
