#!/usr/bin/cmake -P
<<<<<<< HEAD
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
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

##############################################################################
# dk_isFunction(arg)
# 
#	Test if a string is a function
#
#	@arg			- The argument to test
#	@dk_isFunction 	- 1 if arg is a function, 0 if otherwise.
#
function(dk_isFunction)
	dk_debugFunc(1)
	
	dk_getArg(0 _arg0_)
	
	if(COMMAND "${_arg0_}")
		get_directory_property(macros MACROS)
		if(NOT "${_arg0_}" IN_LIST macros)
			set(dk_isFunction 1 PARENT_SCOPE)
		else()
			set(dk_isFunction 0 PARENT_SCOPE)
		endif()
	else()
		set(dk_isFunction 0 PARENT_SCOPE)
>>>>>>> Development
	endif()
endfunction()









###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(test_function)
	dk_echo("test_function body")
endfunction()

function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
	
	dk_isFunction(isFunction "test_function")
	if(isFunction)
=======
	dk_debugFunc(0)
	
	dk_isFunction("test_function")
	if(dk_isFunction)
>>>>>>> Development
		dk_echo("'test_function' is a function")
	else()
		dk_echo("'test_function' is NOT a function")
	endif()
	
<<<<<<< HEAD
	dk_isFunction(isFunction "nonExistentFunction")
	if(isFunction)
=======
	dk_isFunction("nonExistentFunction")
	if(dk_isFunction)
>>>>>>> Development
		dk_echo("'nonExistentFunction' is a function")
	else()
		dk_echo("'nonExistentFunction' is NOT a function")
	endif()
endfunction()
