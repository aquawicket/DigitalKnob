#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

##############################################################################
# dk_isFunction(rtn_var function_name)
# 
#	Test if a string is a function name
#
#	@function_name	- The function_name to test
#	@rtn_var: 	- True if the string is the name of a function, False if otherwise.
#
function(dk_isFunction rtn_var)
	dk_debugFunc()
	
	set(${rtn_var} 0 PARENT_SCOPE)
	if(COMMAND "${ARGN}")
		get_directory_property(macros MACROS)
		if(NOT "${ARGN}" IN_LIST macros)
			set(${rtn_var} 1 PARENT_SCOPE)
		endif()
	endif()
endfunction()









###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(test_function)
	dk_echo("test_function body")
endfunction()

function(DKTEST)
	dk_debugFunc()
	
	dk_isFunction(isFunction "test_function")
	if(isFunction)
		dk_echo("'test_function' is a function")
	else()
		dk_echo("'test_function' is NOT a function")
	endif()
	
	dk_isFunction(isFunction "nonExistentFunction")
	if(isFunction)
		dk_echo("'nonExistentFunction' is a function")
	else()
		dk_echo("'nonExistentFunction' is NOT a function")
	endif()
endfunction()
